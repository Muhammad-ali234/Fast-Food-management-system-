import 'package:flutter/material.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/reports/sales_chart.dart';
import '../../widgets/reports/top_items_chart.dart';
import '../../widgets/reports/expense_summary.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reports & Analytics',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Export report
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Export Report'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SalesChart(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(child: TopItemsChart()),
                              SizedBox(height: 16),
                              Expanded(child: ExpenseSummary()),
                            ],
                          ),
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