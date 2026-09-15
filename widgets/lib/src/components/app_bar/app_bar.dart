import 'package:flutter/material.dart';

import 'app_bar_enums.dart';
import 'app_bar_theme.dart';

export 'app_bar_enums.dart';
export 'app_bar_theme.dart';

/// A Material 3 Top App Bar component styled according to Mechanix design specifications.
///
/// Built on top of Flutter's standard [AppBar] widget and conforms to Material 3 specifications:
/// - [MechanixAppBar.small]: Standard single-row app bar (height 64 dp).
///   Uses [TextTheme.headlineSmall] for the title.
/// - [MechanixAppBar.medium]: Two-row flexible app bar (height 112 dp).
///   Features a prominent title below navigation/action icons using [TextTheme.headlineMedium].
/// - [MechanixAppBar.large]: Large two-row flexible app bar (height 120 dp).
///   Features an extra-large display title below navigation/action icons using [TextTheme.displayMedium].
/// - [MechanixAppBar.search]: Single-row app bar with an embedded search container
///   and trailing action/avatar (height 64 dp).
class MechanixAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [MechanixAppBar] with the given [variant].
  const MechanixAppBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.supportingText,
    this.subtitle,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleTextStyle,
    this.supportingTextStyle,
    this.variant = AppBarVariant.small,
    this.actionsPadding,
    this.searchWidget,
    this.searchHint,
    this.searchController,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSearchTap,
    this.searchLeading,
    this.searchTrailing,
    this.searchFocusNode,
    this.searchReadOnly = false,
    this.searchAutofocus = false,
    this.searchBackgroundColor,
    this.searchBorderRadius,
    this.searchHintTextStyle,
  });

  /// Creates a small single-row [MechanixAppBar] (height 64 dp).
  ///
  /// Uses [TextTheme.headlineSmall] for the title.
  const MechanixAppBar.small({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleTextStyle,
    this.actionsPadding,
  }) : variant = AppBarVariant.small,
       supportingText = null,
       subtitle = null,
       supportingTextStyle = null,
       searchWidget = null,
       searchHint = null,
       searchController = null,
       onSearchChanged = null,
       onSearchSubmitted = null,
       onSearchTap = null,
       searchLeading = null,
       searchTrailing = null,
       searchFocusNode = null,
       searchReadOnly = false,
       searchAutofocus = false,
       searchBackgroundColor = null,
       searchBorderRadius = null,
       searchHintTextStyle = null;

  /// Creates a medium two-row flexible [MechanixAppBar] (height 112 dp).
  ///
  /// Features a prominent title below navigation/action icons
  /// using [TextTheme.headlineMedium].
  const MechanixAppBar.medium({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle = false,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleTextStyle,
    this.actionsPadding,
  }) : variant = AppBarVariant.medium,
       supportingText = null,
       subtitle = null,
       supportingTextStyle = null,
       searchWidget = null,
       searchHint = null,
       searchController = null,
       onSearchChanged = null,
       onSearchSubmitted = null,
       onSearchTap = null,
       searchLeading = null,
       searchTrailing = null,
       searchFocusNode = null,
       searchReadOnly = false,
       searchAutofocus = false,
       searchBackgroundColor = null,
       searchBorderRadius = null,
       searchHintTextStyle = null;

  /// Creates a large two-row flexible [MechanixAppBar].
  ///
  /// Height is 120 dp by default (title only), or 152 dp when [supportingText]
  /// or [subtitle] is provided.
  ///
  /// Features an extra-large display title below navigation/action icons
  /// using [TextTheme.displayMedium].
  const MechanixAppBar.large({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.supportingText,
    this.subtitle,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle = false,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleTextStyle,
    this.supportingTextStyle,
    this.actionsPadding,
  }) : variant = AppBarVariant.large,
       searchWidget = null,
       searchHint = null,
       searchController = null,
       onSearchChanged = null,
       onSearchSubmitted = null,
       onSearchTap = null,
       searchLeading = null,
       searchTrailing = null,
       searchFocusNode = null,
       searchReadOnly = false,
       searchAutofocus = false,
       searchBackgroundColor = null,
       searchBorderRadius = null,
       searchHintTextStyle = null;

  /// Creates a single-row [MechanixAppBar] containing an embedded search bar (height 64 dp).
  const MechanixAppBar.search({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.toolbarHeight,
    this.leadingWidth,
    this.actionsPadding,
    this.searchWidget,
    this.searchHint,
    this.searchController,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSearchTap,
    this.searchLeading,
    this.searchTrailing,
    this.searchFocusNode,
    this.searchReadOnly = false,
    this.searchAutofocus = false,
    this.searchBackgroundColor,
    this.searchBorderRadius,
    this.searchHintTextStyle,
  }) : variant = AppBarVariant.search,
       title = null,
       supportingText = null,
       subtitle = null,
       supportingTextStyle = null,
       centerTitle = false,
       titleSpacing = null,
       titleTextStyle = null;

  /// A widget to display before the toolbar's [title].
  final Widget? leading;

  /// Whether to imply the leading widget if [leading] is null.
  final bool automaticallyImplyLeading;

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// Secondary text or widget displayed beneath the [title] in large variants.
  final Widget? supportingText;

  /// An alias for [supportingText].
  final Widget? subtitle;

  /// Text style applied to [supportingText] in large variants.
  final TextStyle? supportingTextStyle;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// This widget appears across the bottom of the app bar.
  final PreferredSizeWidget? bottom;

  /// The z-coordinate at which to place this app bar.
  final double? elevation;

  /// The elevation used when scrolled under content.
  final double? scrolledUnderElevation;

  /// The color of the shadow below the app bar.
  final Color? shadowColor;

  /// The surface tint overlay color.
  final Color? surfaceTintColor;

  /// The fill color of the app bar.
  final Color? backgroundColor;

  /// The default color for text and icons within the app bar.
  final Color? foregroundColor;

  /// The theme to use for icons in the app bar.
  final IconThemeData? iconTheme;

  /// The theme to use for action icons in the app bar.
  final IconThemeData? actionsIconTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  final bool primary;

  /// Whether the title should be centered.
  final bool? centerTitle;

  /// The spacing around the title widget on the horizontal axis.
  final double? titleSpacing;

  /// Defines the height of the toolbar component.
  final double? toolbarHeight;

  /// Defines the width of the [leading] widget.
  final double? leadingWidth;

  /// The default text style for the [title] widget.
  final TextStyle? titleTextStyle;

  /// The visual layout variant of this app bar.
  final AppBarVariant variant;

  /// The padding around the [actions] widget list.
  final EdgeInsetsGeometry? actionsPadding;

  /// A custom search widget replacing the built-in search box in [AppBarVariant.search].
  final Widget? searchWidget;

  /// Placeholder hint text for the built-in search input in [AppBarVariant.search].
  final String? searchHint;

  /// Controller for the built-in search input in [AppBarVariant.search].
  final TextEditingController? searchController;

  /// Called when the search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Called when the user indicates that they are done editing the search text.
  final ValueChanged<String>? onSearchSubmitted;

  /// Called when the search container is tapped.
  final VoidCallback? onSearchTap;

  /// Widget placed at the start of the built-in search bar (defaults to search icon).
  final Widget? searchLeading;

  /// Widget placed at the end of the built-in search bar.
  final Widget? searchTrailing;

  /// Focus node for the built-in search input.
  final FocusNode? searchFocusNode;

  /// Whether the built-in search input is read-only.
  final bool searchReadOnly;

  /// Whether the built-in search input should focus automatically.
  final bool searchAutofocus;

  /// Background color of the built-in search bar container.
  final Color? searchBackgroundColor;

  /// Corner radius of the built-in search bar container.
  final BorderRadius? searchBorderRadius;

  /// Text style for the hint text in the search bar.
  final TextStyle? searchHintTextStyle;

  @override
  Size get preferredSize {
    final double baseHeight;
    switch (variant) {
      case AppBarVariant.small:
        baseHeight = toolbarHeight ?? 64.0;
      case AppBarVariant.medium:
        baseHeight = toolbarHeight ?? 112.0;
      case AppBarVariant.large:
        baseHeight = toolbarHeight ?? 120.0;
      case AppBarVariant.search:
        baseHeight = toolbarHeight ?? 64.0;
    }
    return Size.fromHeight(baseHeight + (bottom?.preferredSize.height ?? 0.0));
  }

  Widget _buildDefaultSearchBar(
    BuildContext context,
    AppBarThemeDataConfig config,
    ColorScheme colorScheme,
    TextTheme textTheme,
    Color effectiveFg,
  ) {
    final bg =
        searchBackgroundColor ??
        config.searchBackgroundColor ??
        colorScheme.surfaceContainerHigh;

    final hintStyle =
        searchHintTextStyle ??
        config.searchHintTextStyle ??
        textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant);

    return Container(
      height: 44.0,
      decoration: BoxDecoration(color: bg),
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchLeading ??
              Icon(
                Icons.search,
                size: 20.0,
                color: effectiveFg.withValues(alpha: 0.70),
              ),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              readOnly: searchReadOnly,
              autofocus: searchAutofocus,
              onTap: onSearchTap,
              onChanged: onSearchChanged,
              onSubmitted: onSearchSubmitted,
              style: textTheme.bodyLarge?.copyWith(color: effectiveFg),
              cursorColor: colorScheme.primary,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: searchHint ?? 'Search product',
                hintStyle: hintStyle,
              ),
            ),
          ),
          if (searchTrailing != null) ...[searchTrailing!],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = MechanixAppBarTheme.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final effectiveBg =
        backgroundColor ?? config.backgroundColor ?? colorScheme.surface;
    final effectiveFg =
        foregroundColor ?? config.foregroundColor ?? colorScheme.onSurface;
    final effectiveElevation = elevation ?? config.elevation ?? 0.0;
    final effectiveScrolledUnderElevation =
        scrolledUnderElevation ?? config.scrolledUnderElevation ?? 3.0;
    final effectiveShadowColor =
        shadowColor ?? config.shadowColor ?? colorScheme.shadow;
    final effectiveSurfaceTintColor =
        surfaceTintColor ?? config.surfaceTintColor ?? Colors.transparent;
    final effectiveCenterTitle = centerTitle ?? config.centerTitle ?? false;
    final effectiveTitleSpacing = titleSpacing ?? config.titleSpacing ?? 16.0;
    final effectiveToolbarHeight =
        toolbarHeight ?? config.toolbarHeight ?? 64.0;
    final effectiveActionsPadding = actionsPadding ?? config.actionsPadding;

    final effectiveIconTheme =
        iconTheme ??
        config.iconTheme ??
        IconThemeData(color: effectiveFg, size: 24.0);
    final effectiveActionsIconTheme =
        actionsIconTheme ??
        config.actionsIconTheme ??
        IconThemeData(color: effectiveFg, size: 24.0);

    final double topPadding = primary ? MediaQuery.paddingOf(context).top : 0.0;
    final double targetHeight = preferredSize.height + topPadding;

    final Widget appBarWidget;

    switch (variant) {
      case AppBarVariant.small:
        final effectiveTitleStyle =
            titleTextStyle ??
            config.smallTitleTextStyle ??
            textTheme.headlineSmall?.copyWith(color: effectiveFg);

        appBarWidget = AppBar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          actionsPadding: effectiveActionsPadding,
          bottom: bottom,
          elevation: effectiveElevation,
          scrolledUnderElevation: effectiveScrolledUnderElevation,
          shadowColor: effectiveShadowColor,
          surfaceTintColor: effectiveSurfaceTintColor,
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          iconTheme: effectiveIconTheme,
          actionsIconTheme: effectiveActionsIconTheme,
          primary: primary,
          centerTitle: effectiveCenterTitle,
          titleSpacing: effectiveTitleSpacing,
          toolbarHeight: effectiveToolbarHeight,
          leadingWidth: leadingWidth,
          titleTextStyle: effectiveTitleStyle,
        );

      case AppBarVariant.medium:
        final effectiveTitleStyle =
            titleTextStyle ??
            config.mediumTitleTextStyle ??
            textTheme.headlineMedium!.copyWith(color: effectiveFg);

        final totalHeight = toolbarHeight ?? 112.0;
        final mediumTitleHeight = totalHeight - 56.0;

        final titleWidget = Container(
          height: mediumTitleHeight,
          padding: EdgeInsetsDirectional.only(
            start: effectiveTitleSpacing,
            end: 16.0,
            bottom: 12.0,
          ),
          alignment: effectiveCenterTitle
              ? Alignment.bottomCenter
              : AlignmentDirectional.bottomStart,
          child: DefaultTextStyle(
            style: effectiveTitleStyle,
            textAlign: effectiveCenterTitle
                ? TextAlign.center
                : TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Semantics(
              header: true,
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        );

        final PreferredSizeWidget effectiveBottom;
        if (bottom != null) {
          effectiveBottom = PreferredSize(
            preferredSize: Size.fromHeight(
              mediumTitleHeight + bottom!.preferredSize.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [titleWidget, bottom!],
            ),
          );
        } else {
          effectiveBottom = PreferredSize(
            preferredSize: Size.fromHeight(mediumTitleHeight),
            child: titleWidget,
          );
        }

        appBarWidget = AppBar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: null,
          actions: actions,
          actionsPadding: effectiveActionsPadding,
          bottom: effectiveBottom,
          elevation: effectiveElevation,
          scrolledUnderElevation: effectiveScrolledUnderElevation,
          shadowColor: effectiveShadowColor,
          surfaceTintColor: effectiveSurfaceTintColor,
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          iconTheme: effectiveIconTheme,
          actionsIconTheme: effectiveActionsIconTheme,
          primary: primary,
          centerTitle: effectiveCenterTitle,
          titleSpacing: effectiveTitleSpacing,
          toolbarHeight: 64.0,
          leadingWidth: leadingWidth,
        );

      case AppBarVariant.large:
        final effectiveTitleStyle =
            titleTextStyle ??
            config.largeTitleTextStyle ??
            textTheme.displayMedium!.copyWith(color: effectiveFg);

        final totalHeight = toolbarHeight ?? 120.0;
        final largeTitleHeight = totalHeight - 56.0;
        final titleWidget = Container(
          height: largeTitleHeight,
          padding: EdgeInsetsDirectional.only(
            start: effectiveTitleSpacing,
            end: 16.0,
            bottom: 12.0,
          ),
          alignment: effectiveCenterTitle
              ? Alignment.bottomCenter
              : AlignmentDirectional.bottomStart,
          child: DefaultTextStyle(
            style: effectiveTitleStyle,
            textAlign: effectiveCenterTitle
                ? TextAlign.center
                : TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            child: Semantics(
              header: true,
              child: title ?? const SizedBox.shrink(),
            ),
          ),
        );

        final PreferredSizeWidget effectiveBottom;
        if (bottom != null) {
          effectiveBottom = PreferredSize(
            preferredSize: Size.fromHeight(
              largeTitleHeight + bottom!.preferredSize.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [titleWidget, bottom!],
            ),
          );
        } else {
          effectiveBottom = PreferredSize(
            preferredSize: Size.fromHeight(largeTitleHeight),
            child: titleWidget,
          );
        }

        appBarWidget = AppBar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: null,
          actions: actions,
          actionsPadding: effectiveActionsPadding,
          bottom: effectiveBottom,
          elevation: effectiveElevation,
          scrolledUnderElevation: effectiveScrolledUnderElevation,
          shadowColor: effectiveShadowColor,
          surfaceTintColor: effectiveSurfaceTintColor,
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          iconTheme: effectiveIconTheme,
          actionsIconTheme: effectiveActionsIconTheme,
          primary: primary,
          centerTitle: effectiveCenterTitle,
          titleSpacing: effectiveTitleSpacing,
          toolbarHeight: 64.0,
          leadingWidth: leadingWidth,
        );

      case AppBarVariant.search:
        appBarWidget = AppBar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title:
              searchWidget ??
              _buildDefaultSearchBar(
                context,
                config,
                colorScheme,
                textTheme,
                effectiveFg,
              ),
          titleSpacing: effectiveTitleSpacing,
          actions: actions,
          actionsPadding: effectiveActionsPadding,
          bottom: bottom,
          elevation: effectiveElevation,
          scrolledUnderElevation: effectiveScrolledUnderElevation,
          shadowColor: effectiveShadowColor,
          surfaceTintColor: effectiveSurfaceTintColor,
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          iconTheme: effectiveIconTheme,
          actionsIconTheme: effectiveActionsIconTheme,
          primary: primary,
          centerTitle: false,
          toolbarHeight: effectiveToolbarHeight,
          leadingWidth: leadingWidth,
        );
    }

    return SizedBox(height: targetHeight, child: appBarWidget);
  }
}
