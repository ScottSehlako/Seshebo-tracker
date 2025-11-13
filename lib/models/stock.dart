class StockModel {
  final int? id;
  final String type; // Meat type
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

  // Convert to Map (for inserting/updating in DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meat_type': type,
      'quantity_total': quantityTotal,
      'quantity_remaining': quantityRemaining,
      'price_per_unit': pricePerUnit,
    };
  }

  // Create StockModel from Map (DB query)
  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'],
      type: map['meat_type'] ?? '',
      quantityTotal: map['quantity_total'] ?? 0,
      quantityRemaining: map['quantity_remaining'] ?? 0,
      pricePerUnit: (map['price_per_unit'] ?? 0).toDouble(),
    );
  }
}
