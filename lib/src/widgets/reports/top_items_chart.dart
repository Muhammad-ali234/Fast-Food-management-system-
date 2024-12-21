import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TopItemsChart extends StatelessWidget {
  const TopItemsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Selling Items',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 35,
                      title: 'Burgers',
                      color: Colors.blue,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: 'Pizza',
                      color: Colors.red,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Drinks',
                      color: Colors.green,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Others',
                      color: Colors.orange,
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}