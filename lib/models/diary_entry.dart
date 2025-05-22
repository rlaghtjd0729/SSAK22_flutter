class DiaryEntry {
  final String date;
  final String memo;

  DiaryEntry({required this.date, required this.memo});

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      date: json['date'],
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'memo': memo,
    };
  }
}
