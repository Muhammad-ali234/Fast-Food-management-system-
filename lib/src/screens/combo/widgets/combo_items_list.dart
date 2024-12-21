import 'package:flutter/material.dart';
import '../../../models/combo.dart';

class ComboItemsController {
  final List<ComboItem> _items = [];

  List<ComboItem> get items => _items;

  void addItem(ComboItem item) {
    _items.add(item);
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }
}

class ComboItemsList extends StatefulWidget {
  final ComboItemsController controller;

  const ComboItemsList({super.key, required this.controller});

  @override
  _ComboItemsListState createState() => _ComboItemsListState();
}

class _ComboItemsListState extends State<ComboItemsList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Combo Items',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FilledButton.icon(
                  onPressed: () => _showAddItemDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.controller.items.isEmpty)
              const Center(
                child: Text('No items added yet'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.controller.items.length,
                itemBuilder: (context, index) {
                  final item = widget.controller.items[index];
                  return ListTile(
                    title: Text('Menu Item #${item.menuItemId}'),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.controller.removeItem(index);
                        });
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-menu-item');
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        widget.controller.addItem(ComboItem(
          menuItemId: result['menuItemId'],
          quantity: result['quantity'],
        ));
      });
    }
  }
}
