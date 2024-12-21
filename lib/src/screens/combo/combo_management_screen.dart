// lib/src/screens/combo/combo_management_screen.dart
import 'package:ffms/src/screens/combo/widgets/combo_items_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/combo_provider.dart';
import '../../models/combo.dart';
import 'widgets/combo_form.dart';
import 'widgets/combo_items_selector.dart';

class ComboManagementScreen extends StatefulWidget {
  const ComboManagementScreen({super.key});

  @override
  State<ComboManagementScreen> createState() => _ComboManagementScreenState();
}

class _ComboManagementScreenState extends State<ComboManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _comboDetailsController = ComboDetailsController();
  final _comboItemsController = ComboItemsController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create New Combo',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ComboForm(controller: _comboDetailsController),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 3,
                      child:
                          ComboItemsSelector(controller: _comboItemsController),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _saveCombo,
                  child: const Text('Create Combo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveCombo() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_comboItemsController.items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please add at least one item to the combo')),
        );
        return;
      }

      final combo = ComboDeal(
        name: _comboDetailsController.name,
        description: _comboDetailsController.description,
        price: _comboDetailsController.price,
        items: _comboItemsController.items,
      );

      try {
        await context.read<ComboProvider>().createCombo(combo);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating combo: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _comboDetailsController.dispose();
    super.dispose();
  }
}
