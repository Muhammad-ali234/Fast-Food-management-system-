// import 'package:flutter/material.dart';

// class ExpenseList extends StatelessWidget {
//   const ExpenseList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration(
//                       hintText: 'Search expenses...',
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                     onChanged: (value) {
//                       // TODO: Implement search
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 DropdownButton<String>(
//                   value: 'all',
//                   items: const [
//                     DropdownMenuItem(value: 'all', child: Text('All Categories')),
//                     DropdownMenuItem(value: 'utilities', child: Text('Utilities')),
//                     DropdownMenuItem(value: 'supplies', child: Text('Supplies')),
//                     DropdownMenuItem(value: 'maintenance', child: Text('Maintenance')),
//                   ],
//                   onChanged: (value) {
//                     // TODO: Implement filter
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.orange.shade100,
//                         child: const Icon(Icons.attach_money),
//                       ),
//                       title: Text('Expense ${index + 1}'),
//                       subtitle: Text('Category: ${index % 2 == 0 ? 'Utilities' : 'Supplies'}'),
//                       trailing: Text(
//                         '\$${(index + 1) * 100}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search expenses...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: const [
                    DropdownMenuItem(
                        value: 'all', child: Text('All Categories')),
                    DropdownMenuItem(
                        value: 'utilities', child: Text('Utilities')),
                    DropdownMenuItem(
                        value: 'supplies', child: Text('Supplies')),
                    DropdownMenuItem(
                        value: 'maintenance', child: Text('Maintenance')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value ?? 'all';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: expenseProvider.expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenseProvider.expenses[index];
                  // Filter by category and search query
                  if ((_selectedCategory == 'all' ||
                          expense.category == _selectedCategory) &&
                      (expense.description
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()) ||
                          expense.category
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: const Icon(Icons.attach_money),
                        ),
                        title: Text(expense.description),
                        subtitle: Text('Category: ${expense.category}'),
                        trailing: Text(
                          '\$${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(); // Return an empty container if not displayed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
