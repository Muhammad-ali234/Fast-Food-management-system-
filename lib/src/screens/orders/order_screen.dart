import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/order_provider.dart';
import '../../widgets/orders/new_order_dialog.dart';
import '../../widgets/side_menu.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  void _showOrderDetailsDialog(
      BuildContext context, Order order, OrderProvider orderProvider) {
    final statuses = ['Pending', 'In Progress', 'Completed']; // Status options
    String selectedStatus = order.status; // Initial status

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order #${order.id}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer: ${order.customerName}'),
                const SizedBox(height: 8),
                Text('Phone: ${order.customerPhone}'),
                const SizedBox(height: 8),
                Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                Text('Order Type: ${order.orderType}'),
                const SizedBox(height: 8),
                const Text('Items:'),
                ...order.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '- Item ID: ${item.menuItemId}, Quantity: ${item.quantity}, Price: \$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }),
                const Divider(),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  items: statuses
                      .map((status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedStatus = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Update Status',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the status in the provider
                orderProvider.updateOrderStatus(order.id, selectedStatus);
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Orders',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                         // new order 
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('New Order'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        if (orderProvider.orders.isEmpty) {
                          // Trigger data load if empty
                          orderProvider.loadOrders();
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: 'Search orders...',
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        onChanged: (value) {
                                          // TODO: Implement search
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    DropdownButton<String>(
                                      value: 'all',
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'all',
                                          child: Text('All Orders'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'pending',
                                          child: Text('Pending'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'in_progress',
                                          child: Text('In Progress'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'completed',
                                          child: Text('Completed'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        // TODO: Implement filter
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: orderProvider.orders.length,
                                    itemBuilder: (context, index) {
                                      final order = orderProvider.orders[index];
                                      return Card(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        child: ListTile(
                                          leading: const CircleAvatar(
                                            child: Icon(Icons.receipt),
                                          ),
                                          title: Text('Order #${order.id}'),
                                          subtitle: Text(
                                            'Customer: ${order.customerName}\nTotal: \$${order.totalAmount.toStringAsFixed(2)}',
                                          ),
                                          trailing: Chip(
                                            label: Text(order.status),
                                            backgroundColor: order.status ==
                                                    'Pending'
                                                ? Colors.orange.shade100
                                                : order.status == 'Completed'
                                                    ? Colors.green.shade100
                                                    : Colors.blue.shade100,
                                            labelStyle: TextStyle(
                                              color: order.status == 'Pending'
                                                  ? Colors.orange.shade900
                                                  : order.status == 'Completed'
                                                      ? Colors.green.shade900
                                                      : Colors.blue.shade900,
                                            ),
                                          ),
                                          onTap: () {
                                            // TODO: Navigate to order details
                                            _showOrderDetailsDialog(
                                                context, order, orderProvider);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
