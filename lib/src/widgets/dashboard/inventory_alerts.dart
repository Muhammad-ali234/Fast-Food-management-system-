import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/inventory_item.dart';
import '../../providers/inventory_provider.dart';

class InventoryAlerts extends StatelessWidget {
  const InventoryAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory Alerts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<InventoryProvider>(
                builder: (context, provider, child) {
                  final lowStockItems = provider.lowStockItems;

                  if (lowStockItems.isEmpty) {
                    return const Center(
                      child: Text('No inventory alerts'),
                    );
                  }

                  return ListView.builder(
                    itemCount: lowStockItems.length,
                    itemBuilder: (context, index) {
                      final item = lowStockItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.red.shade50,
                        child: ListTile(
                          leading: Icon(
                            Icons.warning,
                            color: Colors.red.shade700,
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                            'Current: ${item.quantity} ${item.unit}\n'
                            'Minimum: ${item.minQuantity} ${item.unit}',
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              _showRestockDialog(context, item);
                            },
                            child: const Text('Restock'),
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

  void _showRestockDialog(BuildContext context, InventoryItem item) {
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Restock ${item.name}'),
        content: TextField(
          controller: quantityController,
          decoration: InputDecoration(
            labelText: 'Quantity to add (${item.unit})',
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = double.tryParse(quantityController.text);
              if (quantity != null && quantity > 0) {
                context.read<InventoryProvider>().updateStock(
                      item.id,
                      quantity,
                      'In',
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Restock'),
          ),
        ],
      ),
    );
  }
}
