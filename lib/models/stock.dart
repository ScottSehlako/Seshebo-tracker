class StockModel {
  final int? id;
  final String type;
  final int quantityTotal;
  final int quantityRemaining;
  final double pricePerUnit;

  StockModel({
    this.id,
    required this.type,
    required this.quantityTotal,
    required this.quantityRemaining,
    required this.pricePerUnit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'quantity_total': quantityTotal,
      'quantity_remaining': quantityRemaining,
      'price_per_unit': pricePerUnit,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] as int?,
      type: map['type'] ?? '',
      quantityTotal: map['quantity_total'] ?? 0,
      quantityRemaining: map['quantity_remaining'] ?? 0,
      pricePerUnit: (map['price_per_unit'] ?? 0).toDouble(),
    );
  }
}
