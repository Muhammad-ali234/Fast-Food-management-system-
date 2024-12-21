// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ExpenseChart extends StatelessWidget {
//   const ExpenseChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Expense Distribution',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       value: 40,
//                       title: 'Utilities',
//                       color: Colors.blue,
//                       radius: 50,
//                     ),
//                     PieChartSectionData(
//                       value: 30,
//                       title: 'Supplies',
//                       color: Colors.red,
//                       radius: 50,
//                     ),
//                     PieChartSectionData(
//                       value: 20,
//                       title: 'Maintenance',
//                       color: Colors.green,
//                       radius: 50,
//                     ),
//                     PieChartSectionData(
//                       value: 10,
//                       title: 'Others',
//                       color: Colors.orange,
//                       radius: 50,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    // Calculate the total expenses for each category
    Map<String, double> categoryTotals = {};
    for (var expense in expenseProvider.expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: _getCategoryColor(entry.key),
        radius: 50,
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Distribution',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: sections,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Utilities':
        return Colors.blue;
      case 'Supplies':
        return Colors.red;
      case 'Maintenance':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
