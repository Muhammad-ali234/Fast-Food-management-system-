// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../models/menu_item.dart';
// // import '../../providers/menu_provider.dart';

// // class AddMenuItemDialog extends StatefulWidget {
// //   const AddMenuItemDialog({super.key});

// //   @override
// //   State<AddMenuItemDialog> createState() => _AddMenuItemDialogState();
// // }

// // class _AddMenuItemDialogState extends State<AddMenuItemDialog> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _descriptionController = TextEditingController();
// //   final _priceController = TextEditingController();
// //   int _categoryId = 1;
// //   bool _isAvailable = true;

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: const Text('Add Menu Item'),
// //       content: Form(
// //         key: _formKey,
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Consumer<MenuProvider>(
// //               builder: (context, provider, child) {
// //                 return DropdownButtonFormField<int>(
// //                   value: _categoryId,
// //                   decoration: const InputDecoration(labelText: 'Category'),
// //                   items: provider.state.categories
// //                       .asMap()
// //                       .entries
// //                       .map((entry) => DropdownMenuItem(
// //                             value: entry.key + 1,
// //                             child: Text(entry.value),
// //                           ))
// //                       .toList(),
// //                   onChanged: (value) => setState(() => _categoryId = value!),
// //                 );
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //             TextFormField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: 'Name'),
// //               validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
// //             ),
// //             const SizedBox(height: 16),
// //             TextFormField(
// //               controller: _descriptionController,
// //               decoration: const InputDecoration(labelText: 'Description'),
// //               maxLines: 3,
// //             ),
// //             const SizedBox(height: 16),
// //             TextFormField(
// //               controller: _priceController,
// //               decoration: const InputDecoration(labelText: 'Price'),
// //               keyboardType: TextInputType.number,
// //               validator: (value) {
// //                 if (value?.isEmpty ?? true) return 'Required';
// //                 if (double.tryParse(value!) == null) return 'Invalid price';
// //                 return null;
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //             SwitchListTile(
// //               title: const Text('Available'),
// //               value: _isAvailable,
// //               onChanged: (value) => setState(() => _isAvailable = value),
// //             ),
// //           ],
// //         ),
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: () => Navigator.pop(context),
// //           child: const Text('Cancel'),
// //         ),
// //         ElevatedButton(
// //           onPressed: _saveMenuItem,
// //           child: const Text('Save'),
// //         ),
// //       ],
// //     );
// //   }

// //   void _saveMenuItem() {
// //     if (_formKey.currentState?.validate() ?? false) {
// //       final item = MenuItem(
// //         id: 0,
// //         categoryId: _categoryId,
// //         name: _nameController.text,
// //         description: _descriptionController.text,
// //         price: double.parse(_priceController.text),
// //         isAvailable: _isAvailable,
// //       );

// //       context.read<MenuProvider>().addMenuItem(item);
// //       Navigator.pop(context);
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _descriptionController.dispose();
// //     _priceController.dispose();
// //     super.dispose();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/menu_item.dart';
// import '../../providers/menu_provider.dart';

// class AddMenuItemDialog extends StatefulWidget {
//   const AddMenuItemDialog({super.key});

//   @override
//   State<AddMenuItemDialog> createState() => _AddMenuItemDialogState();
// }

// class _AddMenuItemDialogState extends State<AddMenuItemDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();
//   int _categoryId = 1;
//   bool _isAvailable = true;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Menu Item'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Consumer<MenuProvider>(
//               builder: (context, provider, child) {
//                 return DropdownButtonFormField<int>(
//                   value: _categoryId,
//                   decoration: const InputDecoration(labelText: 'Category'),
//                   items: provider.categories // Access `categories` directly
//                       .asMap()
//                       .entries
//                       .map((entry) => DropdownMenuItem(
//                             value: entry.key + 1,
//                             child: Text(entry.value),
//                           ))
//                       .toList(),
//                   onChanged: (value) => setState(() => _categoryId = value!),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//               validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _priceController,
//               decoration: const InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) return 'Required';
//                 if (double.tryParse(value!) == null) return 'Invalid price';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             SwitchListTile(
//               title: const Text('Available'),
//               value: _isAvailable,
//               onChanged: (value) => setState(() => _isAvailable = value),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _saveMenuItem,
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }

//   void _saveMenuItem() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final item = MenuItem(
//         id: 0,
//         categoryId: _categoryId,
//         name: _nameController.text,
//         description: _descriptionController.text,
//         price: double.parse(_priceController.text),
//         isAvailable: _isAvailable,
//       );

//       context.read<MenuProvider>().addMenuItem(item);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/menu_item.dart';
import '../../providers/menu_provider.dart';

class AddMenuItemDialog extends StatefulWidget {
  const AddMenuItemDialog({super.key});

  @override
  State<AddMenuItemDialog> createState() => _AddMenuItemDialogState();
}

class _AddMenuItemDialogState extends State<AddMenuItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  int _categoryId = 0; // Index starts from 0
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Menu Item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Consumer<MenuProvider>(
            //   builder: (context, provider, child) {
            //     return DropdownButtonFormField<int>(
            //       value: _categoryId,
            //       decoration: const InputDecoration(labelText: 'Category'),
            //       items: provider.categories
            //           .asMap()
            //           .entries
            //           .map(
            //             (entry) => DropdownMenuItem(
            //               value: entry.key,
            //               child: Text(entry.value),
            //             ),
            //           )
            //           .toList(),
            //       onChanged: (value) => setState(() => _categoryId = value!),
            //     );
            //   },
            // ),

            Consumer<MenuProvider>(
              builder: (context, provider, child) {
                print("Dropdown Categories: ${provider.categories}");
                return DropdownButtonFormField<int>(
                  value: _categoryId,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: provider.categories
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _categoryId = value!),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Required';
                if (double.tryParse(value!) == null) return 'Invalid price';
                return null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Available'),
              value: _isAvailable,
              onChanged: (value) => setState(() => _isAvailable = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveMenuItem,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveMenuItem() {
    if (_formKey.currentState?.validate() ?? false) {
      final item = MenuItem(
        id: 0,
        categoryId: _categoryId + 1, // Adjust index to match database ID
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        isAvailable: _isAvailable,
      );

      context.read<MenuProvider>().addMenuItem(item);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
