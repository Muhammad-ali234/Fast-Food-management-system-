// lib/src/screens/combo/widgets/combo_items_selector.dart
import 'package:ffms/src/screens/combo/widgets/combo_items_list.dart';
import 'package:flutter/material.dart';
import '../../../models/combo.dart';
import 'package:provider/provider.dart';

import '../../../providers/menu_provider.dart';

// class ComboItemsController {
//   final List<ComboItem> _items = [];

//   List<ComboItem> get items => _items;

//   void addItem(ComboItem item) {
//     _items.add(item);
//   }

//   void removeItem(int index) {
//     _items.removeAt(index);
//   }
// }

// class ComboItemsSelector extends StatefulWidget {
//   final ComboItemsController controller;

//   const ComboItemsSelector({super.key, required this.controller});

//   @override
//   State<ComboItemsSelector> createState() => _ComboItemsSelectorState();
// }

// class _ComboItemsSelectorState extends State<ComboItemsSelector> {
//   final List<OrderItem> _items = [];
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Combo Items',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 ElevatedButton.icon(
//                   onPressed:
//                       // _showMenuItemSelector,

//                       () {

//                     _showAddItemDialog;
//                   },
//                   icon: const Icon(Icons.add),
//                   label: const Text('Add Item'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: widget.controller.items.isEmpty
//                   ? const Center(
//                       child: Text('No items added to combo yet'),
//                     )
//                   : ListView.builder(
//                       itemCount: widget.controller.items.length,
//                       itemBuilder: (context, index) {
//                         final item = widget.controller.items[index];
//                         return ListTile(
//                           title: Text('Item #${item.menuItemId}'),
//                           subtitle: Text('Quantity: ${item.quantity}'),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               setState(() {
//                                 widget.controller.removeItem(index);
//                               });
//                             },
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddItemDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Consumer<MenuProvider>(
//         builder: (context, menuProvider, child) {
//           final items = menuProvider.items; // Use the `items` getter directly
//           return AlertDialog(
//             title: const Text('Add Item'),
//             content: SizedBox(
//               width: 300,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   DropdownButtonFormField<int>(
//                     decoration: const InputDecoration(labelText: 'Item'),
//                     items: items
//                         .map((item) => DropdownMenuItem(
//                               value: item.id,
//                               child: Text(item.name),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       if (value != null) {
//                         final item = items.firstWhere((i) => i.id == value);
//                         setState(() {
//                           _items.add(OrderItem(
//                             menuItemId: item.id,
//                             quantity: 1,
//                             price: item.price,
//                           ));

//                         });
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ComboItemsSelector extends StatefulWidget {
  final ComboItemsController controller;

  const ComboItemsSelector({super.key, required this.controller});

  @override
  State<ComboItemsSelector> createState() => _ComboItemsSelectorState();
}

class _ComboItemsSelectorState extends State<ComboItemsSelector> {
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
                ElevatedButton.icon(
                  onPressed: _showAddItemDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: widget.controller.items.isEmpty
                  ? const Center(
                      child: Text('No items added to combo yet'),
                    )
                  : ListView.builder(
                      itemCount: widget.controller.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.controller.items[index];
                        return ListTile(
                          title: Text('Item ID: ${item.menuItemId}'),
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
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          final items = menuProvider.items;
          if (items.isEmpty) {
            return AlertDialog(
              title: const Text('No Items Available'),
              content: const Text('Please add items to the menu first.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          }

          return AlertDialog(
            title: const Text('Add Item'),
            content: SizedBox(
              width: 300,
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Item'),
                items: items
                    .map((item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(item.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    final item = items.firstWhere((i) => i.id == value);
                    setState(() {
                      widget.controller.addItem(ComboItem(
                        menuItemId: item.id,
                        quantity: 1,
                        // price: item.price,
                      ));
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
