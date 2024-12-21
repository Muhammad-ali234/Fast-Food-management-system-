import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: const [
        _StatCard(
          title: 'Total Orders',
          value: '125',
          icon: Icons.shopping_cart,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Today\'s Revenue',
          value: '\$2,500',
          icon: Icons.attach_money,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Pending Orders',
          value: '8',
          icon: Icons.pending_actions,
          color: Colors.orange,
        ),
        _StatCard(
          title: 'Low Stock Items',
          value: '5',
          icon: Icons.warning,
          color: Colors.red,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}