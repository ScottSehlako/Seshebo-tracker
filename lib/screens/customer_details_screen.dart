import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '../models/stock.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;
  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<OrderModel> _orders = [];
  List<StockModel> _stockItems = [];

  @override
  void initState() {
    super.initState();
    _loadCustomerOrders();
  }

  Future<void> _loadCustomerOrders() async {
    final db = await _dbHelper.database;
    final orderResult = await db.query(
      'orders',
      where: 'customer_id = ?',
      whereArgs: [widget.customer.id],
      orderBy: 'date DESC',
    );
    final stockResult = await db.query('stock');

    setState(() {
      _orders = orderResult.map((e) => OrderModel.fromMap(e)).toList();
      _stockItems = stockResult.map((e) => StockModel.fromMap(e)).toList();
    });
  }

  Future<void> _deleteOrder(int id) async {
    await _dbHelper.delete('orders', 'id = ?', [id]);
    _loadCustomerOrders();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.customer;
    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Card(
            color: Colors.grey[100],
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title:
                  Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (c.phone != null && c.phone!.isNotEmpty) Text('📞 ${c.phone}'),
                  if (c.address != null && c.address!.isNotEmpty) Text('📍 ${c.address}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: _orders.isEmpty
                ? const Center(child: Text('No orders yet'))
                : ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      final stock = _stockItems.firstWhere(
                        (s) => s.id == order.stockId,
                        orElse: () => StockModel(
                          type: 'Unknown',
                          quantityTotal: 0,
                          quantityRemaining: 0,
                          pricePerUnit: 0.0,
                        ),
                      );
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 2,
                        child: ListTile(
                          title: Text('${stock.type}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Qty: ${order.quantity}'),
                              Text('Total: R${order.total.toStringAsFixed(2)}'),
                              Text('Date: ${order.date.split("T").first}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _deleteOrder(order.id!),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
