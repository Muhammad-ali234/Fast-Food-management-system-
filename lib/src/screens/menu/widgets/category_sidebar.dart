// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../providers/menu/menu_provider.dart';

// // class CategorySidebar extends StatelessWidget {
// //   const CategorySidebar({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 200,
// //       child: Card(
// //         child: Consumer<MenuProvider>(
// //           builder: (context, provider, child) {
// //             final categories = provider.state.categories;

// //             return ListView(
// //               children: [
// //                 const ListTile(
// //                   title: Text(
// //                     'Categories',
// //                     style: TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //                 const ListTile(
// //                   leading: Icon(Icons.category),
// //                   title: Text('All Items'),
// //                   selected: true,
// //                 ),
// //                 ...categories.map((category) => ListTile(
// //                   leading: const Icon(Icons.lunch_dining),
// //                   title: Text(category),
// //                   onTap: () {
// //                     // TODO: Filter by category
// //                   },
// //                 )),
// //               ],
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../providers/menu/menu_provider.dart';

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
//                   selected: provider.selectedCategory == null,
//                   onTap: () {
//                     provider.setSelectedCategory(null); // Show all items
//                   },
//                 ),
//                 ...categories.map((category) => ListTile(
//                       leading: const Icon(Icons.lunch_dining),
//                       title: Text(category),
//                       selected: provider.selectedCategory == category,
//                       onTap: () {
//                         provider.setSelectedCategory(category); // Filter by category
//                       },
//                     )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/menu/menu_provider.dart';

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
//                 ListTile(
//                   leading: const Icon(Icons.category),
//                   title: const Text('All Items'),
//                   selected: provider.selectedCategory == null,
//                   onTap: () {
//                     provider.setSelectedCategory(null); // Show all items
//                   },
//                 ),
//                 ...categories.map((category) => ListTile(
//                       leading: const Icon(Icons.lunch_dining),
//                       title: Text(category),
//                       selected: provider.selectedCategory == category,
//                       onTap: () {
//                         provider.setSelectedCategory(
//                             category); // Filter by category
//                       },
//                     )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        child: Consumer<MenuProvider>(
          builder: (context, provider, child) {
            final categories = provider.categories;
            final selectedCategory = provider.selectedCategory;

            return ListView(
              children: [
                const ListTile(
                  title: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('All Items'),
                  selected: selectedCategory == null,
                  onTap: () {
                    provider.setSelectedCategory(null); // Show all items
                  },
                ),
                // Use Visibility widget to show a loading message when categories are empty
                Visibility(
                  visible: categories.isEmpty,
                  child: const ListTile(
                    title: Text('Loading categories...'),
                  ),
                ),
                // Use Visibility widget to show categories when they are loaded
                Visibility(
                  visible: categories.isNotEmpty,
                  child: Column(
                    children: categories
                        .map((category) => ListTile(
                              leading: const Icon(Icons.lunch_dining),
                              title: Text(category),
                              selected: selectedCategory == category,
                              onTap: () {
                                provider.setSelectedCategory(
                                    category); // Filter by category
                              },
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
