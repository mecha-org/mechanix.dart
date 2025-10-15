import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';
import 'package:widgets/widgets/menu/utils/menu_utils.dart';

class MechanixFloatingActionBar extends StatefulWidget {
  final List<MechanixMenu> menus;
  final Widget? menuButton;
  final Duration animationDuration;
  final bool initiallyOpen;
  final DropdownPosition dropdownPosition;
  final MechanixFloatingActionBarThemeData? theme;

  const MechanixFloatingActionBar({
    super.key,
    required this.menus,
    this.menuButton,
    this.animationDuration = const Duration(milliseconds: 300),
    this.initiallyOpen = false,
    this.dropdownPosition = DropdownPosition.bottomCenter,
    this.theme,
  });

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
  }

  void _showOptions(
      BuildContext context, MechanixFloatingActionBarThemeData fabTheme) {
    _overlayEntry = OverlayEntry(
      builder: (context) => _MechanixFloatingActionBarContainerState(
        layerLink: _layerLink,
        onClose: _hideOptions,
        menus: widget.menus,
        fabTheme: fabTheme,
        dropdownPosition: widget.dropdownPosition,
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

  void _toggleMenu(BuildContext context) {
    final fabTheme =
        MechanixFloatingActionBarTheme.of(context).merge(widget.theme, context);

    if (_overlayEntry == null) {
      setState(() {
        isClicked = true;
      });
      _showOptions(context, fabTheme);
    } else {
      _hideOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: (widget.menuButton != null)
          ? GestureDetector(
              onTap: () => _toggleMenu(context),
              child: widget.menuButton,
            )
          : IconButton(
              onPressed: () => _toggleMenu(context),
              isSelected: isClicked,
              icon: IconWidget.fromIconData(
                icon: Icon(Icons.more_vert),
                boxWidth: 48,
                boxHeight: 40,
                iconWidth: 20,
                iconHeight: 20,
              ),
            ),
    );
  }

  @override
  void dispose() {
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
  });

  final LayerLink layerLink;
  final List<MechanixMenu> menus;
  final VoidCallback onClose;
  final MechanixFloatingActionBarThemeData fabTheme;
  final DropdownPosition dropdownPosition;

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
              child: buiMenuContent(
                Container(
                  padding: widget.fabTheme.padding,
                  height: widget.fabTheme.height,
                  decoration: widget.fabTheme.decoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.menus
                        .map((menu) => MechanixMenu(
                              animationDuration: menu.animationDuration,
                              animationType: menu.animationType,
                              dropdownPosition: menu.dropdownPosition,
                              menuButton: menu.menuButton,
                              closeMenu: _handleClose,
                              onSelectionChanged: menu.onSelectionChanged,
                              selectionType: menu.selectionType,
                              openMenu: menu.openMenu,
                              theme: menu.theme,
                              items: menu.items
                                  .map((item) => MechanixMenuItemsType(
                                        onTap: () {
                                          item.onTap?.call();
                                        },
                                        leading: item.leading,
                                        leadingPadding: item.leadingPadding,
                                        trailing: item.trailing,
                                        trailingPadding: item.trailingPadding,
                                        title: item.title,
                                        titleTextStyle: item.titleTextStyle,
                                        onTapUp: item.onTapUp,
                                        onTapDown: item.onTapDown,
                                        onDoubleTap: item.onDoubleTap,
                                        disabled: item.disabled,
                                        isSelected: item.isSelected,
                                      ))
                                  .toList(),
                            ))
                        .toList(),
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
