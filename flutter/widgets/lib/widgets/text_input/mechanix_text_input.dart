import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/text_input/mechanix_text_input_theme.dart';

class MechanixTextInput<T> extends StatefulWidget {
  const MechanixTextInput.textInput({
    super.key,
    this.isPasswordField = false,
    this.onChanged,
    this.hintText,
    this.isFormField = false,
    this.inputDecoration,
    this.validator,
    this.onFieldSubmitted,
    this.label,
    this.theme,
    this.initialValue,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onClear,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.anchorWidgetIconPath = '',
    this.anchorWidget,
    this.cursorColor,
    this.getCurrentValue,
  })  : isSearchField = false,
        isClearButtonRequired = false,
        textEditingController = null;

  const MechanixTextInput.password({
    super.key,
    this.isPasswordField = true,
    this.onChanged,
    this.hintText,
    this.isFormField = false,
    this.inputDecoration,
    this.label,
    this.onFieldSubmitted,
    this.validator,
    this.theme,
    this.initialValue,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onClear,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.anchorWidgetIconPath = '',
    this.anchorWidget,
    this.cursorColor,
  })  : isSearchField = false,
        getCurrentValue = null,
        isClearButtonRequired = false,
        textEditingController = null;

  const MechanixTextInput.search({
    super.key,
    this.onChanged,
    this.hintText,
    this.isFormField = false,
    this.inputDecoration,
    this.label,
    this.onFieldSubmitted,
    this.validator,
    this.theme,
    this.initialValue,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onClear,
    this.focusNode,
    this.anchorWidgetIconPath = '',
    this.textEditingController,
    this.isClearButtonRequired = true,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.anchorWidget,
    this.cursorColor,
  })  : isSearchField = true,
        isPasswordField = false,
        getCurrentValue = null;

  final String? label;
  final bool isPasswordField;
  final bool isFormField;
  final ValueChanged<String>? onChanged;
  final InputDecoration? inputDecoration;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  final void Function(String value)? getCurrentValue;
  final String? Function(String?)? validator;
  final MechanixTextInputThemeData? theme;
  final String? initialValue;
  final String? errorText;
  final Widget? prefixIcon;
  final bool isSearchField;
  final Widget? suffixIcon;
  final VoidCallback? onClear;
  final bool isClearButtonRequired;
  final String anchorWidgetIconPath;
  final Widget? anchorWidget;
  final TextEditingController? textEditingController;
  final bool autofocus;
  final bool canRequestFocus;
  final FocusNode? focusNode;
  final Color? cursorColor;

  @override
  State<MechanixTextInput> createState() => _MechanixTextInputState();
}

class _MechanixTextInputState extends State<MechanixTextInput> {
  bool obscureText = true;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isFocused = false;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _focusNode.addListener(_onFocusChange);
    } else {
      _focusNode = widget.focusNode!;
      _focusNode.addListener(_onFocusChange);
    }
  }

  Future<void> _onFocusChange() async {
    if (!_focusNode.hasFocus) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    if (!mounted) return;
    setState(() {
      isFocused = !isFocused;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode.dispose();
    }

    _controller.dispose();
    super.dispose();
  }

  void onClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        MechanixTextInputTheme.of(context).merge(context, widget.theme);

    if (widget.isSearchField) {
      return Material(
        child: Container(
          padding: theme.widgetPadding,
          decoration: theme.widgetDecoration,
          height:
              isFocused ? theme.widgetHeight ?? 66 : theme.widgetHeight ?? 90,
          // height: theme.widgetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        autofocus: widget.autofocus,
                        canRequestFocus: widget.canRequestFocus,
                        focusNode: _focusNode,
                        controller: widget.textEditingController ?? _controller,
                        obscureText:
                            widget.isPasswordField ? obscureText : false,
                        style: theme.textStyle,
                        cursorColor: widget.cursorColor,
                        decoration: _buildInputDecoration(context, theme),
                        onChanged: widget.onChanged,
                      ),
                    ),
                  ),
                  if (widget.suffixIcon != null)
                    widget.suffixIcon!
                  else if (widget.isClearButtonRequired)
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: onClear,
                        icon: IconWidget.fromMechanix(
                          iconPath: MechanixIconImages.clearIcon,
                          boxHeight: 24,
                          boxWidth: 24,
                          iconHeight: 16,
                          iconWidth: 16,
                        ),
                      ),
                    )
                  else if (widget.anchorWidgetIconPath != '')
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          widget.onClear?.call();
                        },
                        icon: IconWidget(
                          iconPath: widget.anchorWidgetIconPath,
                          boxHeight: 24,
                          boxWidth: 24,
                          iconHeight: 16,
                          iconWidth: 16,
                        ),
                      ),
                    )
                  else if (widget.anchorWidget != null)
                    widget.anchorWidget!
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(
              widget.label ?? '',
              style: theme.labelTextStyle ??
                  context.textTheme.labelMedium
                      ?.copyWith(color: context.onSurfaceVariant),
            ).padBottom(8),
          Container(
            padding: theme.widgetPadding,
            decoration: theme.widgetDecoration,
            height:
                isFocused ? theme.widgetHeight ?? 66 : theme.widgetHeight ?? 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: widget.isFormField
                            ? TextFormField(
                                controller: _controller,
                                // focusNode: widget.focusNode,
                                focusNode: _focusNode,
                                autofocus: widget.autofocus,
                                canRequestFocus: widget.canRequestFocus,
                                obscureText: widget.isPasswordField
                                    ? obscureText
                                    : false,
                                style: theme.textStyle,
                                cursorColor: widget.cursorColor,
                                decoration:
                                    _buildInputDecoration(context, theme),
                                onChanged: widget.onChanged,
                                onFieldSubmitted: widget.onFieldSubmitted,
                                validator: widget.validator,
                              )
                            : TextField(
                                controller: _controller,
                                // focusNode: widget.focusNode,
                                focusNode: _focusNode,
                                autofocus: widget.autofocus,
                                cursorColor: widget.cursorColor,
                                canRequestFocus: widget.canRequestFocus,
                                obscureText: widget.isPasswordField
                                    ? obscureText
                                    : false,
                                style: theme.textStyle,
                                decoration:
                                    _buildInputDecoration(context, theme),
                                onChanged: widget.onChanged,
                              )),
                    if (widget.anchorWidgetIconPath != '')
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          onPressed: () {
                            widget.onClear?.call();
                            widget.getCurrentValue?.call(_controller.text);
                          },
                          icon: IconWidget(
                            iconPath: widget.anchorWidgetIconPath,
                            boxHeight: 24,
                            boxWidth: 24,
                            iconHeight: 16,
                            iconWidth: 16,
                          ),
                        ),
                      )
                    else if (widget.anchorWidget != null)
                      GestureDetector(
                        onTap: () {
                          widget.getCurrentValue?.call(_controller.text);
                        },
                        child: widget.anchorWidget!,
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
              ?.copyWith(color: context.onSurfaceVariant),
      errorText: widget.errorText,
      suffixIcon: widget.isPasswordField
          ? widget.suffixIcon ??
              IconButton(
                iconSize: 20,
                icon: Icon(
                  obscureText ? theme.obscureTextIcon : theme.visibleTextIcon,
                  color: context.onSurface,
                ),
                onPressed: togglePasswordVisibility,
              ).padOnly(right: 16)
          : widget.isSearchField
              ? null
              : widget.suffixIcon,
      prefixIcon: widget.isSearchField
          ? widget.prefixIcon ??
              IconWidget.fromMechanix(
                iconPath: MechanixIconImages.searchIcon,
                boxHeight: 24,
                boxWidth: 24,
                iconHeight: 20,
                iconWidth: 20,
              )
          : widget.prefixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: theme.borderRadius,
        borderSide: theme.focusedBorderSide ??
            context.borderSideXs.copyWith(color: Colors.transparent),
      ),
      border: OutlineInputBorder(
        borderRadius: theme.borderRadius,
        borderSide: theme.borderSide ??
            context.borderSideXs.copyWith(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: theme.borderRadius,
        borderSide: theme.enabledBorderSide ??
            context.borderSideXs.copyWith(color: Colors.transparent),
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
            errorText:
                widget.inputDecoration?.errorText ?? baseDecoration.errorText,
            prefixIcon:
                widget.inputDecoration?.prefixIcon ?? baseDecoration.prefixIcon,
            suffixIcon:
                widget.inputDecoration?.suffixIcon ?? baseDecoration.suffixIcon,
            focusedBorder: widget.inputDecoration?.focusedBorder ??
                baseDecoration.focusedBorder,
            border: widget.inputDecoration?.border ?? baseDecoration.border,
          )
        : baseDecoration;
  }
}
