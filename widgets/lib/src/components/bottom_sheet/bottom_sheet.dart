import 'package:flutter/material.dart';

/// A Material 3 Bottom Sheet following the Mechanix design system specifications.
///
/// Wraps Flutter's native [BottomSheet] and provides static presentation methods:
/// - [showModal] for modal presentation with scrim backdrop and drag dismissal.
/// - [show] for standard persistent bottom sheet presentation anchored to a [Scaffold].
class MechanixBottomSheet extends StatefulWidget {
  /// Creates a Mechanix bottom sheet widget.
  const MechanixBottomSheet({
    super.key,
    required this.builder,
    this.onClosing,
    this.animationController,
    this.enableDrag = true,
    this.showDragHandle,
    this.dragHandleColor,
    this.dragHandleSize,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.onDragStart,
    this.onDragEnd,
  });

  /// The builder that produces the bottom sheet content.
  final WidgetBuilder builder;

  /// Called when the bottom sheet begins to close.
  final VoidCallback? onClosing;

  /// Animation controller that drives the entrance and exit animations.
  ///
  /// If null and [enableDrag] is true, [MechanixBottomSheet] creates and manages
  /// an internal animation controller to support drag physics.
  final AnimationController? animationController;

  /// Whether the sheet can be dismissed or resized by dragging.
  final bool enableDrag;

  /// Whether to display a drag handle centered at the top of the sheet.
  ///
  /// If null, the ambient [BottomSheetThemeData.showDragHandle] is used.
  final bool? showDragHandle;

  /// Color of the drag handle.
  final Color? dragHandleColor;

  /// Dimensions of the drag handle.
  final Size? dragHandleSize;

  /// The background color of the sheet surface.
  ///
  /// Defaults to [ColorScheme.surfaceContainerLow] via [ThemeData.bottomSheetTheme].
  final Color? backgroundColor;

  /// The shadow color of the sheet.
  final Color? shadowColor;

  /// The elevation of the sheet surface.
  final double? elevation;

  /// The shape of the sheet.
  ///
  /// Defaults to a square shape with zero radius via [ThemeData.bottomSheetTheme].
  final ShapeBorder? shape;

  /// How to clip the content of the sheet.
  final Clip? clipBehavior;

  /// Box constraints applied to the sheet.
  ///
  /// Defaults to null, resolving to 640dp on desktop for modal sheets via
  /// framework M3 defaults while allowing persistent sheets to remain full-width
  /// unless explicitly constrained.
  final BoxConstraints? constraints;

  /// Callback called when a drag gesture begins.
  final BottomSheetDragStartHandler? onDragStart;

  /// Callback called when a drag gesture ends.
  final BottomSheetDragEndHandler? onDragEnd;

  /// Displays a modal Mechanix bottom sheet above the current application content.
  ///
  /// Leverages Flutter's native [showModalBottomSheet] configured with Mechanix
  /// design system defaults:
  /// - Surface container low background color.
  /// - Material 3 modal scrim barrier tinting.
  /// - Square edge with zero corner radius ([ShapeTheme.none]).
  /// - Centered drag handle.
  /// - 640dp responsive desktop max-width constraint.
  /// - Full keyboard and safe-area inset protection via [avoidKeyboard].
  static Future<T?> showModal<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool? showDragHandle,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useSafeArea = true,
    bool avoidKeyboard = true,
    Color? backgroundColor,
    Color? barrierColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    bool useRootNavigator = false,
    AnimationStyle? sheetAnimationStyle,
  }) {
    WidgetBuilder effectiveBuilder = builder;
    if (avoidKeyboard) {
      effectiveBuilder = (BuildContext sheetContext) {
        final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
        final content = builder(sheetContext);
        if (bottomInset > 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: content,
          );
        }
        return content;
      };
    }

    return showModalBottomSheet<T>(
      context: context,
      builder: effectiveBuilder,
      showDragHandle: showDragHandle,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      useRootNavigator: useRootNavigator,
      sheetAnimationStyle: sheetAnimationStyle,
    );
  }

  /// Displays a persistent (standard) Mechanix bottom sheet anchored to the nearest [Scaffold].
  ///
  /// Unlike [showModal], a standard bottom sheet coexists with the main application UI,
  /// displays no modal scrim, and does not block interaction with the underlying content.
  ///
  /// On wide desktop displays, pass [constraints] (e.g. `BoxConstraints(maxWidth: 640)`)
  /// to constrain the sheet width if full-width layout is not desired.
  static PersistentBottomSheetController show({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    bool? enableDrag,
    AnimationController? transitionAnimationController,
  }) {
    return showBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      enableDrag: enableDrag,
      transitionAnimationController: transitionAnimationController,
    );
  }

  @override
  State<MechanixBottomSheet> createState() => _MechanixBottomSheetState();
}

class _MechanixBottomSheetState extends State<MechanixBottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController? _internalAnimationController;

  AnimationController? get _effectiveAnimationController =>
      widget.animationController ?? _internalAnimationController;

  @override
  void initState() {
    super.initState();
    if (widget.animationController == null && widget.enableDrag) {
      _internalAnimationController = BottomSheet.createAnimationController(this)
        ..value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MechanixBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationController != null &&
        _internalAnimationController != null) {
      _internalAnimationController?.dispose();
      _internalAnimationController = null;
    } else if (widget.animationController == null &&
        _internalAnimationController == null &&
        widget.enableDrag) {
      _internalAnimationController = BottomSheet.createAnimationController(this)
        ..value = 1.0;
    }
  }

  @override
  void dispose() {
    _internalAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _effectiveAnimationController,
      enableDrag: widget.enableDrag,
      showDragHandle: widget.showDragHandle,
      dragHandleColor: widget.dragHandleColor,
      dragHandleSize: widget.dragHandleSize,
      onDragStart: widget.onDragStart,
      onDragEnd: widget.onDragEnd,
      backgroundColor: widget.backgroundColor,
      shadowColor: widget.shadowColor,
      elevation: widget.elevation,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
      constraints: widget.constraints,
      onClosing: widget.onClosing ?? () {},
      builder: widget.builder,
    );
  }
}
