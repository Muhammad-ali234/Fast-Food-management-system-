import 'package:flutter/material.dart';

class MenuSearch extends StatelessWidget {
  const MenuSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search menu items...',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        // TODO: Implement search
      },
    );
  }
}