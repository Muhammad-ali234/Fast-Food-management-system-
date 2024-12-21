import 'package:flutter/material.dart';
import '../../models/inventory_item.dart';

class InventoryList extends StatelessWidget {
  final List<InventoryItem> items; // Add this parameter
  final Function(String) onSearch; // Add this parameter
  final Function(String) onFilter; // Add this parameter
  final Function(InventoryItem) onEdit;

  const InventoryList({
    super.key,
    required this.items, // Update constructor
    required this.onSearch, // Update constructor
    required this.onFilter, // Update constructor
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
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
                      hintText: 'Search inventory...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: onSearch, // Use the passed callback
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: 'all',
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Items')),
                    DropdownMenuItem(value: 'low', child: Text('Low Stock')),
                    DropdownMenuItem(value: 'out', child: Text('Out of Stock')),
                  ],
                  onChanged: (value) {
                    if (value != null)
                      onFilter(value); // Use the passed callback
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('No items found'))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.inventory_2),
                            ),
                            title: Text(item.name),
                            subtitle: Text('Quantity: ${item.quantity} units'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // TODO: Add edit functionality
                                onEdit(item);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
