import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../models/menu_item.dart';
import '../../models/combo.dart';
import '../../providers/menu_provider.dart';
import '../../providers/order_provider.dart';

class NewOrderDialog extends StatefulWidget {
  const NewOrderDialog({super.key});

  @override
  State<NewOrderDialog> createState() => _NewOrderDialogState();
}

class _NewOrderDialogState extends State<NewOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  String _orderType = 'Dine-in';
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final List<OrderItem> _items = [];
  double _total = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Order'),
      content: SizedBox(
        width: 600,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _orderType,
                decoration: const InputDecoration(labelText: 'Order Type'),
                items: ['Dine-in', 'Takeout', 'Delivery']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _orderType = value!;
                  _formKey.currentState?.validate();
                }),
              ),
              if (_orderType == 'Delivery') ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customerNameController,
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  validator: (value) =>
                      (_orderType == 'Delivery' && value?.isEmpty == true)
                          ? 'Required for Delivery'
                          : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customerPhoneController,
                  decoration:
                      const InputDecoration(labelText: 'Customer Phone'),
                  validator: (value) =>
                      (_orderType == 'Delivery' && value?.isEmpty == true)
                          ? 'Required for Delivery'
                          : null,
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _showAddItemDialog,
                child: const Text('Add Item/Combo'),
              ),
              const SizedBox(height: 16),
              if (_items.isNotEmpty) ...[
                const Text('Order Items:'),
                const SizedBox(height: 8),
                ..._items.map((item) => ListTile(
                      title: Text('${item.menuItemId}'),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _updateQuantity(item, -1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _updateQuantity(item, 1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _items.remove(item);
                                _updateTotal();
                              });
                            },
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
                Text(
                  'Total: \$${_total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
          onPressed: _createOrder,
          child: const Text('Create Order'),
        ),
      ],
    );
  }

  // void _showAddItemDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Consumer<MenuProvider>(
  //       builder: (context, menuProvider, child) {
  //         final items = menuProvider.items;
  //         final combos = menuProvider.comboDeals;
  //         return AlertDialog(
  //           title: const Text('Add Item/Combo'),
  //           content: SizedBox(
  //             width: 300,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 DropdownButtonFormField<int>(
  //                   decoration: const InputDecoration(labelText: 'Select'),
  //                   items: [
  //                     ...items.map((item) => DropdownMenuItem(
  //                           value: item.id,
  //                           child: Text(item.name),
  //                         )),
  //                     ...combos.map((combo) => DropdownMenuItem(
  //                           value: combo.id,
  //                           child: Text('${combo.name} (Combo)'),
  //                         )),
  //                   ],
  //                   onChanged: (value) {
  //                     if (value != null) {
  //                       final isCombo =
  //                           combos.any((combo) => combo.id == value);
  //                       if (isCombo) {
  //                         final combo = combos.firstWhere((c) => c.id == value);
  //                         setState(() {
  //                           for (var comboItem in combo.items) {
  //                             _items.add(OrderItem(
  //                               menuItemId: comboItem.menuItemId,
  //                               // name: comboItem.name,
  //                               quantity: comboItem.quantity,
  //                               price: combo.price,
  //                             ));
  //                           }
  //                         });
  //                       } else {
  //                         final item = items.firstWhere((i) => i.id == value);
  //                         setState(() {
  //                           _items.add(OrderItem(
  //                             menuItemId: item.id,
  //                             // name: item.name,
  //                             quantity: 1,
  //                             price: item.price,
  //                           ));
  //                         });
  //                       }
  //                       _updateTotal();
  //                       Navigator.pop(context);
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          final items = menuProvider.items;
          final combos = menuProvider.comboDeals;
          return AlertDialog(
            title: const Text('Add Item/Combo'),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dropdown for Items
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Select Item'),
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
                          _items.add(OrderItem(
                            menuItemId: item.id,
                            quantity: 1,
                            price: item.price,
                          ));
                        });
                        _updateTotal();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Dropdown for Combos
                  DropdownButtonFormField<int>(
                    decoration:
                        const InputDecoration(labelText: 'Select Combo'),
                    items: combos
                        .map((combo) => DropdownMenuItem(
                              value: combo.id,
                              child: Text('${combo.name} (Combo)'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        final combo = combos.firstWhere((c) => c.id == value);
                        setState(() {
                          for (var comboItem in combo.items) {
                            _items.add(OrderItem(
                              menuItemId: comboItem.menuItemId,
                              quantity: comboItem.quantity,
                              price: combo.price,
                            ));
                          }
                        });
                        _updateTotal();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateQuantity(OrderItem item, int delta) {
    setState(() {
      item.quantity = (item.quantity + delta).clamp(1, 99);
      _updateTotal();
    });
  }

  void _updateTotal() {
    _total = _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _createOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      final order = Order(
        id: 0,
        orderType: _orderType,
        customerName: _customerNameController.text,
        customerPhone: _customerPhoneController.text,
        status: 'Pending',
        totalAmount: _total,
        items: _items,
      );
      context.read<OrderProvider>().createOrder(order);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }
}
