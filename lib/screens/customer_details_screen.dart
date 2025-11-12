import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/customer.dart';
import '../models/order.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;
  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<OrderModel> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadCustomerOrders();
  }

  Future<void> _loadCustomerOrders() async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'orders',
      where: 'customer_id = ?',
      whereArgs: [widget.customer.id],
      orderBy: 'date DESC',
    );
    setState(() {
      _orders = result.map((e) => OrderModel.fromMap(e)).toList();
    });
  }

  Future<void> _addOrder() async {
    final qtyController = TextEditingController();
    final priceController = TextEditingController();
    final stockIdController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: stockIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stock ID'),
            ),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per Unit'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final quantity = int.tryParse(qtyController.text) ?? 0;
              final price = double.tryParse(priceController.text) ?? 0.0;
              final total = quantity * price;

              final order = OrderModel(
                customerId: widget.customer.id!,
                stockId: int.tryParse(stockIdController.text) ?? 0,
                quantity: quantity,
                price: price,
                total: total,
                date: DateTime.now().toIso8601String(),
              );

              await _dbHelper.insert('orders', order.toMap());
              Navigator.pop(context);
              _loadCustomerOrders();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
          // Customer info card
          Card(
            color: Colors.grey[100],
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (c.phone != null && c.phone!.isNotEmpty) Text('📞 ${c.phone}'),
                  if (c.address != null && c.address!.isNotEmpty) Text('📍 ${c.address}'),
                ],
              ),
            ),
          ),

          // Orders section
          Expanded(
            child: _orders.isEmpty
                ? const Center(child: Text('No orders yet'))
                : ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 2,
                        child: ListTile(
                          title: Text('Order #${order.id ?? '-'}'),
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
                            onPressed: () async => _deleteOrder(order.id!),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOrder,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
