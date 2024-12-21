import 'package:ffms/src/widgets/menu/add_menu_item_dialog.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/menu/menu_provider.dart';
import '../../widgets/side_menu.dart';
import '../combo/combo_management_screen.dart';
import 'widgets/menu_grid.dart';
import 'widgets/category_sidebar.dart';
import 'widgets/menu_search.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<MenuProvider>().loadMenuItems();
//       context.read<MenuProvider>().loadCategories();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           const SideMenu(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Menu Management',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       Row(
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               // TODO: Add new menu item
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => const Dialog(
//                                   child: SizedBox(
//                                     width: 600, // Adjust the width as needed
//                                     child: AddMenuItemDialog(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.add),
//                             label: const Text('Add Item'),
//                           ),
//                           const SizedBox(width: 8),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               // TODO: Create new combo
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => const Dialog(
//                                   child: SizedBox(
//                                     width: 600, // Adjust the width as needed
//                                     child: NewComboDialog(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.fastfood),
//                             label: const Text('New Combo'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   const Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CategorySidebar(),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               MenuSearch(),
//                               SizedBox(height: 16),
//                               Expanded(child: MenuGrid()),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().loadMenuItems();
      context.read<MenuProvider>().loadCategories();
    });
  }

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
                        'Menu Management',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const Dialog(
                                  child: SizedBox(
                                    width: 600,
                                    child: AddMenuItemDialog(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add Item'),
                          ),
                          const SizedBox(width: 8),
                          // In your MenuScreen class, update the combo button handler:
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const ComboManagementScreen(),
                              );
                            },
                            icon: const Icon(Icons.fastfood),
                            label: const Text('New Combo'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategorySidebar(),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              MenuSearch(),
                              SizedBox(height: 16),
                              Expanded(child: MenuGrid()),
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
