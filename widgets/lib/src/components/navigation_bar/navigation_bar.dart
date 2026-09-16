import 'package:flutter/material.dart';

import 'navigation_bar_theme.dart';

export 'navigation_bar_theme.dart';

/// Represents a single destination item within a [MechanixNavigationBar].
///
/// Stores destination data including [icon], [selectedIcon], [label],
/// [enabled], and an optional [badge].
///
/// Designed to be used in [MechanixNavigationBar.destinations].
class MechanixNavigationDestination extends StatelessWidget {
  /// Creates a destination item for [MechanixNavigationBar].
  const MechanixNavigationDestination({
    super.key,
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.enabled = true,
    this.badge,
  });

  /// The icon of the destination.
  ///
  /// Shown when the destination is unselected, or when selected if [selectedIcon]
  /// is not provided.
  final Widget icon;

  /// An alternative icon displayed when this destination is selected.
  ///
  /// If null, [icon] will be displayed in both selected and unselected states.
  final Widget? selectedIcon;

  /// The text label displayed beneath the destination icon.
  final String label;

  /// Whether the destination can be tapped or focused.
  ///
  /// Defaults to `true`.
  final bool enabled;

  /// An optional badge widget overlaid on the top-right corner of the destination icon.
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    // When rendered directly outside MechanixNavigationBar, provide a simple fallback layout.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        badge != null ? Badge(label: badge, child: icon) : icon,
        const SizedBox(height: 4.0),
        Text(label),
      ],
    );
  }
}

/// A Material 3 Navigation Bar component styled with Mechanix design tokens.
///
/// Features:
/// - Exact default height of 80 dp (hug height)
/// - 4 dp destination gap between adjacent navigation destination items
/// - Hover, focus, pressed, and selected background colors and 1px top border
///   applied to the **whole navigation item** containing both icon and label
///   - Selected: `onSurface` with 10% opacity (`rgba(245, 245, 245, 0.1)`)
///   - Selected Top Border: 1px solid `onSecondaryFixed` (`rgba(141, 141, 145, 1)`)
///   - Hovered: `onSurface` with 8% opacity (`rgba(245, 245, 245, 0.08)`)
///   - Focused / Pressed: `surfaceContainerLow` (`rgba(20, 20, 21, 1)`)
/// - 24 dp icon size with state-aware colors:
///   - Selected: `onSurface`
///   - Unselected: `onSurfaceVariant`
/// - 4 dp vertical gap between item icon and label
/// - `labelLarge` typography with `onSecondaryContainer` color
/// - Full keyboard navigation, hover tracking, and accessibility semantics
/// - Seamless compatibility with standard Flutter [NavigationDestination]
///
/// ### Example Usage:
/// ```dart
/// MechanixNavigationBar(
///   selectedIndex: _currentIndex,
///   destinationGap: 4.0,
///   onDestinationSelected: (index) => setState(() => _currentIndex = index),
///   destinations: const [
///     MechanixNavigationDestination(
///       icon: Icon(Icons.home_outlined),
///       selectedIcon: Icon(Icons.home),
///       label: 'Home',
///     ),
///     MechanixNavigationDestination(
///       icon: Icon(Icons.search_outlined),
///       selectedIcon: Icon(Icons.search),
///       label: 'Search',
///     ),
///     MechanixNavigationDestination(
///       icon: Icon(Icons.settings_outlined),
///       selectedIcon: Icon(Icons.settings),
///       label: 'Settings',
///     ),
///   ],
/// )
/// ```
class MechanixNavigationBar extends StatefulWidget {
  /// Creates a [MechanixNavigationBar].
  const MechanixNavigationBar({
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.selectedIndex = 0,
    required this.destinations,
    this.onDestinationSelected,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.height,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
    this.destinationGap,
    this.padding,
    this.theme,
  }) : assert(
         destinations.length >= 2,
         'destinations must have at least 2 items',
       );

  /// Determines the transition duration between states.
  ///
  /// Defaults to 200 milliseconds.
  final Duration animationDuration;

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// The list of destination widgets.
  ///
  /// Supports [MechanixNavigationDestination] or standard Flutter [NavigationDestination].
  final List<Widget> destinations;

  /// Callback called when a destination is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The background color of the navigation bar.
  ///
  /// If null, defaults to [NavigationBarThemeDataConfig.backgroundColor] or [ColorScheme.surfaceContainerLow].
  final Color? backgroundColor;

  /// The elevation of the navigation bar.
  ///
  /// If null, defaults to [NavigationBarThemeDataConfig.elevation] or `0.0`.
  final double? elevation;

  /// The shadow color of the navigation bar when elevated.
  final Color? shadowColor;

  /// The surface tint color applied on top of the background color.
  final Color? surfaceTintColor;

  /// The total height of the navigation bar.
  ///
  /// Defaults to [NavigationBarThemeDataConfig.height] (80.0 dp).
  final double? height;

  /// Defines how destination labels are displayed.
  ///
  /// Defaults to [NavigationDestinationLabelBehavior.alwaysShow].
  final NavigationDestinationLabelBehavior labelBehavior;

  /// Horizontal gap between adjacent navigation destinations.
  ///
  /// Defaults to [NavigationBarThemeDataConfig.destinationGap] (4.0 dp).
  final double? destinationGap;

  /// Optional padding around the navigation destinations row.
  final EdgeInsetsGeometry? padding;

  /// Optional per-instance [NavigationBarThemeDataConfig] override.
  final NavigationBarThemeDataConfig? theme;

  @override
  State<MechanixNavigationBar> createState() => _MechanixNavigationBarState();
}

class _MechanixNavigationBarState extends State<MechanixNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final inheritedConfig = MechanixNavigationBarTheme.of(context);
    final effectiveConfig = inheritedConfig.merge(widget.theme);

    final double effectiveHeight =
        widget.height ?? effectiveConfig.height ?? 80.0;
    final Color effectiveBackgroundColor =
        widget.backgroundColor ??
        effectiveConfig.backgroundColor ??
        themeData.colorScheme.surfaceContainerLow;
    final double effectiveElevation =
        widget.elevation ?? effectiveConfig.elevation ?? 0.0;
    final Color effectiveShadowColor =
        widget.shadowColor ??
        effectiveConfig.shadowColor ??
        themeData.colorScheme.shadow;
    final Color effectiveSurfaceTintColor =
        widget.surfaceTintColor ??
        effectiveConfig.surfaceTintColor ??
        Colors.transparent;

    final double destinationGap =
        widget.destinationGap ?? effectiveConfig.destinationGap ?? 4.0;
    final bool showDividers = effectiveConfig.showDividers ?? true;
    final Color dividerColor =
        effectiveConfig.dividerColor ??
        themeData.colorScheme.outlineVariant.withValues(alpha: 0.2);

    Widget destinationsRow = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < widget.destinations.length; i++) ...[
          if (i > 0)
            if (destinationGap > 0)
              SizedBox(width: destinationGap)
            else if (showDividers)
              Container(
                width: 1.0,
                height: effectiveHeight,
                color: dividerColor,
              ),
          Expanded(
            child: _MechanixNavigationDestinationCell(
              key: ValueKey('destination_$i'),
              index: i,
              isSelected: widget.selectedIndex == i,
              destination: widget.destinations[i],
              config: effectiveConfig,
              labelBehavior: widget.labelBehavior,
              animationDuration: widget.animationDuration,
              effectiveHeight: effectiveHeight,
              onTap: _isDestinationEnabled(widget.destinations[i])
                  ? () => widget.onDestinationSelected?.call(i)
                  : null,
            ),
          ),
        ],
      ],
    );

    if (widget.padding != null) {
      destinationsRow = Padding(
        padding: widget.padding!,
        child: destinationsRow,
      );
    }

    return Material(
      color: effectiveBackgroundColor,
      elevation: effectiveElevation,
      shadowColor: effectiveShadowColor,
      surfaceTintColor: effectiveSurfaceTintColor,
      child: SafeArea(
        top: false,
        child: SizedBox(height: effectiveHeight, child: destinationsRow),
      ),
    );
  }

  bool _isDestinationEnabled(Widget destination) {
    if (destination is MechanixNavigationDestination) {
      return destination.enabled;
    }
    if (destination is NavigationDestination) {
      return destination.enabled;
    }
    return true;
  }
}

/// Destination data extractor and cell renderer.
class _MechanixNavigationDestinationCell extends StatefulWidget {
  const _MechanixNavigationDestinationCell({
    super.key,
    required this.index,
    required this.isSelected,
    required this.destination,
    required this.config,
    required this.labelBehavior,
    required this.animationDuration,
    required this.effectiveHeight,
    required this.onTap,
  });

  final int index;
  final bool isSelected;
  final Widget destination;
  final NavigationBarThemeDataConfig config;
  final NavigationDestinationLabelBehavior labelBehavior;
  final Duration animationDuration;
  final double effectiveHeight;
  final VoidCallback? onTap;

  @override
  State<_MechanixNavigationDestinationCell> createState() =>
      _MechanixNavigationDestinationCellState();
}

class _MechanixNavigationDestinationCellState
    extends State<_MechanixNavigationDestinationCell> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  bool get _isEnabled => widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;
    final info = _DestinationInfo.fromWidget(destination);

    final showLabel = switch (widget.labelBehavior) {
      NavigationDestinationLabelBehavior.alwaysShow => true,
      NavigationDestinationLabelBehavior.alwaysHide => false,
      NavigationDestinationLabelBehavior.onlyShowSelected => widget.isSelected,
    };

    final Color itemBgColor = _resolveItemBackgroundColor();
    final Color topBorderColor = _resolveTopBorderColor();
    final Color iconColor = _resolveIconColor();

    final TextStyle effectiveLabelStyle =
        (widget.config.labelTextStyle ??
                Theme.of(context).textTheme.labelLarge ??
                const TextStyle(fontSize: 14.0))
            .copyWith(
              color: _isEnabled
                  ? (widget.config.labelColor ??
                        Theme.of(context).colorScheme.onSecondaryContainer)
                  : (widget.config.labelColor ??
                            Theme.of(context).colorScheme.onSecondaryContainer)
                        .withValues(alpha: 0.38),
            );

    final Widget effectiveIcon = widget.isSelected
        ? (info.selectedIcon ?? info.icon)
        : info.icon;

    Widget iconContent = IconTheme(
      data: IconThemeData(
        size: widget.config.iconSize ?? 24.0,
        color: iconColor,
      ),
      child: effectiveIcon,
    );

    if (info.badge != null) {
      iconContent = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          iconContent,
          Positioned(top: -4.0, right: -8.0, child: info.badge!),
        ],
      );
    }

    final double borderWidth = widget.config.selectedBorderWidth ?? 1.0;
    final double gap = widget.config.itemGap ?? 4.0;
    final bool applyToWholeItem = widget.config.applyToWholeItem ?? true;

    Widget cellContent;

    if (applyToWholeItem) {
      // Whole Nav Item has hover, focus, pressed, and selected background
      // and 1px top border across the entire cell.
      cellContent = AnimatedContainer(
        duration: widget.animationDuration,
        height: widget.effectiveHeight,
        decoration: BoxDecoration(
          color: itemBgColor,
          borderRadius: widget.config.itemBorderRadius,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1px top border line
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                height: borderWidth,
                decoration: BoxDecoration(
                  color: topBorderColor,
                  borderRadius: widget.config.itemBorderRadius != null
                      ? BorderRadius.only(
                          topLeft: widget.config.itemBorderRadius!.topLeft,
                          topRight: widget.config.itemBorderRadius!.topRight,
                        )
                      : null,
                ),
              ),
            ),
            // Centered content (icon + gap + label)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.config.verticalPadding ?? 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconContent,
                  if (showLabel) ...[
                    SizedBox(height: gap),
                    AnimatedDefaultTextStyle(
                      duration: widget.animationDuration,
                      style: effectiveLabelStyle,
                      child: Text(
                        info.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Pill indicator style
      final double itemWidth = widget.config.itemWidth ?? 56.0;
      final double itemHeight = widget.config.itemHeight ?? 32.0;

      final containerWidget = AnimatedContainer(
        duration: widget.animationDuration,
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: itemBgColor,
          borderRadius: widget.config.itemBorderRadius,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                height: borderWidth,
                decoration: BoxDecoration(
                  color: topBorderColor,
                  borderRadius: widget.config.itemBorderRadius != null
                      ? BorderRadius.only(
                          topLeft: widget.config.itemBorderRadius!.topLeft,
                          topRight: widget.config.itemBorderRadius!.topRight,
                        )
                      : null,
                ),
              ),
            ),
            iconContent,
          ],
        ),
      );

      cellContent = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          containerWidget,
          if (showLabel) ...[
            SizedBox(height: gap),
            AnimatedDefaultTextStyle(
              duration: widget.animationDuration,
              style: effectiveLabelStyle,
              child: Text(
                info.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      );
    }

    Widget interactiveCell = MouseRegion(
      cursor: _isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        if (mounted) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (mounted) {
          setState(() => _isHovered = false);
        }
      },
      child: FocusableActionDetector(
        enabled: _isEnabled,
        onShowFocusHighlight: (hasHighlight) {
          if (mounted) {
            setState(() => _isFocused = hasHighlight);
          }
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap?.call();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _isEnabled
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: _isEnabled
              ? (_) => setState(() => _isPressed = false)
              : null,
          onTapCancel: _isEnabled
              ? () => setState(() => _isPressed = false)
              : null,
          onTap: widget.onTap,
          child: cellContent,
        ),
      ),
    );

    if (info.tooltip != null && info.tooltip!.isNotEmpty) {
      interactiveCell = Tooltip(message: info.tooltip!, child: interactiveCell);
    }

    return Semantics(
      container: true,
      selected: widget.isSelected,
      enabled: _isEnabled,
      label: info.label,
      button: true,
      child: interactiveCell,
    );
  }

  Color _resolveItemBackgroundColor() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!_isEnabled) {
      return Colors.transparent;
    }

    // Base destination background.
    Color background =
        widget.config.itemBackgroundColor ?? colorScheme.surfaceContainerLow;

    // Selected state layer.
    if (widget.isSelected) {
      final selectedLayer =
          widget.config.selectedBackgroundColor ??
          colorScheme.onSurface.withValues(alpha: 0.10);

      background = Color.alphaBlend(selectedLayer, background);
    }

    // Hover state layer.
    if (_isHovered) {
      final hoverLayer =
          widget.config.hoveredBackgroundColor ??
          colorScheme.onSurface.withValues(alpha: 0.08);

      background = Color.alphaBlend(hoverLayer, background);
    }

    // Focused / pressed states are specified as actual background colors
    // in the current Mechanix navigation bar design.
    if (_isFocused) {
      return widget.config.focusedBackgroundColor ??
          colorScheme.surfaceContainerLow;
    }

    if (_isPressed) {
      return widget.config.pressedBackgroundColor ??
          colorScheme.surfaceContainerLow;
    }

    return background;
  }

  Color _resolveTopBorderColor() {
    if (!_isEnabled) {
      return Colors.transparent;
    }
    if (widget.isSelected) {
      return widget.config.selectedBorderColor ??
          Theme.of(context).colorScheme.onSecondaryFixed;
    }
    return Colors.transparent;
  }

  Color _resolveIconColor() {
    final theme = Theme.of(context);
    if (!_isEnabled) {
      return (widget.isSelected
              ? (widget.config.selectedItemColor ?? theme.colorScheme.onSurface)
              : (widget.config.unselectedItemColor ??
                    theme.colorScheme.onSurfaceVariant))
          .withValues(alpha: 0.38);
    }
    if (widget.isSelected) {
      return widget.config.selectedItemColor ?? theme.colorScheme.onSurface;
    }
    return widget.config.unselectedItemColor ??
        theme.colorScheme.onSurfaceVariant;
  }
}

/// Normalizes data from [MechanixNavigationDestination] and Flutter's [NavigationDestination].
class _DestinationInfo {
  const _DestinationInfo({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.tooltip,
    this.badge,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
  final String? tooltip;
  final Widget? badge;

  factory _DestinationInfo.fromWidget(Widget widget) {
    if (widget is MechanixNavigationDestination) {
      return _DestinationInfo(
        icon: widget.icon,
        selectedIcon: widget.selectedIcon,
        label: widget.label,
        badge: widget.badge,
      );
    }
    if (widget is NavigationDestination) {
      return _DestinationInfo(
        icon: widget.icon,
        selectedIcon: widget.selectedIcon,
        label: widget.label,
        tooltip: widget.tooltip ?? widget.label,
      );
    }
    return _DestinationInfo(icon: widget, label: '');
  }
}
