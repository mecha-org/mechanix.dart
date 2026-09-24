import 'dart:async';
import 'package:flutter/material.dart';

/// Controller interface for programmatically closing and observing the dismissal
/// of an active [MechanixSnackbar].
abstract class MechanixSnackbarController {
  /// Dismisses or closes the currently displayed snackbar.
  void close({SnackBarClosedReason reason = SnackBarClosedReason.dismiss});

  /// A future that completes when the snackbar has closed with its close reason.
  Future<SnackBarClosedReason> get closed;
}

/// A [MechanixSnackbarController] that bridges to Flutter's native [ScaffoldFeatureController].
class ScaffoldSnackbarController implements MechanixSnackbarController {
  ScaffoldSnackbarController(this._controller);

  final ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _controller;

  @override
  void close({SnackBarClosedReason reason = SnackBarClosedReason.dismiss}) {
    _controller.close();
  }

  @override
  Future<SnackBarClosedReason> get closed => _controller.closed;
}
