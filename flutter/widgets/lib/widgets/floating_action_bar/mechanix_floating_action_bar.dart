import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/utils/menu_utils.dart';

class MechanixFloatingActionBar extends StatefulWidget {
  const MechanixFloatingActionBar({
    super.key,
    required this.menus,
    this.menuButton,
    this.floatingActionBarController,
    this.animationDuration = const Duration(milliseconds: 300),
    this.initiallyOpen = false,
    this.dropdownPosition = DropdownPosition.bottomCenter,
    this.theme,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.padding,
    this.primary,
    this.restorationId,
    this.findChildIndexCallback,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = true,
    this.offset = Offset.zero,
    this.isMenuButtonRequired = true,
    this.buttonIcon,
  });

  final List<Widget> menus;
  final Widget? menuButton;
  final FloatingActionBarController? floatingActionBarController;
  final Duration animationDuration;
  final bool initiallyOpen;
  final DropdownPosition dropdownPosition;
  final MechanixFloatingActionBarThemeData? theme;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior hitTestBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? Function(Key key)? findChildIndexCallback;
  final bool shrinkWrap;
  final Offset offset;
  final bool isMenuButtonRequired;
  final IconWidget? buttonIcon;

  @override
  State<MechanixFloatingActionBar> createState() =>
      _MechanixFloatingActionBarState();
}

class _MechanixFloatingActionBarState extends State<MechanixFloatingActionBar> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    isClicked = widget.initiallyOpen;

    widget.floatingActionBarController?._setCallbacks(
      open: _openMenu,
      close: _closeMenu,
      toggle: _toggleMenu,
    );
  }

  void _openMenu() {
    if (_overlayEntry == null) {
      final fabTheme = MechanixFloatingActionBarTheme.of(context)
          .merge(widget.theme, context);
      setState(() {
        isClicked = true;
      });
      _showOptions(context, fabTheme);
    }
  }

  void _closeMenu() {
    _hideOptions();
  }

  void _toggleMenu() {
    if (_overlayEntry == null) {
      _openMenu();
    } else {
      _closeMenu();
    }
  }

  void _showOptions(
      BuildContext context, MechanixFloatingActionBarThemeData fabTheme) {
    _overlayEntry = OverlayEntry(
      builder: (context) => _MechanixFloatingActionBarContainerState(
        layerLink: _layerLink,
        onClose: _closeMenu,
        menus: widget.menus,
        fabTheme: fabTheme,
        dropdownPosition: widget.dropdownPosition,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        controller: widget.controller,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        offset: widget.offset,
        shrinkWrap: widget.shrinkWrap,
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hideOptions() {
    setState(() {
      isClicked = false;
    });
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.isMenuButtonRequired
          ? ((widget.menuButton != null)
              ? GestureDetector(
                  onTap: _toggleMenu,
                  child: widget.menuButton,
                )
              : IconButton(
                  onPressed: _toggleMenu,
                  isSelected: isClicked,
                  icon: widget.buttonIcon ??
                      IconWidget.fromIconData(
                        icon: Icon(Icons.more_vert),
                        boxWidth: 48,
                        boxHeight: 40,
                        iconWidth: 20,
                        iconHeight: 20,
                      ),
                ))
          : null,
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}

class _MechanixFloatingActionBarContainerState extends StatefulWidget {
  const _MechanixFloatingActionBarContainerState({
    required this.layerLink,
    required this.menus,
    required this.onClose,
    required this.fabTheme,
    required this.dropdownPosition,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.cacheExtent,
    required this.clipBehavior,
    required this.controller,
    required this.dragStartBehavior,
    required this.hitTestBehavior,
    required this.keyboardDismissBehavior,
    required this.padding,
    required this.primary,
    required this.restorationId,
    required this.reverse,
    required this.scrollDirection,
    required this.findChildIndexCallback,
    required this.offset,
    required this.shrinkWrap,
  });

  final LayerLink layerLink;
  final List<Widget> menus;
  final VoidCallback onClose;
  final MechanixFloatingActionBarThemeData fabTheme;
  final DropdownPosition dropdownPosition;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior hitTestBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? Function(Key key)? findChildIndexCallback;
  final bool shrinkWrap;
  final Offset offset;
  @override
  State<_MechanixFloatingActionBarContainerState> createState() =>
      __MechanixFloatingActionBarContainerState();
}

class __MechanixFloatingActionBarContainerState
    extends State<_MechanixFloatingActionBarContainerState>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  Widget buiMenuContent(Widget child) {
    final menuChild = Material(
      child: ClipRect(child: child),
    );

    return FadeTransition(
      opacity: _opacityAnimation,
      child: menuChild,
    );
  }

  void _handleClose() {
    _animationController.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anchors = getDropDownPosition(widget.dropdownPosition);
    return GestureDetector(
      onTap: () {
        _handleClose();
      },
      child: Stack(
        children: [
          Positioned(
            child: CompositedTransformFollower(
              link: widget.layerLink,
              followerAnchor: anchors.followerAnchor,
              targetAnchor: anchors.targetAnchor,
              offset: widget.offset,
              child: buiMenuContent(
                Container(
                  padding: widget.fabTheme.padding,
                  height: widget.fabTheme.height,
                  decoration: widget.fabTheme.decoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.menus,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingActionBarController {
  VoidCallback? _open;
  VoidCallback? _close;
  VoidCallback? _toggle;

  void open() => _open?.call();

  void close() => _close?.call();

  void toggle() => _toggle?.call();

  void _setCallbacks({
    required VoidCallback open,
    required VoidCallback close,
    required VoidCallback toggle,
  }) {
    _open = open;
    _close = close;
    _toggle = toggle;
  }

  void dispose() {
    _open = null;
    _close = null;
    _toggle = null;
  }
}
