import 'package:flutter/material.dart';
import 'package:widgets/icons/mechanix_icon_images.dart';
import 'mechanix_search_bar_theme.dart';

class MechanixSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<Color?>? backgroundColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final TextEditingController controller;
  final bool autoFocus;
  final String hintText;
  final WidgetStateProperty<TextStyle?>? hintStyle;
  final Widget? leading;
  final List<Widget>? trailing;
  final bool showDefaultTrailing;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;

  final VoidCallback? onBackwardIconPress;
  final VoidCallback? onCloseIconPress;

  const MechanixSearchBar(
      {super.key,
      this.onChanged,
      this.side,
      this.backgroundColor,
      this.overlayColor,
      required this.controller,
      this.autoFocus = true,
      this.hintText = "Search...",
      this.hintStyle,
      this.leading,
      this.trailing,
      this.showDefaultTrailing = true,
      this.onBackwardIconPress,
      this.onCloseIconPress,
      this.onTap,
      this.onTapOutside});

  @override
  Widget build(BuildContext context) {
    final barTheme = MechanixSearchBarTheme.of(context);

    final resolvedBackgroundColor = backgroundColor ??
        barTheme.backgroundColor ??
        WidgetStateProperty.all(_MechanixSearchBarTheme.backgroundColor);

    final resolvedOverlayColor = overlayColor ??
        barTheme.overlayColor ??
        WidgetStateProperty.all(_MechanixSearchBarTheme.overlayColor);

    final resolvedSide = side ??
        barTheme.side ??
        WidgetStateProperty.all(
          BorderSide(color: _MechanixSearchBarTheme.borderColor),
        );

    final resolvedHintStyle =
        hintStyle ?? barTheme.hintStyle ?? _MechanixSearchBarTheme.hintStyle;

    return SearchBar(
      onTap: onTap,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      side: resolvedSide,
      backgroundColor: resolvedBackgroundColor,
      overlayColor: resolvedOverlayColor,
      controller: controller,
      autoFocus: autoFocus,
      hintText: hintText,
      hintStyle: resolvedHintStyle,
      leading: leading ?? _buildDefaultLeading(),
      trailing:
          trailing ?? (showDefaultTrailing ? _buildDefaultTrailing() : null),
    );
  }

  Widget _buildDefaultLeading() {
    return IconButton(
      iconSize: _MechanixSearchBarTheme.defaultIconSize,
      onPressed: null,
      icon: _MechanixIcon(
        asset: MechanixIconImages.searchIcon,
        size: _MechanixSearchBarTheme.searchIconSize,
      ),
    );
  }

  List<Widget> _buildDefaultTrailing() {
    return [
      SizedBox(
        width: _MechanixSearchBarTheme.trailingContainerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // _TrailingButton(
            //   onPressed: onBackwardIconPress,
            //   icon: MechanixIconImages.backwardIcon,
            //   backgroundColor: _MechanixSearchBarTheme.buttonBackgroundColor,
            //   showBorder: false,
            // ),
            // _buildVerticalDivider(),
            _TrailingButton(
              onPressed: onCloseIconPress,
              icon: MechanixIconImages.closeIcon,
              backgroundColor: Colors.transparent,
              showBorder: true,
            ),
          ],
        ),
      ),
    ];
  }

  // Widget _buildVerticalDivider() {
  //   return SizedBox(
  //     width: _MechanixSearchBarTheme.dividerWidth,
  //     height: _MechanixSearchBarTheme.dividerHeight,
  //     child: VerticalDivider(
  //       color: _MechanixSearchBarTheme.dividerColor,
  //       width: _MechanixSearchBarTheme.dividerWidth,
  //     ),
  //   );
  // }
}

class _MechanixIcon extends StatelessWidget {
  final String asset;
  final double size;

  const _MechanixIcon({
    required this.asset,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset(
        asset,
        package: 'widgets',
      ),
    );
  }
}

class _TrailingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String icon;
  final Color backgroundColor;
  final bool showBorder;

  const _TrailingButton({
    this.onPressed,
    required this.icon,
    required this.backgroundColor,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: _MechanixSearchBarTheme.buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder
            ? Border.all(color: _MechanixSearchBarTheme.borderColor)
            : null,
        borderRadius:
            BorderRadius.circular(_MechanixSearchBarTheme.buttonBorderRadius),
      ),
      padding: showBorder ? const EdgeInsets.symmetric(horizontal: 4) : null,
      child: IconButton(
        iconSize: _MechanixSearchBarTheme.trailingIconSize,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        icon: _MechanixIcon(
          asset: icon,
          size: _MechanixSearchBarTheme.trailingIconSize,
        ),
      ),
    );
  }
}

class _MechanixSearchBarTheme {
  // Colors
  static const Color backgroundColor = Color(0xFF363636);
  static const Color overlayColor = Colors.transparent;
  static const Color buttonBackgroundColor = Color(0xFF4D4D4D);
  static const Color borderColor = Color(0xFF4D4D4D);
  static const Color dividerColor = Color(0xFF4D4D4D);

  // Sizes
  static const double defaultIconSize = 24.0;
  static const double searchIconSize = 17.0;
  static const double trailingIconSize = 15.0;
  static const double buttonSize = 40.0;
  static const double buttonBorderRadius = 21.54;

  // Layout
  static const double trailingContainerWidth = 113.0;
  static const double dividerWidth = 1.0;
  static const double dividerHeight = 36.0;

  static WidgetStateProperty<TextStyle?> hintStyle = WidgetStateProperty.all(
    TextStyle(color: Color(0xFFA6A6A6)),
  );
}
