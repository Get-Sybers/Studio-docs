import Appearance
import Testing
import TextModel
import WireFormat

@Suite struct LayoutTests {
  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    print(
      "SIZES", MemoryLayout<CharacterProperties>.size, MemoryLayout<ParagraphProperties>.size,
      MemoryLayout<Paragraph>.size, MemoryLayout<TextRun>.size, MemoryLayout<ParagraphContent>.size,
      MemoryLayout<Fill>.size, MemoryLayout<ObjectEnvelope>.size)
    #expect(MemoryLayout<CharacterProperties>.size <= 512)
    #expect(MemoryLayout<ParagraphProperties>.size <= 1024)
    #expect(MemoryLayout<Paragraph>.size <= 2048)
    #expect(MemoryLayout<ParagraphContent>.size <= 256)
  }
}
