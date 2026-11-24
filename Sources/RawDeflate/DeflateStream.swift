package import Foundation
import zlib

/// Raw DEFLATE streams, with no zlib or gzip wrapper, over the system's zlib.
package enum DeflateStream {
  /// zlib counts bytes in 32 bits, so longer buffers go through in pieces.
  private static let step = 1 << 30

  private enum Outcome {
    case finished(produced: Int, consumed: Int)
    case failed(DeflateError)
  }

  /// Compresses bytes at the library's default level.
  package static func deflate(_ source: Data) throws(DeflateError) -> Data {
    var stream = unsafe z_stream()
    let started = unsafe deflateInit2_(
      &stream, Z_DEFAULT_COMPRESSION, Z_DEFLATED, -MAX_WBITS, 8, Z_DEFAULT_STRATEGY, ZLIB_VERSION,
      Int32(MemoryLayout<z_stream>.size))
    guard started == Z_OK else { throw .unavailable(status: started) }
    defer { _ = unsafe deflateEnd(&stream) }
    var target = unsafe Data(count: Int(deflateBound(&stream, UInt(source.count))))
    let outcome: Outcome = unsafe source.withUnsafeBytes { input in
      unsafe target.withUnsafeMutableBytes { output in
        var consumed = 0
        var produced = 0
        while true {
          let offered = min(input.count - consumed, step)
          let room = min(output.count - produced, step)
          unsafe stream.next_in = unsafe UnsafeMutablePointer(mutating: start(of: input, at: consumed))
          unsafe stream.avail_in = UInt32(offered)
          unsafe stream.next_out = unsafe UnsafeMutablePointer(
            mutating: start(of: UnsafeRawBufferPointer(output), at: produced))
          unsafe stream.avail_out = UInt32(room)
          let status = unsafe zlib.deflate(&stream, consumed + offered == input.count ? Z_FINISH : Z_NO_FLUSH)
          consumed += unsafe offered - Int(stream.avail_in)
          produced += unsafe room - Int(stream.avail_out)
          if status == Z_STREAM_END { return .finished(produced: produced, consumed: consumed) }
          guard status == Z_OK, produced < output.count else { return .failed(.corrupt(status: status)) }
        }
      }
    }
    switch outcome {
    case .finished(let produced, _):
      target.count = produced
      return target
    case .failed(let error):
      throw error
    }
  }

  /// Expands a stream that the caller knows to hold exactly `count` bytes.
  ///
  /// The size is checked as the stream runs, so a stream that holds more than it declares stops there.
  package static func inflate(_ source: Data, count: Int) throws(DeflateError) -> Data {
    var stream = unsafe z_stream()
    let started = unsafe inflateInit2_(&stream, -MAX_WBITS, ZLIB_VERSION, Int32(MemoryLayout<z_stream>.size))
    guard started == Z_OK else { throw .unavailable(status: started) }
    defer { _ = unsafe inflateEnd(&stream) }
    // One byte beyond the declared size tells a longer stream from an exact one.
    var target = Data(count: count + 1)
    let outcome: Outcome = unsafe source.withUnsafeBytes { input in
      unsafe target.withUnsafeMutableBytes { output in
        var consumed = 0
        var produced = 0
        while true {
          let offered = min(input.count - consumed, step)
          let room = min(output.count - produced, step)
          unsafe stream.next_in = unsafe UnsafeMutablePointer(mutating: start(of: input, at: consumed))
          unsafe stream.avail_in = UInt32(offered)
          unsafe stream.next_out = unsafe UnsafeMutablePointer(
            mutating: start(of: UnsafeRawBufferPointer(output), at: produced))
          unsafe stream.avail_out = UInt32(room)
          let status = unsafe zlib.inflate(&stream, Z_NO_FLUSH)
          let taken = unsafe offered - Int(stream.avail_in)
          let given = unsafe room - Int(stream.avail_out)
          consumed += taken
          produced += given
          if status == Z_STREAM_END { return .finished(produced: produced, consumed: consumed) }
          if produced == output.count { return .failed(.sizeMismatch(expected: count)) }
          if status == Z_BUF_ERROR || status == Z_OK && taken == 0 && given == 0 { return .failed(.truncated) }
          guard status == Z_OK else { return .failed(.corrupt(status: status)) }
        }
      }
    }
    switch outcome {
    case .finished(let produced, let consumed):
      guard produced == count else { throw .sizeMismatch(expected: count) }
      guard consumed == source.count else { throw .trailingBytes }
      target.count = count
      return target
    case .failed(let error):
      throw error
    }
  }

  private static func start(of buffer: UnsafeRawBufferPointer, at offset: Int) -> UnsafePointer<UInt8>? {
    unsafe buffer.baseAddress.map { unsafe ($0 + offset).assumingMemoryBound(to: UInt8.self) }
  }
}
