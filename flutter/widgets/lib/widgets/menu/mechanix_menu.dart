import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
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
  });

  final List<MechanixMenuItemsType> items;
  final IconButton? menuButton;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final DropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;

  @override
  State<MechanixMenu> createState() => _MechanixMenuState();
}

class _MechanixMenuState extends State<MechanixMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isClicked = false;

  void _showOptions(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => _MechanixMenuContainer(
        layerLink: _layerLink,
        onClose: _hideOptions,
        items: widget.items,
        animationType: widget.animationType,
        animationDuration: widget.animationDuration,
        dropdownPosition: widget.dropdownPosition,
        theme: widget.theme,
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
      child: (widget.menuButton != null)
          ? widget.menuButton
          : IconButton(
              onPressed: () {
                if (_overlayEntry == null) {
                  setState(() {
                    isClicked = true;
                  });
                  _showOptions(context);
                } else {
                  _hideOptions();
                }
              },
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

class _MechanixMenuContainer extends StatefulWidget {
  const _MechanixMenuContainer({
    required this.layerLink,
    required this.onClose,
    required this.items,
    required this.animationType,
    required this.animationDuration,
    required this.dropdownPosition,
    required this.theme,
  });

  final LayerLink layerLink;
  final VoidCallback onClose;
  final List<MechanixMenuItemsType> items;
  final MenuTransitions animationType;
  final Duration animationDuration;
  final DropdownPosition dropdownPosition;
  final MechanixMenuThemeData? theme;

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
      // Initialize slide animation with default values
      _slideAnimation = _getSlideAnimation();
    }

    // Start the animation when the widget is initialized
    _animationController.forward();
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

  Widget _buildAnimatedMenuContent(
      {required Widget child, required MechanixMenuThemeData theme}) {
    final slideChild = Material(
      elevation: theme.elevation ?? 4,
      color: theme.itemBackgroundColor,
      borderRadius: theme.borderRadius,
      child: ClipRRect(
        borderRadius: theme.borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );

    switch (widget.animationType) {
      case MenuTransitions.fade:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: slideChild,
        );
      case MenuTransitions.scale:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: slideChild,
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
          child: slideChild,
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
          child: slideChild,
        );
      case MenuTransitions.slideLeft:
      case MenuTransitions.slideRight:
      case MenuTransitions.slideDown:
      case MenuTransitions.slideUp:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: slideChild,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuTheme =
        MechanixMenuTheme.of(context).merge(widget.theme, context);

    final anchors = getDropDownPosition(widget.dropdownPosition);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleClose,
      child: Stack(
        children: [
          Positioned(
            child: CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              followerAnchor: anchors.followerAnchor,
              targetAnchor: anchors.targetAnchor,
              child: _buildAnimatedMenuContent(
                  child: Container(
                    width: menuTheme.width,
                    constraints: menuTheme.constraints ??
                        BoxConstraints(
                          maxHeight: menuTheme.maxHeight ?? 400,
                        ),
                    child: ListView.separated(
                      shrinkWrap: true,
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
                          onTap: () {
                            item.onTap?.call();
                            _handleClose();
                          },
                          onTapUp: item.onTapUp,
                          onTapDown: item.onTapDown,
                          onDoubleTap: item.onDoubleTap,
                          titleTextStyle: item.titleTextStyle,
                          disabled: item.disabled,
                          isSelected: item.isSelected,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: context.outline,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                  ),
                  theme: menuTheme),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
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

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: widget.theme.itemHeight,
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.theme.itemHoverColor
              : widget.theme.itemBackgroundColor,
          borderRadius: widget.theme.itemBorderRadius,
        ),
        child: InkWell(
          onTap: widget.disabled ? null : widget.onTap,
          borderRadius: widget.theme.itemBorderRadius,
          child: Padding(
            padding: widget.theme.itemPadding ?? EdgeInsets.all(0),
            child: Row(children: [
              if (widget.leading != null)
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: widget.leading,
                ),
              Expanded(
                child: Text(
                  widget.title,
                  style: widget.disabled
                      ? widget.theme.disabledTextStyle
                      : widget.theme.titleTextStyle,
                ),
              ),
              if (widget.trailing != null)
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: widget.trailing,
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
