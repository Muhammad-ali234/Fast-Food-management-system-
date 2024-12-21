import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../providers/order_provider.dart';
import 'package:provider/provider.dart';

class NewOrderWidget extends StatefulWidget {
  const NewOrderWidget({super.key});

  @override
  _NewOrderWidgetState createState() => _NewOrderWidgetState();
}

class _NewOrderWidgetState extends State<NewOrderWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();

  String _orderType = 'Dine-in';
  final List<OrderItem> _items = [];

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController menuItemIdController =
            TextEditingController();
        final TextEditingController quantityController =
            TextEditingController();
        final TextEditingController priceController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Order Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: menuItemIdController,
                decoration: const InputDecoration(labelText: 'Menu Item ID'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final menuItemId = int.tryParse(menuItemIdController.text);
                final quantity = int.tryParse(quantityController.text);
                final price = double.tryParse(priceController.text);

                if (menuItemId != null && quantity != null && price != null) {
                  setState(() {
                    _items.add(OrderItem(
                      menuItemId: menuItemId,
                      quantity: quantity,
                      price: price,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      final newOrder = Order(
        id: 0, // Temporary, will be assigned by the database
        orderType: _orderType,
        customerName: _customerNameController.text,
        customerPhone: _customerPhoneController.text,
        status: 'Pending',
        totalAmount: double.tryParse(_totalAmountController.text) ?? 0.0,
        items: _items,
      );

      Provider.of<OrderProvider>(context, listen: false).createOrder(newOrder);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter customer name' : null,
              ),
              TextFormField(
                controller: _customerPhoneController,
                decoration: const InputDecoration(labelText: 'Customer Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter customer phone' : null,
              ),
              DropdownButtonFormField<String>(
                value: _orderType,
                items: const [
                  DropdownMenuItem(value: 'Dine-in', child: Text('Dine-in')),
                  DropdownMenuItem(value: 'Takeaway', child: Text('Takeaway')),
                  DropdownMenuItem(value: 'Delivery', child: Text('Delivery')),
                ],
                onChanged: (value) {
                  setState(() {
                    _orderType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Order Type'),
              ),
              TextFormField(
                controller: _totalAmountController,
                decoration: const InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter total amount' : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Order Items',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ..._items.map((item) => ListTile(
                    title: Text('Menu Item ID: ${item.menuItemId}'),
                    subtitle: Text(
                        'Quantity: ${item.quantity}, Price: \$${item.price}'),
                  )),
              TextButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
