import 'package:flutter/material.dart';
import '../../../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Edit menu item
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: const Icon(Icons.fastfood, size: 48),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$${item.price.toStringAsFixed(2)}'),
                  Row(
                    children: [
                      Switch(
                        value: item.isAvailable,
                        onChanged: (value) {
                          // TODO: Toggle availability
                        },
                      ),
                      const Text('Available'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}