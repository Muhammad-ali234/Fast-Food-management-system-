import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import '../../utils/date_utils.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Orders',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, provider, child) {
                  final orders = provider.orders.take(5).toList();

                  if (orders.isEmpty) {
                    return const Center(
                      child: Text('No recent orders'),
                    );
                  }

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getStatusColor(order.status),
                            child:
                                const Icon(Icons.receipt, color: Colors.white),
                          ),
                          title: Text('Order #${order.id}'),
                          subtitle: Text(
                            '${order.customerName} - ${order.orderType}\n'
                            '\$${order.totalAmount.toStringAsFixed(2)}',
                          ),
                          trailing: Chip(
                            label: Text(order.status),
                            backgroundColor:
                                _getStatusColor(order.status).withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: _getStatusColor(order.status),
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
