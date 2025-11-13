class OrderModel {
  final int? id;
  final int customerId;
  final int stockId;
  final int quantity;
  final double price;      // Add this
  final double total;      // Add this
  final String date;       // Add this
  final bool paid;
  final bool delivered;

  OrderModel({
    this.id,
    required this.customerId,
    required this.stockId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.date,
    this.paid = false,
    this.delivered = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'stock_id': stockId,
      'quantity': quantity,
      'price': price,
      'total': total,
      'date': date,
      'paid': paid ? 1 : 0,
      'delivered': delivered ? 1 : 0,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      customerId: map['customer_id'],
      stockId: map['stock_id'],
      quantity: map['quantity'],
      price: (map['price'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      date: map['date'] ?? '',
      paid: (map['paid'] ?? 0) == 1,
      delivered: (map['delivered'] ?? 0) == 1,
    );
  }
}
