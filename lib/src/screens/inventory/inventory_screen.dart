// // import 'package:ffms/src/widgets/inventory/add_inventory_item_dialog.dart';
// // import 'package:flutter/material.dart';
// // import '../../widgets/side_menu.dart';
// // import '../../widgets/inventory/inventory_list.dart';
// // import '../../widgets/inventory/low_stock_alerts.dart';

// // class InventoryScreen extends StatelessWidget {
// //   const InventoryScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Row(
// //         children: [
// //           const SideMenu(),
// //           Expanded(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         'Inventory Management',
// //                         style: Theme.of(context).textTheme.headlineMedium,
// //                       ),
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           // TODO: Add new inventory item
// //                           showDialog(
// //                             context: context,
// //                             builder: (context) => const Dialog(
// //                               child: SizedBox(
// //                                 width: 600, // Adjust the width as needed
// //                                 child: AddInventoryItemDialog(),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                         icon: const Icon(Icons.add),
// //                         label: const Text('Add Item'),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 24),
// //                   const Expanded(
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Expanded(
// //                           flex: 3,
// //                           child: InventoryList(),
// //                         ),
// //                         SizedBox(width: 16),
// //                         Expanded(
// //                           child: LowStockAlerts(),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:ffms/src/widgets/dashboard/inventory_alerts.dart';
import 'package:ffms/src/widgets/inventory/add_inventory_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import '../../providers/inventory_provider.dart';
import '../../widgets/inventory/edit_item_inventory_dialog.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/inventory/inventory_list.dart';
import '../../widgets/inventory/low_stock_alerts.dart';

// class InventoryScreen extends StatelessWidget {
//   const InventoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Load the inventory when the screen is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<InventoryProvider>().loadInventory();
//     });

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
//                         'Inventory Management',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           // Show dialog for adding a new inventory item
//                           showDialog(
//                             context: context,
//                             builder: (context) => Dialog(
//                               child: SizedBox(
//                                 width: 600,
//                                 child: AddInventoryItemDialog(
//                                   onItemAdded: (newItem) {
//                                     // Add the item to the provider
//                                     context
//                                         .read<InventoryProvider>()
//                                         .addItem(newItem)
//                                         .then((_) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 'Item added successfully')),
//                                       );
//                                     }).catchError((error) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         SnackBar(
//                                             content: Text('Error: $error')),
//                                       );
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.add),
//                         label: const Text('Add Item'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Consumer<InventoryProvider>(
//                             builder: (context, provider, child) {
//                               return InventoryList(
//                                 items: provider.items,
//                                 onSearch: provider.searchItems,
//                                 onFilter: provider.filterItems,
//                                 onEdit: (item) {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => Dialog(
//                                       child: SizedBox(
//                                         width: 600,
//                                         child: EditInventoryItemDialog(
//                                           item: item,
//                                           onSave: (updatedItem) {
//                                             print(updatedItem.name);
//                                             context
//                                                 .read<InventoryProvider>()
//                                                 .updateItem(updatedItem);
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Consumer<InventoryProvider>(
//                             builder: (context, provider, child) {
//                               return
//                                   // LowStockAlerts(
//                                   //   lowStockItems: provider.lowStockItems,
//                                   // );
//                                   const InventoryAlerts();
//                             },
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

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load the inventory when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryProvider>().loadInventory();
    });

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
                        'Inventory Management',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Show dialog for adding a new inventory item
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: SizedBox(
                                width: 600,
                                child: AddInventoryItemDialog(
                                  onItemAdded: (newItem) {
                                    // Add the item to the provider
                                    context
                                        .read<InventoryProvider>()
                                        .addItem(newItem)
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Item added successfully')),
                                      );
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text('Error: $error')),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Consumer<InventoryProvider>(
                            builder: (context, provider, child) {
                              return InventoryList(
                                items: provider.items,
                                onSearch: provider.searchItems,
                                onFilter: provider.filterItems,
                                onEdit: (item) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: SizedBox(
                                        width: 600,
                                        child: EditInventoryItemDialog(
                                          item: item,
                                          onSave: (updatedItem) {
                                            context
                                                .read<InventoryProvider>()
                                                .updateItem(updatedItem);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Consumer<InventoryProvider>(
                            builder: (context, provider, child) {
                              return const InventoryAlerts();
                            },
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
