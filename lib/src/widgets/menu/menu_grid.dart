// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../providers/menu/menu_provider.dart';
// import '../../screens/menu/widgets/menu_item_card.dart';

// class MenuGrid extends StatelessWidget {
//   const MenuGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MenuProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (provider.error != null) {
//           return Center(child: Text(provider.error!));
//         }

//         return GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             childAspectRatio: 1,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//           ),
//           itemCount: provider.items.length,
//           itemBuilder: (context, index) {
//             final item = provider.items[index];
//             return MenuItemCard(item: item);
//           },
//         );
//       },
//     );
//   }
// }
