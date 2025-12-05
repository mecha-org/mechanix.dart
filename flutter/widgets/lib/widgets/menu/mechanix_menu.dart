import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/constants/menu_selection_type.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';
import 'package:widgets/widgets/menu/utils/menu_utils.dart';

class MechanixMenu extends StatefulWidget {
  const MechanixMenu({
    super.key,
    required this.items,
    this.menuButton,
    this.animationType = MenuTransitions.fade,
    this.animationDuration = const Duration(milliseconds: 600),
    this.dropdownPosition = DropdownPosition.bottomCenter,
    this.theme,
    this.openMenu,
    this.closeMenu,
    this.onSelectionChanged,
    this.selectionType = MenuSelection.none,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.separatorBuilder,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.offset = Offset.zero,
    this.shrinkWrap = true,
    this.buttonIcon,
    this.menuController,
    this.isMenuButtonRequired = true,
  })  : itemCount = 0,
        itemBuilder = null,
        isCustomBuilder = false;

  const MechanixMenu.builder({
    super.key,
    this.menuButton,
    this.animationType = MenuTransitions.fade,
    this.animationDuration = const Duration(milliseconds: 600),
    this.dropdownPosition = DropdownPosition.bottomCenter,
    this.theme,
    this.openMenu,
    this.closeMenu,
    this.onSelectionChanged,
    this.selectionType = MenuSelection.none,
    this.separatorBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.primary,
    this.restorationId,
    this.findChildIndexCallback,
    this.offset = Offset.zero,
    this.shrinkWrap = true,
    this.buttonIcon,
    this.menuController,
    this.isMenuButtonRequired = true,
    required this.itemBuilder,
    required this.itemCount,
  })  : items = const [],
        isCustomBuilder = true;

  final List<MechanixMenuItemsType> items;
  final IconButton? menuButton;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final DropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;
  final VoidCallback? openMenu;
  final VoidCallback? closeMenu;
  final Function(List<String> selectedValues)? onSelectionChanged;
  final MenuSelection selectionType;
  final bool isCustomBuilder;
  final int itemCount;
  final Widget? Function(BuildContext context, int index)? itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
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
  final Offset offset;
  final bool shrinkWrap;
  final IconWidget? buttonIcon;
  final MechanixMenuController? menuController;
  final bool isMenuButtonRequired;

  @override
  State<MechanixMenu> createState() => _MechanixMenuState();
}

class _MechanixMenuState extends State<MechanixMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isClicked = false;
  List<String> _selectedValues = [];

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.items
        .where((item) => item.isSelected)
        .map((item) => item.value)
        .toList();

    widget.menuController?._setCallbacks(
      open: _openMenu,
      close: _closeMenu,
      toggle: _toggleMenu,
    );
  }

  void _openMenu() {
    if (_overlayEntry == null) {
      setState(() {
        isClicked = true;
      });
      _showOptions(context);
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

  void _handleSelectionChanged(List<String> newSelectedValues) {
    setState(() {
      _selectedValues = newSelectedValues;
    });
    widget.onSelectionChanged?.call(newSelectedValues);
  }

  void _showOptions(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => _MechanixMenuContainer(
        layerLink: _layerLink,
        onClose: _closeMenu,
        items: widget.items,
        animationType: widget.animationType,
        animationDuration: widget.animationDuration,
        dropdownPosition: widget.dropdownPosition,
        theme: widget.theme,
        selectionType: widget.selectionType,
        selectedValues: _selectedValues,
        onSelectionChanged: _handleSelectionChanged,
        separatorBuilder: widget.separatorBuilder,
        itemBuilder: widget.itemBuilder,
        isCustomBuilder: widget.isCustomBuilder,
        itemCount: widget.itemCount,
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

    if (widget.openMenu != null) {
      widget.openMenu?.call();
    }
  }

  void _hideOptions() {
    if (widget.closeMenu != null) {
      widget.closeMenu?.call();
    }
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

class _MechanixMenuContainer extends StatefulWidget {
  const _MechanixMenuContainer({
    required this.layerLink,
    required this.onClose,
    required this.items,
    required this.animationType,
    required this.animationDuration,
    required this.dropdownPosition,
    required this.theme,
    required this.selectionType,
    required this.selectedValues,
    required this.onSelectionChanged,
    required this.separatorBuilder,
    required this.itemBuilder,
    required this.isCustomBuilder,
    required this.itemCount,
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
  final VoidCallback onClose;
  final List<MechanixMenuItemsType> items;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final DropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;
  final MenuSelection selectionType;
  final List<String> selectedValues;
  final bool isCustomBuilder;
  final int itemCount;
  final Function(List<String> selectedValues) onSelectionChanged;
  final Widget? Function(BuildContext context, int index)? itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
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
  State<_MechanixMenuContainer> createState() => _MechanixMenuContainerState();
}

class _MechanixMenuContainerState extends State<_MechanixMenuContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heightAnimation;
  late Animation<double> _widthAnimation;
  late Animation<Offset> _slideAnimation;

  static const opacityAnimationList = [
    MenuTransitions.fade,
    MenuTransitions.scale,
    MenuTransitions.slideDown,
    MenuTransitions.slideLeft,
    MenuTransitions.slideRight,
    MenuTransitions.slideUp
  ];
  static const scaleAnimationList = [MenuTransitions.scale];
  static const scaleYAnimationList = [MenuTransitions.scaleY];
  static const scaleXAnimationList = [MenuTransitions.scaleX];
  static const slideAnimationList = [
    MenuTransitions.slideDown,
    MenuTransitions.slideLeft,
    MenuTransitions.slideRight,
    MenuTransitions.slideUp
  ];

  List<String> _currentSelectedValues = [];

  @override
  void initState() {
    super.initState();
    _currentSelectedValues = List.from(widget.selectedValues);

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    if (opacityAnimationList.contains(widget.animationType)) {
      _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
    }

    if (scaleAnimationList.contains(widget.animationType)) {
      _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOutBack,
        ),
      );
    }

    if (scaleYAnimationList.contains(widget.animationType)) {
      _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
    }

    if (scaleXAnimationList.contains(widget.animationType)) {
      _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
    }

    if (slideAnimationList.contains(widget.animationType)) {
      _slideAnimation = _getSlideAnimation();
    }

    _animationController.forward();
  }

  void _handleItemTap(int index, MechanixMenuItemsType item) {
    if (item.disabled) return;

    switch (widget.selectionType) {
      case MenuSelection.single:
        _handleSingleSelection(index.toString());
        break;
      case MenuSelection.multiple:
        _handleMultiSelection(index.toString());
        break;
      case MenuSelection.none:
        item.onTap?.call();
        break;
    }

    if (widget.selectionType == MenuSelection.none) {
      _handleClose();
    } else {
      item.onTap?.call();
    }
  }

  void _handleSingleSelection(String value) {
    setState(() {
      if (_currentSelectedValues.contains(value)) {
        _currentSelectedValues.remove(value);
      } else {
        _currentSelectedValues = [value];
      }
    });
    widget.onSelectionChanged(_currentSelectedValues);
  }

  void _handleMultiSelection(String value) {
    setState(() {
      if (_currentSelectedValues.contains(value)) {
        _currentSelectedValues.remove(value);
      } else {
        _currentSelectedValues.add(value);
      }
    });
    widget.onSelectionChanged(_currentSelectedValues);
  }

  bool _isItemSelected(String item) {
    return _currentSelectedValues.contains(item);
  }

  Widget? _buildTrailing(int index, MechanixMenuItemsType item, bool isSelected,
      MechanixMenuThemeData theme) {
    if (item.trailing != null) return item.trailing;

    switch (widget.selectionType) {
      case MenuSelection.single:
        return Radio<bool>(
          value: isSelected,
          groupValue: true,
          onChanged: item.disabled
              ? null
              : (value) {
                  if (value != null) {
                    _handleSingleSelection(index.toString());
                  }
                },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );

      case MenuSelection.multiple:
        return Checkbox(
          value: isSelected,
          onChanged: item.disabled
              ? null
              : (value) {
                  if (value != null) {
                    _handleMultiSelection(index.toString());
                  }
                },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        );

      case MenuSelection.none:
        return null;
    }
  }

  Animation<Offset> _getSlideAnimation() {
    switch (widget.animationType) {
      case MenuTransitions.slideLeft:
        return Tween<Offset>(
          begin: const Offset(-0.3, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      case MenuTransitions.slideRight:
        return Tween<Offset>(
          begin: const Offset(0.3, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      case MenuTransitions.slideDown:
        return Tween<Offset>(
          begin: const Offset(0.0, -0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      case MenuTransitions.slideUp:
        return Tween<Offset>(
          begin: const Offset(0.0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      default:
        return Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(_animationController);
    }
  }

  @override
  void didUpdateWidget(_MechanixMenuContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationType != widget.animationType) {
      _slideAnimation = _getSlideAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleClose() {
    // Animate out and then call onClose
    _animationController.reverse().then((_) {
      widget.onClose();
    });
  }

  Widget _buildAnimatedMenuContent({
    required Widget child,
    required MechanixMenuThemeData theme,
  }) {
    // Widget contentChild;

    // // Apply custom shape if provided, otherwise use the existing borderRadius
    // if (widget.customShape != null) {
    //   contentChild = ClipPath(
    //     clipper: widget.customShape,
    //     // clipBehavior: Clip.none,
    //     child: Material(
    //       elevation: theme.elevation ?? 4,
    //       // color: theme.itemBackgroundColor,
    //       color: Colors.red,
    //       child: child,
    //     ),
    //   );
    // } else {
    //   contentChild = Material(
    //     elevation: theme.elevation ?? 4,
    //     color: theme.itemBackgroundColor,
    //     borderRadius: theme.borderRadius,
    //     child: ClipRRect(
    //       borderRadius: theme.borderRadius ?? BorderRadius.zero,
    //       child: child,
    //     ),
    //   );
    // }

    final contentChild = Material(
      type: MaterialType.transparency,
      child: ClipPath(
        clipper: FolderTabClipper(),
        child: child,
        // child: Container(padding: const EdgeInsets.only(top: 20), child: child),
      ),
    );

    switch (widget.animationType) {
      case MenuTransitions.fade:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: contentChild,
        );
      case MenuTransitions.scale:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: contentChild,
          ),
        );
      case MenuTransitions.scaleY:
        return AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: _heightAnimation.value,
                child: child,
              ),
            );
          },
          child: contentChild,
        );
      case MenuTransitions.scaleX:
        return AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                widthFactor: _widthAnimation.value,
                child: child,
              ),
            );
          },
          child: contentChild,
        );
      case MenuTransitions.slideLeft:
      case MenuTransitions.slideRight:
      case MenuTransitions.slideDown:
      case MenuTransitions.slideUp:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: contentChild,
          ),
        );
    }
  }

  Widget getMenuBUilder(MechanixMenuThemeData menuTheme) {
    if (widget.isCustomBuilder) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return widget.itemBuilder?.call(context, index);
        },
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
        shrinkWrap: widget.shrinkWrap,
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final MechanixMenuItemsType item = widget.items[index];
        final bool isSelected = _isItemSelected(index.toString());

        return _MenuItem(
          theme: menuTheme,
          index: index,
          title: item.title,
          leading: item.leading,
          trailing: _buildTrailing(index, item, isSelected, menuTheme),
          onTap: () => _handleItemTap(index, item),
          onTapUp: item.onTapUp,
          onTapDown: item.onTapDown,
          onDoubleTap: item.onDoubleTap,
          titleTextStyle: item.titleTextStyle,
          disabled: item.disabled,
          isSelected: item.isSelected,
          selectionType: widget.selectionType,
          leadingPadding: item.leadingPadding,
          trailingPadding: item.trailingPadding,
          handleClose: _handleClose,
        );
      },
      shrinkWrap: widget.shrinkWrap,
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
      separatorBuilder: widget.separatorBuilder ??
          (context, index) => Divider(
                color: context.outline,
                thickness: 1,
                height: 1,
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuTheme =
        MechanixMenuTheme.of(context).merge(widget.theme, context);

    final anchors = getDropDownPosition(widget.dropdownPosition);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _handleClose,
          ),
        ),
        Positioned(
          child: CompositedTransformFollower(
            link: widget.layerLink,
            showWhenUnlinked: false,
            followerAnchor: anchors.followerAnchor,
            targetAnchor: anchors.targetAnchor,
            offset: widget.offset,
            child: _buildAnimatedMenuContent(
              child: Container(
                width: menuTheme.dropdownWidth,
                height: menuTheme.dropdownHeight,
                constraints: menuTheme.constraints,
                padding: menuTheme.padding,
                clipBehavior: menuTheme.clipBehavior,
                margin: menuTheme.margin,
                transform: menuTheme.transform,
                transformAlignment: menuTheme.transformAlignment,
                alignment: menuTheme.alignment,
                foregroundDecoration: menuTheme.foregroundDecoration,
                decoration: menuTheme.decoration,
                child: getMenuBUilder(menuTheme),
              ),
              theme: menuTheme,
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.index,
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    required this.onTapUp,
    required this.onTapDown,
    required this.onDoubleTap,
    required this.titleTextStyle,
    required this.disabled,
    required this.isSelected,
    required this.theme,
    required this.leadingPadding,
    required this.trailingPadding,
    required this.selectionType,
    required this.handleClose,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final TextStyle? titleTextStyle;
  final GestureTapCallback? onTap;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onDoubleTap;
  final bool disabled;
  final bool isSelected;
  final int index;
  final MechanixMenuThemeData theme;
  final EdgeInsets leadingPadding;
  final EdgeInsets trailingPadding;
  final MenuSelection selectionType;
  final VoidCallback handleClose;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      // ignoring: disabled,
      child: Opacity(
        opacity: disabled ? theme.disableOpacity ?? 0.5 : 1,
        child: Container(
          padding: index == 0 ? const EdgeInsets.only(top: 10) : null,
          height: theme.itemHeight,
          decoration: BoxDecoration(
            color: disabled
                ? theme.disabledBackgroundColor
                : theme.itemBackgroundColor,
          ),
          child: InkWell(
            onTap: disabled ? null : onTap,
            child: Padding(
              padding: theme.itemPadding ?? EdgeInsets.all(0),
              child: Row(children: [
                if (leading != null)
                  Padding(
                    padding: leadingPadding,
                    child: leading,
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: disabled
                        ? theme.disabledTextStyle
                        : theme.titleTextStyle,
                  ),
                ),
                if (trailing != null)
                  Padding(
                    padding: trailingPadding,
                    child: trailing,
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class MechanixMenuController {
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

class FolderTabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 8; // Outer rounded corners
    const double tabH = 12; // Tab height
    const double tabW = 42; // Tab width
    const double tabSlope = 12; // Small sloped curve
    const double shift = 80; // Shift tab right by this amount

    final Path p = Path();

    // ----- Bottom-left corner -----
    p.moveTo(radius, size.height);
    p.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // ----- Left side up to tab start -----
    p.lineTo(0, tabH + radius);

    // ----- Slope into the tab (shift applied) -----
    p.quadraticBezierTo(
      0,
      tabH,
      tabSlope,
      tabH,
    );

    // ----- Top of tab (shift applied) -----
    p.lineTo(shift + tabW, tabH);

    // ----- Tab end slope upward (shift applied) -----
    p.quadraticBezierTo(
      shift + tabW + tabSlope,
      tabH,
      shift + tabW + tabSlope,
      tabH - tabSlope,
    );

    // ----- Connect into top bar (shift applied) -----
    p.lineTo(shift + tabW + tabSlope, radius);
    p.quadraticBezierTo(
      shift + tabW + tabSlope,
      0,
      shift + tabW + tabSlope + radius,
      0,
    );

    // ----- Top-right corner (UNCHANGED) -----
    p.lineTo(size.width - radius, 0);
    p.quadraticBezierTo(size.width, 0, size.width, radius);

    // ----- Right side down (UNCHANGED) -----
    p.lineTo(size.width, size.height - radius);
    p.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // ----- Bottom side (UNCHANGED) -----
    p.lineTo(radius, size.height);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// class MenuExactSvgShape extends CustomClipper<Path> {
//   final double offsetX;
//   final double offsetY;

//   MenuExactSvgShape({
//     this.offsetX = 0.0,
//     this.offsetY = 0.0,
//   });

//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     // Use the actual size of the container
//     final double width = size.width;
//     final double height = size.height;

//     // Calculate coordinates based on the actual size
//     // Original proportions from your SVG
//     final double startX = (18 / 306) * width + offsetX;
//     final double startY = (270 / 286) * height + offsetY;
//     final double endX = (288 / 306) * width + offsetX;
//     // final double endY = (18 / 286) * height + offsetY;
//     final double controlY1 = (38.0463 / 286) * height + offsetY;
//     final double controlY2 = (33.6281 / 286) * height + offsetY;
//     final double controlY3 = (30.0463 / 286) * height + offsetY;
//     final double cornerX = (26 / 306) * width + offsetX;
//     final double lineBreakX = (167.847 / 306) * width + offsetX;
//     final double controlX1 = (170.505 / 306) * width + offsetX;
//     final double controlX2 = (173.055 / 306) * width + offsetX;
//     final double pointX1 = (174.931 / 306) * width + offsetX;
//     final double pointY1 = (27.1038 / 286) * height + offsetY;
//     final double pointX2 = (181.069 / 306) * width + offsetX;
//     final double pointY2 = (20.9426 / 286) * height + offsetY;
//     final double pointX3 = (182.945 / 306) * width + offsetX;
//     final double pointY3 = (19.0589 / 286) * height + offsetY;
//     final double pointX4 = (185.495 / 306) * width + offsetX;
//     final double pointY4 = (18 / 286) * height + offsetY;
//     final double pointX5 = (188.153 / 306) * width + offsetX;
//     final double topX = (280 / 306) * width + offsetX;
//     final double cornerRadiusX = (284.418 / 306) * width + offsetX;
//     final double cornerY = (26 / 286) * height + offsetY;
//     final double bottomRightY = (270 / 286) * height + offsetY;
//     final double bottomY = (278 / 286) * height + offsetY;

//     path.moveTo(startX, startY);
//     path.lineTo(startX, controlY1);
//     path.cubicTo(
//       startX,
//       controlY2,
//       cornerX,
//       controlY3,
//       cornerX,
//       controlY3,
//     );
//     path.lineTo(lineBreakX, controlY3);
//     path.cubicTo(
//       controlX1,
//       controlY3,
//       controlX2,
//       pointY1,
//       pointX1,
//       pointY1,
//     );
//     path.lineTo(pointX2, pointY2);
//     path.cubicTo(
//       pointX3,
//       pointY3,
//       pointX4,
//       pointY4,
//       pointX5,
//       pointY4,
//     );
//     path.lineTo(topX, pointY4);
//     path.cubicTo(
//       cornerRadiusX,
//       pointY4,
//       endX,
//       cornerY,
//       endX,
//       cornerY,
//     );
//     path.lineTo(endX, bottomRightY);
//     path.cubicTo(
//       endX,
//       bottomY,
//       cornerRadiusX,
//       bottomY,
//       topX,
//       bottomY,
//     );
//     path.lineTo(cornerX, bottomY);
//     path.cubicTo(
//       startX,
//       bottomY,
//       startX,
//       bottomY,
//       startX,
//       startY,
//     );
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return oldClipper is MenuExactSvgShape &&
//         (oldClipper.offsetX != offsetX || oldClipper.offsetY != offsetY);
//   }
// }
