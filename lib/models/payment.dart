class Payment {
  final int? id;
  final int orderId;
  final double amount;
  final String method;
  final String date;

  Payment({
    this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'amount': amount,
      'method': method,
      'date': date,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      orderId: map['order_id'],
      amount: map['amount']?.toDouble(),
      method: map['method'],
      date: map['date'],
    );
  }
}
