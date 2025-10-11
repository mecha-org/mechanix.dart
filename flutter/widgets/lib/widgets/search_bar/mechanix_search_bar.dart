import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/icons/mechanix_icon_images.dart';
import 'package:widgets/widgets.dart';

import 'mechanix_search_bar_theme.dart';

class MechanixSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final bool autoFocus;
  final String hintText;
  final Widget? leading;
  final List<Widget>? trailing;
  final bool showDefaultTrailing;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MechanixSearchBarThemeData? theme;
  final double trailingHeight;
  final double trailingWidth;

  const MechanixSearchBar({
    super.key,
    required this.onChanged,
    this.autoFocus = true,
    this.hintText = "Search...",
    this.leading,
    this.trailing,
    this.showDefaultTrailing = true,
    this.onTap,
    this.onTapOutside,
    this.theme,
    this.trailingHeight = 40,
    this.trailingWidth = 50,
  });

  @override
  State<MechanixSearchBar> createState() => _MechanixSearchBarState();
}

class _MechanixSearchBarState extends State<MechanixSearchBar> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final barTheme =
        MechanixSearchBarTheme.of(context).merge(widget.theme, context);

    return SearchBar(
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onChanged: widget.onChanged,
      side: barTheme.borderSide,
      backgroundColor: barTheme.backgroundColor,
      overlayColor: barTheme.overlayColor,
      controller: textController,
      autoFocus: widget.autoFocus,
      hintText: widget.hintText,
      hintStyle: barTheme.hintStyle,
      leading: widget.leading ?? _buildDefaultLeading(barTheme),
      trailing: widget.trailing ??
          (widget.showDefaultTrailing ? _buildDefaultTrailing(barTheme) : null),
    );
  }

  Widget _buildDefaultLeading(MechanixSearchBarThemeData barTheme) {
    return IconButton(
      iconSize: barTheme.defaultLeadingIconSize,
      onPressed: null,
      icon: IconWidget.fromMechanix(
        iconPath: MechanixIconImages.searchIcon,
        iconWidth: barTheme.defaultLeadingIconSize ?? 17,
        iconHeight: barTheme.defaultLeadingIconSize ?? 17,
      ),
    );
  }

  onCloseIconPress() {
    widget.onChanged('');
    textController.clear();
  }

  List<Widget> _buildDefaultTrailing(MechanixSearchBarThemeData barTheme) {
    return [
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _TrailingButton(
              barTheme: barTheme,
              onPressed: onCloseIconPress,
              backgroundColor: Colors.transparent,
              trailingHeight: widget.trailingHeight,
              trailingWidth: widget.trailingWidth,
            ),
          ],
        ),
      ),
    ];
  }
}

class _TrailingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final MechanixSearchBarThemeData barTheme;
  final double trailingHeight;
  final double trailingWidth;

  const _TrailingButton({
    this.onPressed,
    required this.backgroundColor,
    required this.barTheme,
    required this.trailingHeight,
    required this.trailingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: trailingWidth,
      height: trailingHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border:
            Border.all(color: barTheme.borderColor ?? const Color(0xFF4D4D4D)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        iconSize: barTheme.defaultTrailingIconSize ?? 15.0,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        icon: IconWidget.fromMechanix(
          iconPath: MechanixIconImages.closeIcon,
          iconWidth: barTheme.defaultTrailingIconSize ?? 15,
          iconHeight: barTheme.defaultTrailingIconSize ?? 15,
        ),
      ),
    );
  }
}
