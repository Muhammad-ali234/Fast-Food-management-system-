// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/inventory_item.dart';
// import '../../providers/inventory_provider.dart';

// class AddInventoryItemDialog extends StatefulWidget {
//   const AddInventoryItemDialog({super.key});

//   @override
//   State<AddInventoryItemDialog> createState() => _AddInventoryItemDialogState();
// }

// class _AddInventoryItemDialogState extends State<AddInventoryItemDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _quantityController = TextEditingController();
//   final _minQuantityController = TextEditingController();
//   String _unit = 'units';

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Inventory Item'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Item Name'),
//               validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _quantityController,
//               decoration: const InputDecoration(labelText: 'Initial Quantity'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) return 'Required';
//                 if (double.tryParse(value!) == null) return 'Invalid quantity';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _unit,
//               decoration: const InputDecoration(labelText: 'Unit'),
//               items: ['units', 'kg', 'g', 'l', 'ml']
//                   .map((unit) => DropdownMenuItem(
//                         value: unit,
//                         child: Text(unit),
//                       ))
//                   .toList(),
//               onChanged: (value) => setState(() => _unit = value!),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _minQuantityController,
//               decoration: const InputDecoration(labelText: 'Minimum Quantity'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) return 'Required';
//                 if (double.tryParse(value!) == null) return 'Invalid quantity';
//                 return null;
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _saveInventoryItem,
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }

//   // void _saveInventoryItem() {
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     final item = InventoryItem(
//   //       id: 0,
//   //       name: _nameController.text,
//   //       quantity: double.parse(_quantityController.text),
//   //       unit: _unit,
//   //       minQuantity: double.parse(_minQuantityController.text),
//   //     );

//   //     context.read<InventoryProvider>().updateStock(
//   //           item.id,
//   //           item.quantity,
//   //           'In',
//   //         );
//   //     Navigator.pop(context);
//   //   }
//   // }

//   void _saveInventoryItem() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       try {
//         final newItem = InventoryItem(
//           id: 0, // Temporary; actual ID will be assigned by the database
//           name: _nameController.text,
//           quantity: double.parse(_quantityController.text),
//           unit: _unit,
//           minQuantity: double.parse(_minQuantityController.text),
//         );

//         // Save the new item to the database
//         final newItemId =
//             await context.read<InventoryProvider>().addItem(newItem);

//         // Update stock using the new item's ID
//         await context.read<InventoryProvider>().updateStock(
//               newItemId,
//               newItem.quantity,
//               'In',
//             );

//         Navigator.pop(context); // Close the dialog on success
//       } catch (e) {
//         debugPrint('Error saving inventory item: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to save item')),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _quantityController.dispose();
//     _minQuantityController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/inventory_item.dart';
import '../../providers/inventory_provider.dart';

class AddInventoryItemDialog extends StatefulWidget {
  final Function(InventoryItem)? onItemAdded;
  const AddInventoryItemDialog({super.key, this.onItemAdded});

  @override
  State<AddInventoryItemDialog> createState() => _AddInventoryItemDialogState();
}

class _AddInventoryItemDialogState extends State<AddInventoryItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minQuantityController = TextEditingController();
  String _unit = 'units';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Inventory Item'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Item Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter the item name'
                    : null,
              ),
              const SizedBox(height: 16),

              // Initial Quantity
              TextFormField(
                controller: _quantityController,
                decoration:
                    const InputDecoration(labelText: 'Initial Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter a quantity';
                  if (double.tryParse(value!) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Unit
              DropdownButtonFormField<String>(
                value: _unit,
                decoration: const InputDecoration(labelText: 'Unit'),
                items: ['units', 'kg', 'g', 'l', 'ml']
                    .map((unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _unit = value!),
              ),
              const SizedBox(height: 16),

              // Minimum Quantity
              TextFormField(
                controller: _minQuantityController,
                decoration:
                    const InputDecoration(labelText: 'Minimum Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a minimum quantity';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        // Save Button
        ElevatedButton(
          onPressed: _saveInventoryItem,
          child: const Text('Save'),
        ),
      ],
    );
  }

  /// Method to save the inventory item
  // void _saveInventoryItem() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     try {
  //       final newItem = InventoryItem(
  //         id: 0, // Temporary ID; actual ID will be assigned by the database
  //         name: _nameController.text.trim(),
  //         quantity: double.parse(_quantityController.text.trim()),
  //         unit: _unit,
  //         minQuantity: double.parse(_minQuantityController.text.trim()),
  //       );

  //       // Add the new item using the provider
  //       final newItemId =
  //           await context.read<InventoryProvider>().addItem(newItem);

  //       // Update stock with the newly added item's ID
  //       await context.read<InventoryProvider>().updateStock(
  //             newItemId,
  //             newItem.quantity,
  //             'In',
  //           );

  //       // Close the dialog on success
  //       Navigator.pop(context);

  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Item "${newItem.name}" added successfully!')),
  //       );
  //     } catch (e) {
  //       debugPrint('Error saving inventory item: $e');

  //       // Show error message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to save item.')),
  //       );
  //     }
  //   }
  // }

  void _saveInventoryItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final newItem = InventoryItem(
          id: 0,
          name: _nameController.text.trim(),
          quantity: double.parse(_quantityController.text),
          unit: _unit,
          minQuantity: double.parse(_minQuantityController.text),
        );

        final newItemId =
            await context.read<InventoryProvider>().addItem(newItem);
        await context.read<InventoryProvider>().updateStock(
              newItemId,
              newItem.quantity,
              'In',
            );

        // Trigger the onItemAdded callback
        widget.onItemAdded?.call(newItem);

        Navigator.pop(context); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully!')),
        );
      } catch (e) {
        debugPrint('Error saving inventory item: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save item: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _minQuantityController.dispose();
    super.dispose();
  }
}
