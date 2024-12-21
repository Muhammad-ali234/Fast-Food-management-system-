import '../../models/menu_item.dart';

class MenuState {
  final List<MenuItem> items;
  final List<String> categories;
  final bool isLoading;
  final String? error;

  const MenuState({
    this.items = const [],
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  MenuState copyWith({
    List<MenuItem>? items,
    List<String>? categories,
    bool? isLoading,
    String? error,
  }) {
    return MenuState(
      items: items ?? this.items,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}