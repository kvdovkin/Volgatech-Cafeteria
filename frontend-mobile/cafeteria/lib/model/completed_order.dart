class CompletedOrder {
  final int id;
  final DateTime dateTime;
  final int totalCost;

  const CompletedOrder(
      {required this.id, required this.dateTime, required this.totalCost});

  factory CompletedOrder.fromJson(Map<String, dynamic> json) {
    return CompletedOrder(
      id: json['id'] as int,
      dateTime: DateTime.parse(json['datetime'] as String),
      totalCost: json['totalCost'] as int,
    );
  }
}
