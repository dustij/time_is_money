double calculateRatePerSecond(double hourlyRate) {
  return hourlyRate / 3600;
}

String convertWeekday(int weekday) {
  return switch (weekday) {
    1 => "MON",
    2 => "TUE",
    3 => "WED",
    4 => "THU",
    5 => "FRI",
    6 => "SAT",
    7 => "SUN",
    _ => throw ArgumentError("Invalid weekday: $weekday"),
  };
}
