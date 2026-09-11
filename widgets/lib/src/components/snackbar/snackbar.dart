import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

export 'snackbar_action.dart';
export 'snackbar_enums.dart';
export 'snackbar_theme.dart';

class MechanixSnackbar extends StatelessWidget {
  /// Creates a [MechanixSnackbar] with a custom [message] widget.
  const MechanixSnackbar({
    super.key,
    required this.message,
    this.action,
    this.showCloseIcon = false,
    this.onClose,
    this.layout = SnackbarLayout.auto,
    this.theme,
    this.width,
    this.margin,
    this.behavior,
    this.actionOverflowThreshold,
    bool? persist,
    this.onVisible,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation,
    this.padding,
  }) : persist = persist ?? action != null,
       assert(
         margin == null || width == null,
         'Cannot provide both a margin and a width',
       ),
       assert(
         behavior != SnackBarBehavior.fixed ||
             (margin == null && width == null),
         'Margin and width can only be used with SnackBarBehavior.floating',
       ),
       assert(
         actionOverflowThreshold == null ||
             (actionOverflowThreshold >= 0.0 && actionOverflowThreshold <= 1.0),
         'Action overflow threshold must be between 0.0 and 1.0 inclusive',
       );

  /// Factory constructor for displaying a plain text message.
  factory MechanixSnackbar.text({
    Key? key,
    required String text,
    MechanixSnackbarAction? action,
    bool showCloseIcon = false,
    VoidCallback? onClose,
    SnackbarLayout layout = SnackbarLayout.auto,
    MechanixSnackbarThemeData? theme,
    double? width,
    EdgeInsetsGeometry? margin,
    SnackBarBehavior? behavior,
    double? actionOverflowThreshold,
    bool? persist,
    VoidCallback? onVisible,
    Clip clipBehavior = Clip.hardEdge,
    HitTestBehavior? hitTestBehavior,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    assert(
      margin == null || width == null,
      'Cannot provide both a margin and a width',
    );
    assert(
      behavior != SnackBarBehavior.fixed || (margin == null && width == null),
      'Margin and width can only be used with SnackBarBehavior.floating',
    );
    assert(
      actionOverflowThreshold == null ||
          (actionOverflowThreshold >= 0.0 && actionOverflowThreshold <= 1.0),
      'Action overflow threshold must be between 0.0 and 1.0 inclusive',
    );

    return MechanixSnackbar(
      key: key,
      message: Text(text, maxLines: maxLines, overflow: overflow),
      action: action,
      showCloseIcon: showCloseIcon,
      onClose: onClose,
      layout: layout,
      theme: theme,
      width: width,
      margin: margin,
      behavior: behavior,
      actionOverflowThreshold: actionOverflowThreshold,
      persist: persist,
      onVisible: onVisible,
      clipBehavior: clipBehavior,
      hitTestBehavior: hitTestBehavior,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
    );
  }

  /// The primary message widget (typically a [Text] widget).
  final Widget message;

  /// An optional action button displayed within the snackbar.
  final MechanixSnackbarAction? action;

  /// Whether to display a dismiss ('✕') icon button on the trailing edge.
  final bool showCloseIcon;

  /// Optional callback invoked when the dismiss icon button is pressed.
  final VoidCallback? onClose;

  /// The layout strategy for positioning the message, action, and close icon.
  final SnackbarLayout layout;

  /// Optional theme overrides specifically for this snackbar instance.
  final MechanixSnackbarThemeData? theme;

  /// Optional fixed width for the snackbar.
  final double? width;

  /// Optional outer margins around the snackbar.
  final EdgeInsetsGeometry? margin;

  /// Defines whether the snackbar is fixed to the bottom or floating.
  final SnackBarBehavior? behavior;

  /// Threshold ratio of action width to snackbar width above which layout
  final double? actionOverflowThreshold;

  /// Whether the snack bar will stay or auto-dismiss after timeout.
  final bool persist;

  /// Called the first time that the snackbar becomes fully visible.
  final VoidCallback? onVisible;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// How to behave during hit testing.
  final HitTestBehavior? hitTestBehavior;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom text color override.
  final Color? foregroundColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Custom border radius override.
  final BorderRadius? borderRadius;

  /// Custom elevation override.
  final double? elevation;

  /// Custom inner padding override.
  final EdgeInsetsGeometry? padding;

  /// Displays this [MechanixSnackbar] in a floating [SnackBar] using the nearest
  /// [ScaffoldMessenger] from the given [context].
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    Duration duration = const Duration(seconds: 4),
    EdgeInsetsGeometry? margin,
    double? width,
    DismissDirection dismissDirection = DismissDirection.down,
    SnackBarBehavior? behavior,
    bool? persist,
    VoidCallback? onVisible,
    Clip? clipBehavior,
    HitTestBehavior? hitTestBehavior,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      toSnackBar(
        duration: duration,
        margin: margin,
        width: width,
        dismissDirection: dismissDirection,
        behavior: behavior,
        persist: persist,
        onVisible: onVisible,
        clipBehavior: clipBehavior,
        hitTestBehavior: hitTestBehavior,
      ),
    );
  }

  /// Converts this [MechanixSnackbar] into Flutter's native [SnackBar] wrapper
  /// suitable for passing to [ScaffoldMessengerState.showSnackBar].
  SnackBar toSnackBar({
    Duration duration = const Duration(seconds: 4),
    EdgeInsetsGeometry? margin,
    double? width,
    DismissDirection dismissDirection = DismissDirection.down,
    SnackBarBehavior? behavior,
    bool? persist,
    VoidCallback? onVisible,
    Clip? clipBehavior,
    HitTestBehavior? hitTestBehavior,
  }) {
    final effectiveBehavior =
        behavior ??
        this.behavior ??
        theme?.behavior ??
        SnackBarBehavior.floating;
    final isFloating = effectiveBehavior == SnackBarBehavior.floating;

    final effectiveWidth = isFloating ? (width ?? this.width) : null;
    final effectiveMargin = isFloating
        ? (margin ?? this.margin ?? theme?.margin)
        : null;

    final effectivePersist = persist ?? this.persist;
    final effectiveOnVisible = onVisible ?? this.onVisible;
    final effectiveClip = clipBehavior ?? this.clipBehavior;
    final effectiveHitTest = hitTestBehavior ?? this.hitTestBehavior;

    assert(
      effectiveWidth == null || effectiveMargin == null,
      'Cannot provide both a margin and a width to MechanixSnackbar',
    );
    assert(
      effectiveBehavior == SnackBarBehavior.floating ||
          (margin == null &&
              this.margin == null &&
              width == null &&
              this.width == null),
      'Margin and width can only be used with SnackBarBehavior.floating',
    );

    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      behavior: effectiveBehavior,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      margin: !isFloating
          ? null
          : (effectiveWidth != null
                ? null
                : (effectiveMargin ??
                      const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ))),
      width: effectiveWidth,
      duration: duration,
      dismissDirection: dismissDirection,
      persist: effectivePersist,
      onVisible: effectiveOnVisible,
      clipBehavior: effectiveClip,
      hitTestBehavior: effectiveHitTest,
      content: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = _resolveTheme(context);
    final effectiveBehavior =
        behavior ?? effectiveTheme.behavior ?? SnackBarBehavior.floating;
    final isFixed = effectiveBehavior == SnackBarBehavior.fixed;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isStacked = _resolveIsStacked(
          constraints,
          effectiveTheme,
          context,
        );

        final Widget content = isStacked
            ? _buildStackedLayout(context, effectiveTheme)
            : _buildInlineLayout(context, effectiveTheme);

        final double? effectiveMaxWidth = isFixed
            ? null
            : (width ?? effectiveTheme.maxWidth);

        final BorderRadiusGeometry effectiveBorderRadius = isFixed
            ? BorderRadius.zero
            : (borderRadius ??
                  effectiveTheme.borderRadius ??
                  BorderRadius.circular(8.0));

        final double effectiveElevation = isFixed
            ? 0.0
            : (elevation ?? effectiveTheme.elevation ?? 2.0);

        Widget snackbarContent = Container(
          padding: padding ?? effectiveTheme.padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? effectiveTheme.backgroundColor,
            borderRadius: effectiveBorderRadius,
            border: isFixed
                ? null
                : Border.all(
                    color:
                        borderColor ??
                        effectiveTheme.borderColor ??
                        Colors.transparent,
                    width: effectiveTheme.borderWidth ?? 1.0,
                  ),
          ),
          child: DefaultTextStyle(
            style:
                (effectiveTheme.contentTextStyle ??
                        context.textTheme.bodyMedium ??
                        const TextStyle(
                          fontSize: 14,
                          fontFamily: mechanixFontFamily,
                        ))
                    .copyWith(
                      color: foregroundColor ?? effectiveTheme.foregroundColor,
                    ),
            child: Semantics(liveRegion: true, child: content),
          ),
        );

        if (isFixed) {
          return Material(
            color: Colors.transparent,
            elevation: effectiveElevation,
            clipBehavior: clipBehavior,
            child: SafeArea(top: false, child: snackbarContent),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: effectiveMaxWidth ?? double.infinity,
            ),
            child: Material(
              color: Colors.transparent,
              elevation: effectiveElevation,
              borderRadius: effectiveBorderRadius,
              clipBehavior: clipBehavior,
              child: snackbarContent,
            ),
          ),
        );
      },
    );
  }

  /// Determines whether to render an inline (horizontal) or stacked (vertical) layout.
  ///
  /// when available width is constrained or the action label is long, moving the action
  /// below the message prevents text squeezing and RenderFlex layout overflow errors.
  bool _resolveIsStacked(
    BoxConstraints constraints,
    MechanixSnackbarThemeData effectiveTheme,
    BuildContext context,
  ) {
    switch (layout) {
      case SnackbarLayout.stacked:
        return true;
      case SnackbarLayout.inline:
        return false;
      case SnackbarLayout.auto:
        if (action == null) return false;
        if (!constraints.hasBoundedWidth) return false;

        // Maximum ratio of snackbar width that the action and close icon can
        // occupy before triggering a stacked layout (defaults to 25% in Material 3).
        final double threshold =
            actionOverflowThreshold ??
            effectiveTheme.actionOverflowThreshold ??
            0.25;

        final actionStyle =
            effectiveTheme.actionTextStyle ?? context.textTheme.labelLarge;

        // Measure the rendered pixel width of the action label to account for
        // localized text, custom typography, and system accessibility font scaling.
        final textPainter = TextPainter(
          text: TextSpan(text: action!.label, style: actionStyle),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

        // Account for horizontal padding and the 48dp minimum accessible touch width.
        final double actionWidth = (textPainter.size.width + 20.0).clamp(
          48.0,
          double.infinity,
        );
        textPainter.dispose();

        final double closeWidth = showCloseIcon ? 48.0 : 0.0;
        final double totalActionAndIconWidth = actionWidth + closeWidth + 16.0;

        // If the action and trailing controls occupy more than the threshold ratio
        // of available width, switch to stacked layout to give the message room.
        final double ratio = totalActionAndIconWidth / constraints.maxWidth;
        return ratio > threshold;
    }
  }

  Widget _buildInlineLayout(
    BuildContext context,
    MechanixSnackbarThemeData effectiveTheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: message),
        if (action != null) ...[
          const SizedBox(width: 16.0),
          _buildActionButton(context, effectiveTheme),
        ],
        if (showCloseIcon) ...[
          const SizedBox(width: 8.0),
          _buildCloseButton(context, effectiveTheme),
        ],
      ],
    );
  }

  Widget _buildStackedLayout(
    BuildContext context,
    MechanixSnackbarThemeData effectiveTheme,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        message,
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (action != null)
              Flexible(child: _buildActionButton(context, effectiveTheme)),
            if (showCloseIcon) ...[
              const SizedBox(width: 8.0),
              _buildCloseButton(context, effectiveTheme),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    MechanixSnackbarThemeData effectiveTheme,
  ) {
    assert(action != null);
    final act = action!;

    final Color actionColor =
        act.textColor ??
        effectiveTheme.actionColor ??
        Theme.of(context).colorScheme.primary;

    return _SnackbarActionButton(
      action: act,
      color: actionColor,
      hoverColor: effectiveTheme.actionHoverColor,
      textStyle: effectiveTheme.actionTextStyle,
      showFocusIndicator: effectiveTheme.showFocusIndicator ?? true,
      focusBorderColor: effectiveTheme.focusBorderColor ?? actionColor,
    );
  }

  Widget _buildCloseButton(
    BuildContext context,
    MechanixSnackbarThemeData effectiveTheme,
  ) {
    final Color closeColor =
        effectiveTheme.closeIconColor ?? Theme.of(context).colorScheme.primary;

    return _SnackbarCloseButton(
      color: closeColor,
      hoverColor: effectiveTheme.actionHoverColor,
      showFocusIndicator: effectiveTheme.showFocusIndicator ?? true,
      focusBorderColor: effectiveTheme.focusBorderColor ?? closeColor,
      onPressed: () {
        onClose?.call();
        ScaffoldMessenger.maybeOf(context)
            ?.hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      },
    );
  }

  MechanixSnackbarThemeData _resolveTheme(BuildContext context) {
    final ancestor = MechanixSnackbarTheme.maybeOf(context);
    final fallback = MechanixSnackbarThemeData.standard(
      Theme.of(context).colorScheme,
      Theme.of(context).textTheme,
    );

    var resolved = ancestor ?? fallback;
    if (theme != null) {
      resolved = resolved.copyWith(
        backgroundColor: theme!.backgroundColor,
        foregroundColor: theme!.foregroundColor,
        actionColor: theme!.actionColor,
        actionHoverColor: theme!.actionHoverColor,
        closeIconColor: theme!.closeIconColor,
        borderColor: theme!.borderColor,
        borderWidth: theme!.borderWidth,
        borderRadius: theme!.borderRadius,
        elevation: theme!.elevation,
        padding: theme!.padding,
        margin: theme!.margin,
        maxWidth: theme!.maxWidth,
        behavior: theme!.behavior,
        actionOverflowThreshold: theme!.actionOverflowThreshold,
        contentTextStyle: theme!.contentTextStyle,
        actionTextStyle: theme!.actionTextStyle,
        showFocusIndicator: theme!.showFocusIndicator,
        focusBorderColor: theme!.focusBorderColor,
      );
    }
    return resolved;
  }
}

class _SnackbarActionButton extends StatefulWidget {
  const _SnackbarActionButton({
    required this.action,
    required this.color,
    this.hoverColor,
    this.textStyle,
    required this.showFocusIndicator,
    required this.focusBorderColor,
  });

  final MechanixSnackbarAction action;
  final Color color;
  final Color? hoverColor;
  final TextStyle? textStyle;
  final bool showFocusIndicator;
  final Color focusBorderColor;

  @override
  State<_SnackbarActionButton> createState() => _SnackbarActionButtonState();
}

class _SnackbarActionButtonState extends State<_SnackbarActionButton> {
  bool _haveTriggeredAction = false;

  void _handleTap() {
    if (!widget.action.isEnabled || _haveTriggeredAction) return;
    setState(() => _haveTriggeredAction = true);
    widget.action.onPressed!();
    ScaffoldMessenger.maybeOf(context)
        ?.hideCurrentSnackBar(reason: SnackBarClosedReason.action);
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.action.isEnabled;

    Widget button = MechanixButton.text(
      onPressed: isEnabled ? _handleTap : null,
      label: widget.action.label,
      focusNode: widget.action.focusNode,
      autofocus: widget.action.autofocus,
      size: ButtonSize.xSmall,
    );

    if (widget.action.semanticLabel != null) {
      button = Semantics(label: widget.action.semanticLabel, child: button);
    }

    return button;
  }
}

class _SnackbarCloseButton extends StatelessWidget {
  const _SnackbarCloseButton({
    required this.color,
    this.hoverColor,
    required this.showFocusIndicator,
    required this.focusBorderColor,
    required this.onPressed,
  });

  final Color color;
  final Color? hoverColor;
  final bool showFocusIndicator;
  final Color focusBorderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final tooltip = MaterialLocalizations.of(context).closeButtonTooltip;

    return Tooltip(
      message: tooltip,
      child: MechanixIconButton.standard(
        icon: MechanixIcons.x,
        onPressed: onPressed,
        size: IconButtonSize.xSmall,
        foregroundColor: color,
      ),
    );
  }
}
