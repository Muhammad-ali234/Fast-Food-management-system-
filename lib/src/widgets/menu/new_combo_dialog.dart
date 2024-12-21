import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/menu_provider.dart';

class NewComboDialog extends StatefulWidget {
  const NewComboDialog({super.key});

  @override
  State<NewComboDialog> createState() => _NewComboDialogState();
}

class _NewComboDialogState extends State<NewComboDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final List<Map<String, dynamic>> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Combo'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Combo Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  if (double.tryParse(value!) == null) return 'Invalid price';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _showAddItemDialog,
                child: const Text('Add Item to Combo'),
              ),
              if (_selectedItems.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Selected Items:'),
                const SizedBox(height: 8),
                ...List.generate(_selectedItems.length, (index) {
                  final item = _selectedItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() => _selectedItems.removeAt(index));
                      },
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveCombo,
          child: const Text('Create Combo'),
        ),
      ],
    );
  }

  // void _showAddItemDialog() {
  //   final quantityController = TextEditingController(text: '1');

  //   showDialog(
  //     context: context,
  //     builder: (context) => Consumer<MenuProvider>(
  //       builder: (context, menuProvider, child) {
  //         final items = menuProvider.state.items;
  //         return AlertDialog(
  //           title: const Text('Add Item to Combo'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               DropdownButtonFormField<int>(
  //                 decoration: const InputDecoration(labelText: 'Item'),
  //                 items: items
  //                     .map((item) => DropdownMenuItem(
  //                           value: item.id,
  //                           child: Text(item.name),
  //                         ))
  //                     .toList(),
  //                 onChanged: (value) {
  //                   if (value != null) {
  //                     final item = items.firstWhere((i) => i.id == value);
  //                     final quantity =
  //                         int.tryParse(quantityController.text) ?? 1;
  //                     setState(() {
  //                       _selectedItems.add({
  //                         'id': item.id,
  //                         'name': item.name,
  //                         'quantity': quantity,
  //                       });
  //                     });
  //                     Navigator.pop(context);
  //                   }
  //                 },
  //               ),
  //               const SizedBox(height: 16),
  //               TextFormField(
  //                 controller: quantityController,
  //                 decoration: const InputDecoration(labelText: 'Quantity'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  void _showAddItemDialog() {
    final quantityController = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (context) => Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          final items = menuProvider.items; // Corrected line
          return AlertDialog(
            title: const Text('Add Item to Combo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
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
                      final quantity =
                          int.tryParse(quantityController.text) ?? 1;
                      setState(() {
                        _selectedItems.add({
                          'id': item.id,
                          'name': item.name,
                          'quantity': quantity,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _saveCombo() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement combo creation in the provider
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
