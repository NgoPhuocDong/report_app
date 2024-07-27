class DoanhThuItem {
  final double value;
  final String title;

  DoanhThuItem({required this.value, required this.title});

  factory DoanhThuItem.fromJson(Map<String, dynamic> json) {
    return DoanhThuItem(
      value: json['value'] is num ? (json['value'] as num).toDouble() : 0.0,
      title: json['title'] as String? ?? '',
    );
  }
}