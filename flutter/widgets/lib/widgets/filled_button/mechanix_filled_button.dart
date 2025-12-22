import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/filled_button/mechanix_filled_button_theme.dart';

class MechanixFilledButton extends StatelessWidget {
  const MechanixFilledButton({
    super.key,
    this.mouseCursor,
    this.backgroundBuilder,
    this.foregroundBuilder,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.buttonStyle,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.theme,
    required this.label,
  }) : labelText = null;

  const MechanixFilledButton.textWidget({
    super.key,
    this.mouseCursor,
    this.backgroundBuilder,
    this.foregroundBuilder,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.buttonStyle,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.theme,
    required this.labelText,
  }) : label = '';

  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final ButtonLayerBuilder? backgroundBuilder;
  final ButtonLayerBuilder? foregroundBuilder;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? buttonStyle;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;

  final String label;
  final Text? labelText;
  final MechanixFilledButtonThemeData? theme;

  @override
  Widget build(BuildContext context) {
    final buttonTheme =
        MechanixFilledButtonTheme.of(context).merge(theme, context);

    return FilledButton(
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        mouseCursor: mouseCursor,
        foregroundBuilder: foregroundBuilder,
        backgroundBuilder: backgroundBuilder ??
            (context, shape, fillColor) {
              return Container(
                height: buttonTheme.buttonSize?.height,
                width: buttonTheme.buttonSize?.width,
                decoration: buttonTheme.decoration,
                padding: buttonTheme.padding,
                margin: buttonTheme.margin,
                constraints: buttonTheme.constraints,
                child: Center(
                  child: labelText ??
                      Text(label,
                          style: buttonTheme.textStyle ??
                              context.textTheme.bodySmall),
                ),
              );
            },
      ),
      child: const Text(""),
    );
  }
}
