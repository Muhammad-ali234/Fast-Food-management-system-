// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// /// A utility class to handle keyboard shortcuts and interactions
// class KeyboardHelper {
//   /// Singleton instance
//   static final KeyboardHelper _instance = KeyboardHelper._internal();
//   factory KeyboardHelper() => _instance;
//   KeyboardHelper._internal();

//   /// Map of keyboard shortcuts to their actions
//   final Map<ShortcutActivator, VoidCallback> _shortcuts = {};

//   /// Register a keyboard shortcut with its associated action
//   void registerShortcut(ShortcutActivator shortcut, VoidCallback action) {
//     _shortcuts[shortcut] = action;
//   }

//   /// Remove a keyboard shortcut
//   void unregisterShortcut(ShortcutActivator shortcut) {
//     _shortcuts.remove(shortcut);
//   }

//   /// Clear all registered shortcuts
//   void clearShortcuts() {
//     _shortcuts.clear();
//   }

//   /// Get the shortcuts map for use in Flutter's Shortcuts widget
//   Map<ShortcutActivator, Intent> get shortcuts {
//     return _shortcuts.map((key, value) {
//       return MapEntry(key, VoidCallbackIntent(value));
//     });
//   }

//   /// Common keyboard shortcuts for the application
//   static const searchShortcut = SingleActivator(LogicalKeyboardKey.keyF, control: true);
//   static const newItemShortcut = SingleActivator(LogicalKeyboardKey.keyN, control: true);
//   static const saveShortcut = SingleActivator(LogicalKeyboardKey.keyS, control: true);
//   static const deleteShortcut = SingleActivator(LogicalKeyboardKey.delete);
//   static const escapeShortcut = SingleActivator(LogicalKeyboardKey.escape);
//   static const refreshShortcut = SingleActivator(LogicalKeyboardKey.keyR, control: true);
//   static const printShortcut = SingleActivator(LogicalKeyboardKey.keyP, control: true);
//   static const helpShortcut = SingleActivator(LogicalKeyboardKey.f1);

//   /// Helper method to handle keyboard navigation in data tables
//   static void handleDataTableKeyboard(
//     RawKeyEvent event,
//     BuildContext context,
//     int currentIndex,
//     int itemCount,
//     Function(int) onIndexChanged,
//   ) {
//     if (event is RawKeyDownEvent) {
//       if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
//         if (currentIndex < itemCount - 1) {
//           onIndexChanged(currentIndex + 1);
//         }
//       } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
//         if (currentIndex > 0) {
//           onIndexChanged(currentIndex - 1);
//         }
//       } else if (event.logicalKey == LogicalKeyboardKey.home) {
//         onIndexChanged(0);
//       } else if (event.logicalKey == LogicalKeyboardKey.end) {
//         onIndexChanged(itemCount - 1);
//       }
//     }
//   }

//   /// Helper method to handle form field navigation
//   static void handleFormFieldNavigation(
//     RawKeyEvent event,
//     BuildContext context,
//   ) {
//     if (event is RawKeyDownEvent) {
//       if (event.logicalKey == LogicalKeyboardKey.tab) {
//         if (event.isShiftPressed) {
//           // Move to previous field
//           FocusScope.of(context).previousFocus();
//         } else {
//           // Move to next field
//           FocusScope.of(context).nextFocus();
//         }
//       } else if (event.logicalKey == LogicalKeyboardKey.enter) {
//         // Move to next field or submit form
//         FocusScope.of(context).nextFocus();
//       }
//     }
//   }

//   /// Helper method to show keyboard shortcuts help dialog
//   static void showShortcutsHelp(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Keyboard Shortcuts'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               _ShortcutItem(
//                 keys: 'Ctrl + F',
//                 description: 'Search',
//               ),
//               _ShortcutItem(
//                 keys: 'Ctrl + N',
//                 description: 'New Item',
//               ),
//               _ShortcutItem(
//                 keys: 'Ctrl + S',
//                 description: 'Save',
//               ),
//               _ShortcutItem(
//                 keys: 'Delete',
//                 description: 'Delete selected item',
//               ),
//               _ShortcutItem(
//                 keys: 'Esc',
//                 description: 'Close dialog/Cancel action',
//               ),
//               _ShortcutItem(
//                 keys: 'Ctrl + R',
//                 description: 'Refresh',
//               ),
//               _ShortcutItem(
//                 keys: 'Ctrl + P',
//                 description: 'Print',
//               ),
//               _ShortcutItem(
//                 keys: 'F1',
//                 description: 'Show this help',
//               ),
//               _ShortcutItem(
//                 keys: 'Tab',
//                 description: 'Next field',
//               ),
//               _ShortcutItem(
//                 keys: 'Shift + Tab',
//                 description: 'Previous field',
//               ),
//               _ShortcutItem(
//                 keys: '↑/↓',
//                 description: 'Navigate items',
//               ),
//               _ShortcutItem(
//                 keys: 'Home/End',
//                 description: 'First/Last item',
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Custom intent for void callback actions
// class VoidCallbackIntent extends Intent {
//   final VoidCallback callback;
//   const VoidCallbackIntent(this.callback);
// }

// /// Widget to display a keyboard shortcut item in the help dialog
// class _ShortcutItem extends StatelessWidget {
//   final String keys;
//   final String description;

//   const _ShortcutItem({
//     required this.keys,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               keys,
//               style: const TextStyle(
//                 fontFamily: 'monospace',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Text(description),
//         ],
//       ),
//     );
//
//
// }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A utility class to handle keyboard shortcuts and interactions
class KeyboardHelper {
  /// Singleton instance
  static final KeyboardHelper _instance = KeyboardHelper._internal();
  factory KeyboardHelper() => _instance;
  KeyboardHelper._internal();

  /// Map of keyboard shortcuts to their actions
  final Map<ShortcutActivator, Intent> _shortcuts = {};

  /// Register a keyboard shortcut with its associated action
  void registerShortcut(ShortcutActivator shortcut, Intent intent) {
    _shortcuts[shortcut] = intent;
  }

  /// Remove a keyboard shortcut
  void unregisterShortcut(ShortcutActivator shortcut) {
    _shortcuts.remove(shortcut);
  }

  /// Clear all registered shortcuts
  void clearShortcuts() {
    _shortcuts.clear();
  }

  /// Get the shortcuts map for use in Flutter's Shortcuts widget
  Map<ShortcutActivator, Intent> get shortcuts => _shortcuts;

  /// Common keyboard shortcuts for the application
  static const searchShortcut =
      SingleActivator(LogicalKeyboardKey.keyF, control: true);
  static const newItemShortcut =
      SingleActivator(LogicalKeyboardKey.keyN, control: true);
  static const saveShortcut =
      SingleActivator(LogicalKeyboardKey.keyS, control: true);
  static const deleteShortcut = SingleActivator(LogicalKeyboardKey.delete);
  static const escapeShortcut = SingleActivator(LogicalKeyboardKey.escape);
  static const refreshShortcut =
      SingleActivator(LogicalKeyboardKey.keyR, control: true);
  static const printShortcut =
      SingleActivator(LogicalKeyboardKey.keyP, control: true);
  static const helpShortcut = SingleActivator(LogicalKeyboardKey.f1);

  /// Helper method to handle keyboard navigation in data tables
  static void handleDataTableKeyboard(
    KeyEvent event,
    BuildContext context,
    int currentIndex,
    int itemCount,
    Function(int) onIndexChanged,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (currentIndex < itemCount - 1) {
          onIndexChanged(currentIndex + 1);
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (currentIndex > 0) {
          onIndexChanged(currentIndex - 1);
        }
      } else if (event.logicalKey == LogicalKeyboardKey.home) {
        onIndexChanged(0);
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        onIndexChanged(itemCount - 1);
      }
    }
  }

  /// Helper method to handle form field navigation
  static void handleFormFieldNavigation(
    KeyEvent event,
    BuildContext context,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.tab) {
        final isShiftPressed = HardwareKeyboard.instance.logicalKeysPressed
            .contains(LogicalKeyboardKey.shiftLeft);
        if (isShiftPressed) {
          // Move to previous field
          FocusScope.of(context).previousFocus();
        } else {
          // Move to next field
          FocusScope.of(context).nextFocus();
        }
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        // Move to next field or submit form
        FocusScope.of(context).nextFocus();
      }
    }
  }

  /// Helper method to show keyboard shortcuts help dialog
  static void showShortcutsHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keyboard Shortcuts'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ShortcutItem(
                keys: 'Ctrl + F',
                description: 'Search',
              ),
              _ShortcutItem(
                keys: 'Ctrl + N',
                description: 'New Item',
              ),
              _ShortcutItem(
                keys: 'Ctrl + S',
                description: 'Save',
              ),
              _ShortcutItem(
                keys: 'Delete',
                description: 'Delete selected item',
              ),
              _ShortcutItem(
                keys: 'Esc',
                description: 'Close dialog/Cancel action',
              ),
              _ShortcutItem(
                keys: 'Ctrl + R',
                description: 'Refresh',
              ),
              _ShortcutItem(
                keys: 'Ctrl + P',
                description: 'Print',
              ),
              _ShortcutItem(
                keys: 'F1',
                description: 'Show this help',
              ),
              _ShortcutItem(
                keys: 'Tab',
                description: 'Next field',
              ),
              _ShortcutItem(
                keys: 'Shift + Tab',
                description: 'Previous field',
              ),
              _ShortcutItem(
                keys: '↑/↓',
                description: 'Navigate items',
              ),
              _ShortcutItem(
                keys: 'Home/End',
                description: 'First/Last item',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Custom intent for void callback actions
class VoidCallbackIntent extends Intent {
  final VoidCallback callback;
  const VoidCallbackIntent(this.callback);
}

/// Widget to display a keyboard shortcut item in the help dialog
class _ShortcutItem extends StatelessWidget {
  final String keys;
  final String description;

  const _ShortcutItem({
    required this.keys,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              keys,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(description),
        ],
      ),
    );
  }
}
