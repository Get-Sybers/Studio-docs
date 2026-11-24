public import WireFormat

/// The enumeration `PredicateType` of the format.
public struct PredicateType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `date_after_relative`.
  public static let dateAfterRelative = PredicateType(rawValue: "date_after_relative")
  /// The value `date_before_relative`.
  public static let dateBeforeRelative = PredicateType(rawValue: "date_before_relative")
  /// The value `date_between_relative`.
  public static let dateBetweenRelative = PredicateType(rawValue: "date_between_relative")
  /// The value `date_in_this`.
  public static let dateInThis = PredicateType(rawValue: "date_in_this")
  /// The value `date_is_after`.
  public static let dateIsAfter = PredicateType(rawValue: "date_is_after")
  /// The value `date_is_before`.
  public static let dateIsBefore = PredicateType(rawValue: "date_is_before")
  /// The value `date_is_between`.
  public static let dateIsBetween = PredicateType(rawValue: "date_is_between")
  /// The value `date_is_exactly`.
  public static let dateIsExactly = PredicateType(rawValue: "date_is_exactly")
  /// The value `date_is_in_the_last`.
  public static let dateIsInTheLast = PredicateType(rawValue: "date_is_in_the_last")
  /// The value `date_is_in_the_next`.
  public static let dateIsInTheNext = PredicateType(rawValue: "date_is_in_the_next")
  /// The value `date_is_the_date`.
  public static let dateIsTheDate = PredicateType(rawValue: "date_is_the_date")
  /// The value `date_is_today`.
  public static let dateIsToday = PredicateType(rawValue: "date_is_today")
  /// The value `date_is_tomorrow`.
  public static let dateIsTomorrow = PredicateType(rawValue: "date_is_tomorrow")
  /// The value `date_is_yesterday`.
  public static let dateIsYesterday = PredicateType(rawValue: "date_is_yesterday")
  /// The value `distincts`.
  public static let distincts = PredicateType(rawValue: "distincts")
  /// The value `duplicates`.
  public static let duplicates = PredicateType(rawValue: "duplicates")
  /// The value `duration_above_average`.
  public static let durationAboveAverage = PredicateType(rawValue: "duration_above_average")
  /// The value `duration_below_average`.
  public static let durationBelowAverage = PredicateType(rawValue: "duration_below_average")
  /// The value `duration_bottom`.
  public static let durationBottom = PredicateType(rawValue: "duration_bottom")
  /// The value `duration_is_between`.
  public static let durationIsBetween = PredicateType(rawValue: "duration_is_between")
  /// The value `duration_is_equal`.
  public static let durationIsEqual = PredicateType(rawValue: "duration_is_equal")
  /// The value `duration_is_greater_than`.
  public static let durationIsGreaterThan = PredicateType(rawValue: "duration_is_greater_than")
  /// The value `duration_is_greater_than_or_equal`.
  public static let durationIsGreaterThanOrEqual = PredicateType(rawValue: "duration_is_greater_than_or_equal")
  /// The value `duration_is_less_than`.
  public static let durationIsLessThan = PredicateType(rawValue: "duration_is_less_than")
  /// The value `duration_is_less_than_or_equal`.
  public static let durationIsLessThanOrEqual = PredicateType(rawValue: "duration_is_less_than_or_equal")
  /// The value `duration_is_not_between`.
  public static let durationIsNotBetween = PredicateType(rawValue: "duration_is_not_between")
  /// The value `duration_is_not_equal`.
  public static let durationIsNotEqual = PredicateType(rawValue: "duration_is_not_equal")
  /// The value `duration_top`.
  public static let durationTop = PredicateType(rawValue: "duration_top")
  /// The value `formula`.
  public static let formula = PredicateType(rawValue: "formula")
  /// The value `in_list`.
  public static let inList = PredicateType(rawValue: "in_list")
  /// The value `is_blank`.
  public static let isBlank = PredicateType(rawValue: "is_blank")
  /// The value `is_checked`.
  public static let isChecked = PredicateType(rawValue: "is_checked")
  /// The value `is_false`.
  public static let isFalse = PredicateType(rawValue: "is_false")
  /// The value `is_negative`.
  public static let isNegative = PredicateType(rawValue: "is_negative")
  /// The value `is_not_blank`.
  public static let isNotBlank = PredicateType(rawValue: "is_not_blank")
  /// The value `is_not_checked`.
  public static let isNotChecked = PredicateType(rawValue: "is_not_checked")
  /// The value `is_positive`.
  public static let isPositive = PredicateType(rawValue: "is_positive")
  /// The value `is_true`.
  public static let isTrue = PredicateType(rawValue: "is_true")
  /// The value `not_in_list`.
  public static let notInList = PredicateType(rawValue: "not_in_list")
  /// The value `pivot_source_filtered_for_column`.
  public static let pivotSourceFilteredForColumn = PredicateType(rawValue: "pivot_source_filtered_for_column")
  /// The value `pivot_source_filtered_for_row`.
  public static let pivotSourceFilteredForRow = PredicateType(rawValue: "pivot_source_filtered_for_row")
  /// The value `text_begins_with`.
  public static let textBeginsWith = PredicateType(rawValue: "text_begins_with")
  /// The value `text_contains`.
  public static let textContains = PredicateType(rawValue: "text_contains")
  /// The value `text_does_not_contain`.
  public static let textDoesNotContain = PredicateType(rawValue: "text_does_not_contain")
  /// The value `text_ends_with`.
  public static let textEndsWith = PredicateType(rawValue: "text_ends_with")
  /// The value `text_is`.
  public static let textIs = PredicateType(rawValue: "text_is")
  /// The value `text_is_not`.
  public static let textIsNot = PredicateType(rawValue: "text_is_not")
  /// The value `text_not_ends_with`.
  public static let textNotEndsWith = PredicateType(rawValue: "text_not_ends_with")
  /// The value `text_not_starts_with`.
  public static let textNotStartsWith = PredicateType(rawValue: "text_not_starts_with")
  /// The value `uniques`.
  public static let uniques = PredicateType(rawValue: "uniques")
  /// The value `value_above_average`.
  public static let valueAboveAverage = PredicateType(rawValue: "value_above_average")
  /// The value `value_below_average`.
  public static let valueBelowAverage = PredicateType(rawValue: "value_below_average")
  /// The value `value_between`.
  public static let valueBetween = PredicateType(rawValue: "value_between")
  /// The value `value_bottom`.
  public static let valueBottom = PredicateType(rawValue: "value_bottom")
  /// The value `value_equal`.
  public static let valueEqual = PredicateType(rawValue: "value_equal")
  /// The value `value_greater_than`.
  public static let valueGreaterThan = PredicateType(rawValue: "value_greater_than")
  /// The value `value_greater_than_or_equal`.
  public static let valueGreaterThanOrEqual = PredicateType(rawValue: "value_greater_than_or_equal")
  /// The value `value_less_than`.
  public static let valueLessThan = PredicateType(rawValue: "value_less_than")
  /// The value `value_less_than_or_equal`.
  public static let valueLessThanOrEqual = PredicateType(rawValue: "value_less_than_or_equal")
  /// The value `value_not_between`.
  public static let valueNotBetween = PredicateType(rawValue: "value_not_between")
  /// The value `value_not_equal`.
  public static let valueNotEqual = PredicateType(rawValue: "value_not_equal")
  /// The value `value_top`.
  public static let valueTop = PredicateType(rawValue: "value_top")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "PredicateType").map(PredicateType.init(rawValue:))
}
