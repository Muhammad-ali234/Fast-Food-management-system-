// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../providers/menu/menu_provider.dart';


// class CategorySidebar extends StatelessWidget {
//   const CategorySidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200,
//       child: Card(
//         child: Consumer<MenuProvider>(
//           builder: (context, provider, child) {
//             final categories = provider.categories;

//             return ListView(
//               children: [
//                 const ListTile(
//                   title: Text(
//                     'Categories',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const ListTile(
//                   leading: Icon(Icons.category),
//                   title: Text('All Items'),
//                   selected: true,
//                 ),
//                 ...categories.map((category) => ListTile(
//                   leading: const Icon(Icons.lunch_dining),
//                   title: Text(category),
//                   onTap: () {
//                     // TODO: Filter by category
//                   },
//                 )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }