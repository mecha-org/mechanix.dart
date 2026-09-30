import 'package:flutter/services.dart';

import 'menu_entry.dart';

/// Helper to handle keyboard navigation (arrows, home/end, enter/space, escape, tab, typeahead)
/// across a list of menu items.
class MenuKeyboardHelper<T> {
  MenuKeyboardHelper({
    required this.flattenedItems,
    int initialFocusedIndex = 0,
    required this.onFocusChanged,
    required this.onActivate,
    required this.onClose,
  }) : _focusedIndex = initialFocusedIndex;

  /// The list of interactive items in display order.
  final List<MechanixMenuItem<T>> flattenedItems;

  /// Callback when the focused item index changes.
  final ValueChanged<int> onFocusChanged;

  /// Callback when an item is activated via keyboard (Enter/Space).
  final ValueChanged<MechanixMenuItem<T>> onActivate;

  /// Callback when the menu should close (Escape or Tab).
  final VoidCallback onClose;

  int _focusedIndex;

  /// The currently focused index among [flattenedItems].
  int get focusedIndex => _focusedIndex;

  set focusedIndex(int index) {
    if (index >= 0 && index < flattenedItems.length) {
      _focusedIndex = index;
      onFocusChanged(_focusedIndex);
    }
  }

  /// Sets focus to the first enabled item.
  void focusFirst() {
    for (int i = 0; i < flattenedItems.length; i++) {
      if (flattenedItems[i].enabled) {
        focusedIndex = i;
        break;
      }
    }
  }

  /// Sets focus to the last enabled item.
  void focusLast() {
    for (int i = flattenedItems.length - 1; i >= 0; i--) {
      if (flattenedItems[i].enabled) {
        focusedIndex = i;
        break;
      }
    }
  }

  /// Moves focus down to the next enabled item.
  void focusNext() {
    for (int i = _focusedIndex + 1; i < flattenedItems.length; i++) {
      if (flattenedItems[i].enabled) {
        focusedIndex = i;
        return;
      }
    }
  }

  /// Moves focus up to the previous enabled item.
  void focusPrevious() {
    for (int i = _focusedIndex - 1; i >= 0; i--) {
      if (flattenedItems[i].enabled) {
        focusedIndex = i;
        return;
      }
    }
  }

  /// Handles a keyboard event and returns true if the event was handled.
  bool handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return false;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.arrowDown) {
      focusNext();
      return true;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      focusPrevious();
      return true;
    } else if (key == LogicalKeyboardKey.home) {
      focusFirst();
      return true;
    } else if (key == LogicalKeyboardKey.end) {
      focusLast();
      return true;
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      if (_focusedIndex >= 0 && _focusedIndex < flattenedItems.length) {
        final item = flattenedItems[_focusedIndex];
        if (item.enabled) {
          onActivate(item);
          return true;
        }
      }
      return false;
    } else if (key == LogicalKeyboardKey.escape ||
        key == LogicalKeyboardKey.tab) {
      onClose();
      return true;
    }

    // Typeahead by first letter
    final char = event.character;
    if (char != null && char.isNotEmpty && char.trim().isNotEmpty) {
      final searchChar = char.toLowerCase();
      // Search from next item, wrapping around
      final count = flattenedItems.length;
      for (int i = 1; i <= count; i++) {
        final candidateIndex = (_focusedIndex + i) % count;
        final item = flattenedItems[candidateIndex];
        final text = item.labelText ?? item.semanticLabel ?? '';
        if (item.enabled && text.toLowerCase().startsWith(searchChar)) {
          focusedIndex = candidateIndex;
          return true;
        }
      }
    }

    return false;
  }
}
