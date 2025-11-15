class StockModel {
  final int? id;
  final String type;
  final int quantityTotal;
  final int quantityRemaining;
  final double pricePerUnit;
  final int lowStockThreshold; // Add this if you want to use it

  StockModel({
    this.id,
    required this.type,
    required this.quantityTotal,
    required this.quantityRemaining,
    required this.pricePerUnit,
    this.lowStockThreshold = 0, // Default value
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meat_type': type,
      'quantity_total': quantityTotal,
      'quantity_remaining': quantityRemaining,
      'unit_price': pricePerUnit, // ← Changed to 'unit_price'
      'low_stock_threshold': lowStockThreshold,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'],
      type: map['meat_type'] ?? '',
      quantityTotal: map['quantity_total'] ?? 0,
      quantityRemaining: map['quantity_remaining'] ?? 0,
      pricePerUnit: (map['unit_price'] ?? 0).toDouble(), // ← Changed to 'unit_price'
      lowStockThreshold: map['low_stock_threshold'] ?? 0,
    );
  }
}