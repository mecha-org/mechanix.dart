import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/switch/mechanix_switch_theme.dart';

class MechanixSwitch extends StatefulWidget {
  /// Current state of the switch
  final bool value;

  /// Callback when the switch state changes
  final ValueChanged<bool> onChanged;

  /// Style configuration for the switch
  final MechanixSwitchStyle? style;

  /// Whether the switch is enabled
  final bool enabled;

  /// Whether the switch can be dragged
  final bool allowDrag;

  /// Whether the switch can be tapped
  final bool allowTap;

  /// Text to display on active side
  final String? activeText;

  /// Text to display on inactive side
  final String? inactiveText;

  const MechanixSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.style,
    this.enabled = true,
    this.allowDrag = true,
    this.allowTap = true,
    this.activeText,
    this.inactiveText,
  });

  @override
  State<MechanixSwitch> createState() => _MechanixSwitchState();
}

class _MechanixSwitchState extends State<MechanixSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool _isActive;
  double _thumbPosition = 0.0;
  bool _isDragging = false;
  late MechanixSwitchStyle _effectiveStyle;

  @override
  void initState() {
    super.initState();
    _isActive = widget.value;

    // Initialize with default style first
    _effectiveStyle = const MechanixSwitchStyle();

    _animationController = AnimationController(
      duration: _effectiveStyle.animationDuration!,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: _effectiveStyle.animationCurve!,
    ));

    if (_isActive) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final oldDuration = _effectiveStyle.animationDuration;
    final oldCurve = _effectiveStyle.animationCurve;

    _updateEffectiveStyle();

    // Update animation controller if duration or curve changed
    if (oldDuration != _effectiveStyle.animationDuration) {
      _animationController.duration = _effectiveStyle.animationDuration!;
    }

    if (oldCurve != _effectiveStyle.animationCurve) {
      _animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: _effectiveStyle.animationCurve!,
      ));
    }
  }

  @override
  void didUpdateWidget(MechanixSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldEffectiveStyle = _effectiveStyle;
    _updateEffectiveStyle();

    if (oldWidget.value != widget.value) {
      _isActive = widget.value;
      if (_isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }

    if (oldEffectiveStyle.animationDuration !=
        _effectiveStyle.animationDuration) {
      _animationController.duration = _effectiveStyle.animationDuration!;
    }
  }

  void _updateEffectiveStyle() {
    // Get theme-based style first
    final themeStyle = MechanixSwitchThemeData.of(context);

    // Resolve with current theme colors - this is the key method
    _effectiveStyle = MechanixSwitchStyle.resolveWith(context, themeStyle);

    // Finally merge with widget-specific style if provided
    if (widget.style != null) {
      _effectiveStyle = _effectiveStyle.merge(widget.style);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Size get _thumbSize {
    return _effectiveStyle.thumbSize ??
        Size(
          _effectiveStyle.height! - (_effectiveStyle.trackPadding! * 2),
          _effectiveStyle.height! - (_effectiveStyle.trackPadding! * 2),
        );
  }

  double get _maxThumbPosition {
    return _effectiveStyle.width! -
        _thumbSize.width -
        (_effectiveStyle.trackPadding! * 2);
  }

  void _handlePanStart(DragStartDetails details) {
    if (!widget.enabled || !widget.allowDrag) return;
    _isDragging = true;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!widget.enabled || !widget.allowDrag || !_isDragging) return;

    double newPosition = (details.localPosition.dx -
            _thumbSize.width / 2 -
            _effectiveStyle.trackPadding!) *
        _effectiveStyle.dragSensitivity!;
    newPosition = newPosition.clamp(0.0, _maxThumbPosition);

    setState(() {
      _thumbPosition = newPosition;
      _animationController.value = newPosition / _maxThumbPosition;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.enabled || !widget.allowDrag || !_isDragging) return;

    _isDragging = false;
    final double threshold = _maxThumbPosition * _effectiveStyle.dragThreshold!;
    bool shouldBeActive = _thumbPosition > threshold;

    // _triggerHapticFeedback();

    if (shouldBeActive != _isActive) {
      widget.onChanged(shouldBeActive);
    } else {
      // Animate back to current state if no change
      _animateToCurrentState();
    }
  }

  void _handleTap() {
    if (!widget.enabled || !widget.allowTap) return;

    // _triggerHapticFeedback();
    widget.onChanged(!_isActive);
  }

  // void _triggerHapticFeedback() {
  //   // You can add haptic feedback logic here if needed
  //   HapticFeedback.lightImpact();
  // }

  void _animateToCurrentState() {
    if (_isActive) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget _buildTrack() {
    return Container(
      width: _effectiveStyle.width!,
      height: _effectiveStyle.height!,
      decoration: BoxDecoration(
        borderRadius: _effectiveStyle.trackBorderRadius!,
        color: _getTrackColor(),
        gradient: _getTrackGradient(),
        border: _effectiveStyle.trackBorder,
        boxShadow: _effectiveStyle.trackShadow,
      ),
    );
  }

  Color _getTrackColor() {
    if (_effectiveStyle.activeTrackGradient != null ||
        _effectiveStyle.inactiveTrackGradient != null) {
      return context.secondary;
    }
    return Color.lerp(
      widget.enabled
          ? _effectiveStyle.inactiveTrackColor!
          : _effectiveStyle.inactiveTrackColor!.withValues(alpha: 0.5),
      widget.enabled
          ? _effectiveStyle.activeTrackColor!
          : _effectiveStyle.activeTrackColor!.withValues(alpha: 0.5),
      _animation.value,
    )!;
  }

  Gradient? _getTrackGradient() {
    if (_effectiveStyle.activeTrackGradient == null &&
        _effectiveStyle.inactiveTrackGradient == null) {
      return null;
    }

    // Simple gradient interpolation - you might want to make this more sophisticated
    if (_animation.value > 0.5) {
      return _effectiveStyle.activeTrackGradient;
    } else {
      return _effectiveStyle.inactiveTrackGradient;
    }
  }

  Widget _buildThumb() {
    final double position = _animation.value * _maxThumbPosition;

    final thumbColor = Color.lerp(
      _effectiveStyle.inactiveThumbColor!,
      _effectiveStyle.activeThumbColor!,
      _animation.value,
    );
    return Positioned(
      left: _effectiveStyle.trackPadding! + position,
      top: (_effectiveStyle.height! - _thumbSize.height) / 2,
      child: Container(
        width: _thumbSize.width,
        height: _thumbSize.height,
        decoration: BoxDecoration(
          color: _effectiveStyle.thumbGradient == null ? thumbColor : null,
          gradient: _effectiveStyle.thumbGradient,
          borderRadius: _effectiveStyle.thumbBorderRadius!,
          border: _effectiveStyle.thumbBorder,
          boxShadow: _effectiveStyle.thumbShadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
        ),
        child: _buildThumbContent(),
      ),
    );
  }

  Widget? _buildThumbContent() {
    Widget? icon = _isActive
        ? _effectiveStyle.activeThumbIcon
        : _effectiveStyle.inactiveThumbIcon;
    if (icon != null) {
      return Center(child: icon);
    }
    return null;
  }

  Widget _buildText() {
    final activeText = widget.activeText;
    final inactiveText = widget.inactiveText;

    if (_isDragging) {
      return const SizedBox.shrink();
    }
    if (activeText == null && inactiveText == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Row(
        children: [
          if (inactiveText != null && widget.value)
            Expanded(
              child: _buildTextWidget(
                  inactiveText,
                  _effectiveStyle.inactiveTextStyle ??
                      context.textTheme.bodySmall!,
                  Alignment.centerLeft,
                  EdgeInsets.only(left: 7)),
            ),
          if (activeText != null && !widget.value)
            Expanded(
              child: _buildTextWidget(
                  activeText,
                  _effectiveStyle.activeTextStyle ??
                      context.textTheme.bodySmall!,
                  Alignment.centerRight,
                  EdgeInsets.symmetric(horizontal: 11)),
            ),
        ],
      ),
    );
  }

  Widget _buildTextWidget(String text, TextStyle style, Alignment alignment,
      EdgeInsetsGeometry? padding) {
    return Container(
      padding: _effectiveStyle.trackPadding != null
          ? EdgeInsets.symmetric(horizontal: _effectiveStyle.trackPadding! * 2)
          : padding,
      alignment: alignment,
      child: Text(
        text,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1.0 : 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: widget.allowTap ? _handleTap : null,
              onPanStart: widget.allowDrag ? _handlePanStart : null,
              onPanUpdate: widget.allowDrag ? _handlePanUpdate : null,
              onPanEnd: widget.allowDrag ? _handlePanEnd : null,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      _buildTrack(),
                      _buildText(),
                      _buildThumb(),
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}
