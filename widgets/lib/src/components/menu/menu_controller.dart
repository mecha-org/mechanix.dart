import 'package:flutter/material.dart';

/// Controller to programmatically open, close, or toggle a [MechanixMenu]
/// and observe its open/closed state.
class MechanixMenuController extends ChangeNotifier {
  /// Creates a [MechanixMenuController].
  MechanixMenuController();

  MenuController? _nativeMenuController;
  bool _internalIsOpen = false;

  /// Whether the menu is currently visible on screen.
  bool get isOpen => _nativeMenuController?.isOpen ?? _internalIsOpen;

  /// Opens the menu if closed.
  void open() {
    if (_nativeMenuController != null) {
      _nativeMenuController!.open();
    } else {
      _internalIsOpen = true;
    }
    notifyListeners();
  }

  /// Closes the menu if open.
  void close() {
    if (_nativeMenuController != null) {
      _nativeMenuController!.close();
    } else {
      _internalIsOpen = false;
    }
    notifyListeners();
  }

  /// Toggles the menu between open and closed states.
  void toggle() {
    if (isOpen) {
      close();
    } else {
      open();
    }
  }

  /// Internal attachment method linking to Flutter's native [MenuController].
  void attach(MenuController controller) {
    _nativeMenuController = controller;
  }

  /// Internal detachment method unlinking Flutter's native [MenuController].
  void detach() {
    _nativeMenuController = null;
  }
}
