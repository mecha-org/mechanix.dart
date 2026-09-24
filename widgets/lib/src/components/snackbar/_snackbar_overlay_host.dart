import 'dart:async';

import 'package:flutter/material.dart';

import 'snackbar_controller.dart';
import 'snackbar_enums.dart';

/// Scope provided to snackbars rendered inside an overlay host so that inner
/// action buttons and close buttons can trigger dismissal.
class MechanixSnackbarScope extends InheritedWidget {
  const MechanixSnackbarScope({
    super.key,
    required this.dismiss,
    required super.child,
  });

  final void Function({SnackBarClosedReason reason}) dismiss;

  static MechanixSnackbarScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MechanixSnackbarScope>();
  }

  @override
  bool updateShouldNotify(MechanixSnackbarScope oldWidget) => false;
}

/// Controller managing an active overlay-hosted snackbar.
class OverlaySnackbarController implements MechanixSnackbarController {
  OverlaySnackbarController({required this.dismissCallback});

  final void Function({SnackBarClosedReason reason}) dismissCallback;
  final Completer<SnackBarClosedReason> _completer =
      Completer<SnackBarClosedReason>();

  @override
  void close({SnackBarClosedReason reason = SnackBarClosedReason.dismiss}) {
    dismissCallback(reason: reason);
  }

  @override
  Future<SnackBarClosedReason> get closed => _completer.future;

  void complete(SnackBarClosedReason reason) {
    if (!_completer.isCompleted) {
      _completer.complete(reason);
    }
  }
}

/// Global manager for overlay-based [MechanixSnackbar] notifications.
class MechanixSnackbarOverlayManager {
  MechanixSnackbarOverlayManager._();

  static OverlayEntry? _currentEntry;
  static OverlaySnackbarController? _currentController;

  /// Displays a [snackbar] in the nearest [Overlay] of [context].
  static MechanixSnackbarController show(
    BuildContext context, {
    required Widget snackbar,
    required MechanixSnackbarPosition position,
    required Duration duration,
    required bool persist,
    VoidCallback? onVisible,
    EdgeInsetsGeometry? margin,
    double? width,
  }) {
    // Dismiss any currently displaying overlay snackbar immediately
    _dismissActive(SnackBarClosedReason.remove);

    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;
    late OverlaySnackbarController controller;
    final hostKey = GlobalKey<_SnackbarOverlayHostState>();

    controller = OverlaySnackbarController(
      dismissCallback:
          ({SnackBarClosedReason reason = SnackBarClosedReason.dismiss}) {
            if (hostKey.currentState != null &&
                !hostKey.currentState!._isDismissing) {
              hostKey.currentState!._dismiss(reason);
            } else {
              _dismissActive(reason);
            }
          },
    );

    entry = OverlayEntry(
      builder: (overlayContext) {
        return _SnackbarOverlayHost(
          key: hostKey,
          snackbar: snackbar,
          position: position,
          duration: duration,
          persist: persist,
          margin: margin,
          width: width,
          onVisible: onVisible,
          onDismissed: (reason) {
            _removeEntry(entry, controller, reason);
          },
        );
      },
    );

    _currentEntry = entry;
    _currentController = controller;
    overlay.insert(entry);

    return controller;
  }

  /// Hides the currently active overlay snackbar, if any.
  static void hideCurrent({
    SnackBarClosedReason reason = SnackBarClosedReason.dismiss,
    bool animate = true,
  }) {
    if (animate && _currentController != null) {
      _currentController?.close(reason: reason);
    } else {
      _dismissActive(reason);
    }
  }

  static void _dismissActive(SnackBarClosedReason reason) {
    if (_currentController != null) {
      final ctrl = _currentController;
      _currentController = null;
      ctrl?.complete(reason);
    }
    if (_currentEntry != null) {
      final entry = _currentEntry;
      _currentEntry = null;
      entry?.remove();
      entry?.dispose();
    }
  }

  static void _removeEntry(
    OverlayEntry entry,
    OverlaySnackbarController controller,
    SnackBarClosedReason reason,
  ) {
    if (_currentEntry == entry) {
      _currentEntry = null;
      _currentController = null;
    }
    controller.complete(reason);
    entry.remove();
    entry.dispose();
  }
}

class _SnackbarOverlayHost extends StatefulWidget {
  const _SnackbarOverlayHost({
    super.key,
    required this.snackbar,
    required this.position,
    required this.duration,
    required this.persist,
    required this.onDismissed,
    this.onVisible,
    this.margin,
    this.width,
  });

  final Widget snackbar;
  final MechanixSnackbarPosition position;
  final Duration duration;
  final bool persist;
  final ValueChanged<SnackBarClosedReason> onDismissed;
  final VoidCallback? onVisible;
  final EdgeInsetsGeometry? margin;
  final double? width;

  @override
  State<_SnackbarOverlayHost> createState() => _SnackbarOverlayHostState();
}

class _SnackbarOverlayHostState extends State<_SnackbarOverlayHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _dismissTimer;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );

    final curved = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    final Offset slideBegin = switch (widget.position) {
      MechanixSnackbarPosition.top => const Offset(0.0, -1.0),
      MechanixSnackbarPosition.bottom => const Offset(0.0, 1.0),
      MechanixSnackbarPosition.center => Offset.zero,
    };

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(curved);

    _scaleAnimation = Tween<double>(
      begin: widget.position == MechanixSnackbarPosition.center ? 0.85 : 1.0,
      end: 1.0,
    ).animate(curved);

    _animController.forward().then((_) {
      if (mounted) {
        widget.onVisible?.call();
      }
    });

    _startTimer();
  }

  void _startTimer() {
    if (!widget.persist) {
      _dismissTimer?.cancel();
      _dismissTimer = Timer(widget.duration, () {
        _dismiss(SnackBarClosedReason.timeout);
      });
    }
  }

  void _pauseTimer() {
    _dismissTimer?.cancel();
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _dismiss(SnackBarClosedReason reason) async {
    if (_isDismissing || !mounted) return;
    _isDismissing = true;
    _dismissTimer?.cancel();

    await _animController.reverse();
    if (mounted) {
      widget.onDismissed(reason);
    }
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMargin =
        widget.margin ??
        switch (widget.position) {
          MechanixSnackbarPosition.top => const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          MechanixSnackbarPosition.bottom => const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          MechanixSnackbarPosition.center => const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
        };

    final alignment = switch (widget.position) {
      MechanixSnackbarPosition.top => Alignment.topCenter,
      MechanixSnackbarPosition.bottom => Alignment.bottomCenter,
      MechanixSnackbarPosition.center => Alignment.center,
    };

    final dismissDirection = switch (widget.position) {
      MechanixSnackbarPosition.top => DismissDirection.up,
      MechanixSnackbarPosition.bottom => DismissDirection.down,
      MechanixSnackbarPosition.center => DismissDirection.horizontal,
    };

    Widget animatedChild = widget.snackbar;

    // Center uses scale animation, top/bottom use slide animation
    if (widget.position == MechanixSnackbarPosition.center) {
      animatedChild = ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(opacity: _fadeAnimation, child: animatedChild),
      );
    } else {
      animatedChild = SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(opacity: _fadeAnimation, child: animatedChild),
      );
    }

    final scopedChild = MechanixSnackbarScope(
      dismiss: ({SnackBarClosedReason reason = SnackBarClosedReason.dismiss}) {
        _dismiss(reason);
      },
      child: MouseRegion(
        onEnter: (_) => _pauseTimer(),
        onExit: (_) => _resumeTimer(),
        child: Listener(
          onPointerDown: (_) => _pauseTimer(),
          onPointerUp: (_) => _resumeTimer(),
          onPointerCancel: (_) => _resumeTimer(),
          child: Dismissible(
            key: const ValueKey('mechanix_overlay_snackbar'),
            direction: dismissDirection,
            onDismissed: (_) {
              widget.onDismissed(SnackBarClosedReason.swipe);
            },
            child: widget.width != null
                ? SizedBox(width: widget.width, child: animatedChild)
                : animatedChild,
          ),
        ),
      ),
    );

    final safeArea = SafeArea(
      top: widget.position != MechanixSnackbarPosition.bottom,
      bottom: widget.position != MechanixSnackbarPosition.top,
      child: Padding(padding: effectiveMargin, child: scopedChild),
    );

    return Align(alignment: alignment, child: safeArea);
  }
}
