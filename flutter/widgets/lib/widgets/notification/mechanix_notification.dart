// animated_overlay_notification.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/notification/mechanix_notification_theme.dart';
import 'package:widgets/widgets/notification/notification_type.dart';

class MechanixNotification {
  static OverlayEntry? _currentOverlay;
  static Timer? _timer;

  /// Show animated top notification
  static void show({
    required BuildContext context,
    required String message,
    IconWidget? leadingIcon,
    Widget? trailing,
    Duration duration = const Duration(seconds: 2),
    Curve animationCurve = Curves.easeOut,
    int animationDuration = 500,
    MechanixNotificationThemeData? theme,
    bool withCloseButton = true,
    NotificationType notificationType = NotificationType.standard,
  }) {
    dismiss();

    final notificationTheme =
        MechanixNotificationTheme.of(context).merge(theme, context);

    final overlayState = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => _AnimatedNotification(
        message: message,
        backgroundColor: notificationTheme.backgroundColor ?? context.tertiary,
        leadingIcon: leadingIcon,
        trailing: trailing,
        duration: duration,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        margin: notificationTheme.margin,
        onDismiss: dismiss,
        withCloseButton: withCloseButton,
        notificationType: notificationType,
      ),
    );

    overlayState.insert(_currentOverlay!);
  }

  static void dismiss() {
    _timer?.cancel();
    _timer = null;
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _AnimatedNotification extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconWidget? leadingIcon;
  final Widget? trailing;
  final Duration duration;
  final Curve animationCurve;
  final int animationDuration;
  final EdgeInsetsGeometry margin;
  final VoidCallback onDismiss;
  final bool withCloseButton;
  final NotificationType notificationType;

  const _AnimatedNotification({
    required this.message,
    required this.backgroundColor,
    this.leadingIcon,
    this.trailing,
    required this.duration,
    required this.animationCurve,
    required this.animationDuration,
    required this.margin,
    required this.onDismiss,
    required this.withCloseButton,
    required this.notificationType,
  });

  @override
  _AnimatedNotificationState createState() => _AnimatedNotificationState();
}

class _AnimatedNotificationState extends State<_AnimatedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Timer _dismissTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    // Animate width from 0 to full width
    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));

    // Opacity for the container
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve:
          Interval(0.0, 0.3, curve: Curves.easeIn), // Fade in quickly at start
    ));

    // Content appears after some width is visible (delayed)
    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 1.0,
          curve: Curves.easeIn), // Fade in after width expands
    ));

    // Start animation
    _controller.forward();

    // Setup auto dismiss
    _dismissTimer = Timer(widget.duration, _dismiss);
  }

  @override
  void dispose() {
    _dismissTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final margin = widget.margin;
    final horizontalMargin = margin.horizontal / 2;
    final topMargin =
        MediaQuery.of(context).viewPadding.top + margin.vertical / 2;

    return Positioned(
      top: topMargin,
      left: horizontalMargin,
      right: horizontalMargin,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              alignment: Alignment.centerLeft,
              child: ClipRect(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - margin.horizontal,
                  child: Row(
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          widthFactor: _widthAnimation.value,
                          alignment: Alignment.centerLeft,
                          child: _buildNotificationContent(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationContent() {
    return Opacity(
      opacity: _contentOpacityAnimation.value,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.zero,
          height: 60,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (widget.notificationType == NotificationType.success)
                  widget.leadingIcon ??
                      IconWidget.fromMechanix(
                        iconPath: MechanixIconImages.successIcon,
                        iconColor: Color.fromRGBO(0, 159, 0, 1),
                        boxWidth: 20,
                        boxHeight: 20,
                        iconWidth: 16,
                        iconHeight: 16,
                      ),
                if (widget.notificationType == NotificationType.error)
                  widget.leadingIcon ??
                      IconWidget.fromMechanix(
                        iconPath: MechanixIconImages.errorIcon,
                        iconColor: Color.fromRGBO(255, 0, 0, 1),
                        boxWidth: 20,
                        boxHeight: 20,
                        iconWidth: 16,
                        iconHeight: 16,
                      ),
                if (widget.notificationType == NotificationType.standard &&
                    widget.leadingIcon != null)
                  widget.leadingIcon!,
                Expanded(
                  child: Text(
                    widget.message,
                    style: context.textTheme.labelSmall,
                  ).padLeft(8),
                ),
                if (widget.trailing != null) widget.trailing!,
                if (widget.withCloseButton)
                  IconButton(
                    icon: IconWidget.fromMechanix(
                      iconPath: MechanixIconImages.closeIcon,
                      boxWidth: 16,
                      boxHeight: 16,
                      iconWidth: 11,
                      iconHeight: 11,
                    ),
                    onPressed: _dismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
