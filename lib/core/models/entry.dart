class Entry {
  final String _date;
  final double dollars;

  Entry({required String date, required this.dollars}) : _date = date;

  /// Creates a blank Entry with a default date (epoch) and zero dollars.
  factory Entry.blank() {
    return Entry(
      date: DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      dollars: 0.0,
    );
  }

  DateTime get date => DateTime.parse(_date);
}
