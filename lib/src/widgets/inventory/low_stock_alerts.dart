import 'package:flutter/material.dart';

class LowStockAlerts extends StatelessWidget {
  const LowStockAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Low Stock Alerts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.red.shade50,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.warning,
                        color: Colors.red.shade700,
                      ),
                      title: Text('Item ${index + 1}'),
                      subtitle: Text('Only ${index + 2} units left'),
                      trailing: TextButton(
                        onPressed: () {
                          // TODO: Restock item
                        },
                        child: const Text('Restock'),
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
