import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';
import 'package:widgets/widgets/menu/utils/menu_utils.dart';
import 'package:widgets/widgets/wing/mechanix_wing.dart';

class MechanixMenu extends StatefulWidget {
  const MechanixMenu({
    super.key,
    required this.items,
    this.menuButton,
    this.animationType = MenuTransitions.fade,
    this.animationDuration = const Duration(milliseconds: 600),
    this.dropdownPosition = MenuDropdownPosition.bottom,
    this.theme,
    this.openMenu,
    this.closeMenu,
    this.onSelectionChanged,
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
    this.isDisable = false,
    this.topTabWidth = 42,
    this.dropdownSize = const Size(250, 300),
    this.wingSize = 75,
    this.topTabRightSideShiftLength = 80,
  })  : itemCount = 0,
        itemBuilder = null,
        isCustomBuilder = false;

  const MechanixMenu.builder({
    super.key,
    this.menuButton,
    this.animationType = MenuTransitions.fade,
    this.animationDuration = const Duration(milliseconds: 600),
    this.dropdownPosition = MenuDropdownPosition.bottom,
    this.theme,
    this.openMenu,
    this.closeMenu,
    this.onSelectionChanged,
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
    this.topTabWidth = 42,
    this.topTabRightSideShiftLength = 80,
    this.dropdownSize = const Size(250, 300),
    this.wingSize = 75,
  })  : items = const [],
        isDisable = false,
        isCustomBuilder = true;

  final List<MechanixMenuItemsType> items;
  final IconButton? menuButton;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final MenuDropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;
  final VoidCallback? openMenu;
  final VoidCallback? closeMenu;
  final Function(List<String> selectedValues)? onSelectionChanged;
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
  final bool isDisable;
  final double topTabWidth;
  final double topTabRightSideShiftLength;
  final double wingSize;
  final Size dropdownSize;

  @override
  State<MechanixMenu> createState() => _MechanixMenuState();
}

class _MechanixMenuState extends State<MechanixMenu> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _targetKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();

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
    widget.onSelectionChanged?.call(newSelectedValues);
  }

  void _showOptions(BuildContext context) {
    final Offset smartOffset = calculateSmartOffset(
      context: context,
      menuSize: widget.dropdownSize,
      position: widget.dropdownPosition,
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => _MechanixMenuContainer(
        layerLink: _layerLink,
        onClose: _closeMenu,
        items: widget.items,
        animationType: widget.animationType,
        animationDuration: widget.animationDuration,
        dropdownPosition: widget.dropdownPosition,
        theme: widget.theme,
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
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        offset: smartOffset,
        shrinkWrap: widget.shrinkWrap,
        wingSize: widget.wingSize,
        dropdownSize: widget.dropdownSize,
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
    setState(() => isClicked = false);
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final menuTheme =
        MechanixMenuTheme.of(context).merge(widget.theme, context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.isMenuButtonRequired
          ? Container(
              key: _targetKey,
              height: menuTheme.buttonSize.height,
              width: menuTheme.buttonSize.width,
              decoration: isClicked ? menuTheme.activeButtonDecoration : null,
              margin: menuTheme.buttonMargin,
              padding: menuTheme.buttonPadding,
              child: ((widget.menuButton != null)
                  ? GestureDetector(
                      onTap: _toggleMenu,
                      child: widget.menuButton,
                    )
                  : IconButton(
                      onPressed: _toggleMenu,
                      isSelected: isClicked,
                      icon: widget.buttonIcon ??
                          IconWidget.fromMechanix(
                            iconPath: MechanixIconImages.moreVertIcon,
                            boxWidth: 44,
                            boxHeight: 44,
                            iconWidth: 28,
                            iconHeight: 28,
                            isActive: isClicked,
                          ),
                    )),
            )
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
    required this.primary,
    required this.restorationId,
    required this.reverse,
    required this.scrollDirection,
    required this.findChildIndexCallback,
    required this.offset,
    required this.shrinkWrap,
    required this.wingSize,
    required this.dropdownSize,
  });

  final LayerLink layerLink;
  final VoidCallback onClose;
  final List<MechanixMenuItemsType> items;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final MenuDropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;
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
  final bool? primary;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? Function(Key key)? findChildIndexCallback;
  final bool shrinkWrap;
  final Offset offset;
  final double wingSize;
  final Size dropdownSize;

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

  @override
  void initState() {
    super.initState();

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

    _handleClose();
    item.onTap?.call();
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
    final contentChild = Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: MechanixWing(
          wingWidth: widget.wingSize,
          size: Size(widget.dropdownSize.width, widget.dropdownSize.height),
          color: theme.decoration?.color ?? context.surfaceContainerHigh,
          child: child,
        ),
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
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final MechanixMenuItemsType item = widget.items[index];

        return _MenuItem(
          theme: menuTheme,
          index: index,
          title: item.title,
          leading: item.leading,
          trailing: item.trailing,
          onTap: () => _handleItemTap(index, item),
          onTapUp: item.onTapUp,
          onTapDown: item.onTapDown,
          onDoubleTap: item.onDoubleTap,
          titleTextStyle: item.titleTextStyle,
          disabled: item.disabled,
          isSelected: item.isSelected,
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
      primary: widget.primary,
      restorationId: widget.restorationId,
      reverse: widget.reverse,
      scrollDirection: widget.scrollDirection,
      findChildIndexCallback: widget.findChildIndexCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuTheme =
        MechanixMenuTheme.of(context).merge(widget.theme, context);

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
            targetAnchor: Alignment.topLeft,
            followerAnchor: Alignment.topLeft,
            offset: widget.offset,
            child: _buildAnimatedMenuContent(
              child: Container(
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
  final VoidCallback handleClose;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: Container(
        height: theme.itemHeight,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.selectedBackgroundColor
              : disabled
                  ? theme.disabledBackgroundColor
                  : theme.itemBackgroundColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
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
                            ?.copyWith(color: context.onSurfaceVariant)
                        : theme.titleTextStyle
                            ?.copyWith(color: context.onSurface),
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
