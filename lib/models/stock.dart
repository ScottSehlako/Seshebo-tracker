class Stock {
  final int? id;
  final String meatType;
  final int quantityTotal;
  final int quantityRemaining;
  final double unitPrice;
  final int lowStockThreshold;

  Stock({
    this.id,
    required this.meatType,
    required this.quantityTotal,
    required this.quantityRemaining,
    required this.unitPrice,
    this.lowStockThreshold = 5,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meat_type': meatType,
      'quantity_total': quantityTotal,
      'quantity_remaining': quantityRemaining,
      'unit_price': unitPrice,
      'low_stock_threshold': lowStockThreshold,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map['id'],
      meatType: map['meat_type'],
      quantityTotal: map['quantity_total'],
      quantityRemaining: map['quantity_remaining'],
      unitPrice: map['unit_price']?.toDouble(),
      lowStockThreshold: map['low_stock_threshold'] ?? 5,
    );
  }
}
