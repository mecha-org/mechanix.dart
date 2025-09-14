import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/textInput/mechanix_text_input_theme.dart';

class MechanixTextInput<T> extends StatefulWidget {
  const MechanixTextInput.textInput(
      {super.key,
      this.isPasswordField = false,
      this.onChanged,
      this.hintText,
      this.isFormField = false,
      this.inputDecoration,
      this.validator,
      this.onFieldSubmitted,
      this.label,
      this.theme,
      this.initialValue});

  const MechanixTextInput.password(
      {super.key,
      this.isPasswordField = true,
      this.onChanged,
      this.hintText,
      this.isFormField = false,
      this.inputDecoration,
      this.label,
      this.onFieldSubmitted,
      this.validator,
      this.theme,
      this.initialValue});

  final String? label;
  final bool isPasswordField;
  final bool isFormField;
  final ValueChanged<String>? onChanged;
  final InputDecoration? inputDecoration;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final MechanixTextInputThemeData? theme;
  final String? initialValue;

  @override
  State<MechanixTextInput> createState() => _MechanixTextInputState();
}

class _MechanixTextInputState extends State<MechanixTextInput> {
  bool obscureText = true;
  late TextEditingController _controller;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTextInputTheme.of(context).merge(widget.theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label ?? '',
            style: theme.labelTextStyle ??
                context.textTheme.labelMedium
                    ?.copyWith(color: const Color(0xFF898A8D)),
          ).padBottom(8),
        if (widget.isFormField)
          TextFormField(
            controller: _controller,
            obscureText: widget.isPasswordField ? obscureText : false,
            style: theme.textStyle,
            decoration: _buildInputDecoration(context, theme),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
          )
        else
          TextField(
            controller: _controller,
            obscureText: widget.isPasswordField ? obscureText : false,
            style: theme.textStyle,
            decoration: _buildInputDecoration(context, theme),
            onChanged: widget.onChanged,
          ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, MechanixTextInputThemeData theme) {
    final baseDecoration = InputDecoration(
      fillColor: theme.fillColor,
      filled: true,
      contentPadding: theme.contentPadding,
      hintText: widget.hintText,
      hintStyle: theme.hintTextStyle ??
          context.textTheme.labelSmall
              ?.copyWith(color: const Color(0xFF898A8D)),
      suffixIcon: widget.isPasswordField
          ? IconButton(
              iconSize: 20,
              icon: Icon(
                obscureText ? theme.obscureTextIcon : theme.visibleTextIcon,
                color: theme.iconColor,
              ),
              onPressed: togglePasswordVisibility,
            )
          : null,
      focusedBorder: OutlineInputBorder(
        borderRadius: theme.borderRadius ?? CircularRadius.sm,
        borderSide: theme.focusedBorderSide ?? context.borderSideXs,
      ),
      border: OutlineInputBorder(
        borderRadius: theme.borderRadius ?? CircularRadius.sm,
        borderSide: theme.borderSide ?? context.borderSideXs,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: theme.borderRadius ?? CircularRadius.sm,
        borderSide: theme.borderSide ??
            context.borderSideXs
                .copyWith(color: context.colorScheme.outlineVariant),
      ),
    );

    return widget.inputDecoration != null
        ? baseDecoration.copyWith(
            fillColor:
                widget.inputDecoration?.fillColor ?? baseDecoration.fillColor,
            filled: widget.inputDecoration?.filled ?? baseDecoration.filled,
            contentPadding: widget.inputDecoration?.contentPadding ??
                baseDecoration.contentPadding,
            hintText:
                widget.inputDecoration?.hintText ?? baseDecoration.hintText,
            hintStyle:
                widget.inputDecoration?.hintStyle ?? baseDecoration.hintStyle,
            suffixIcon:
                widget.inputDecoration?.suffixIcon ?? baseDecoration.suffixIcon,
            focusedBorder: widget.inputDecoration?.focusedBorder ??
                baseDecoration.focusedBorder,
            border: widget.inputDecoration?.border ?? baseDecoration.border,
          )
        : baseDecoration;
  }
}
