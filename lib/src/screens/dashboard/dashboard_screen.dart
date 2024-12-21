import 'package:flutter/material.dart';
import '../../widgets/dashboard/inventory_alerts.dart';
import '../../widgets/dashboard/recent_orders.dart';
import '../../widgets/dashboard/stats_cards.dart';
import '../../widgets/side_menu.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  const StatsCards(),
                  const SizedBox(height: 24),
                  const Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: RecentOrders(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InventoryAlerts(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
