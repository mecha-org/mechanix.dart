import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/widgets.dart';

export 'text_field_enums.dart';
export 'text_field_theme.dart';

/// A customizable Material 3 text field following the Mechanix design system.
///
/// Wraps Flutter's native [TextField] and provides consistent design system
/// styling, colors, typography, borders, and state transitions.
class MechanixTextField extends StatelessWidget {
  const MechanixTextField({
    super.key,
    this.variant = MechanixTextFieldVariant.filled,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.labelText,
    this.label,
    this.hintText,
    this.supportingText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.theme,
  });

  /// Factory constructor for a Filled [MechanixTextField].
  const MechanixTextField.filled({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.labelText,
    this.label,
    this.hintText,
    this.supportingText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.theme,
  }) : variant = MechanixTextFieldVariant.filled;

  /// Factory constructor for an Outlined [MechanixTextField].
  const MechanixTextField.outlined({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.labelText,
    this.label,
    this.hintText,
    this.supportingText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.theme,
  }) : variant = MechanixTextFieldVariant.outlined;

  /// The visual variant (filled or outlined).
  final MechanixTextFieldVariant variant;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// An optional initial value.
  final String? initialValue;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Optional base decoration. Any properties defined directly on
  /// [MechanixTextField] take precedence.
  final InputDecoration? decoration;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text can be changed.
  final bool readOnly;

  /// Whether to show cursor.
  final bool? showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Character used for obscuring text if [obscureText] is true.
  final String obscuringCharacter;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// Whether to show input suggestions as the user types.
  final bool enableSuggestions;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// The minimum number of lines to occupy when not expanding.
  final int? minLines;

  /// Whether this widget's height will be sized to fill its parent.
  final bool expands;

  /// The maximum number of characters to allow in the text field.
  final int? maxLength;

  /// Determines how the [maxLength] limit should be enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Called when the user initiates a change to the TextField's value.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits editing on the keyboard.
  final VoidCallback? onEditingComplete;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Optional input formatters to enforce input format.
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is disabled.
  final bool? enabled;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// Configures padding to edges of surrounding Scrollable.
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// Called for each distinct tap on the text field.
  final GestureTapCallback? onTap;

  /// {@macro flutter.material.textfield.onTapOutside}
  final TapRegionCallback? onTapOutside;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip clipBehavior;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// Determine whether this text field can request the primary focus.
  final bool canRequestFocus;

  /// {@macro flutter.widgets.editableText.spellCheckConfiguration}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@macro flutter.widgets.magnifier.intro}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Optional label string to display above or inside the field.
  final String? labelText;

  /// Optional widget label.
  final Widget? label;

  /// Optional placeholder / hint text.
  final String? hintText;

  /// Supporting text displayed below the field (alias for [helperText]).
  final String? supportingText;

  /// Helper text displayed below the field.
  final String? helperText;

  /// Error text displayed below the field, putting it in error state.
  final String? errorText;

  /// Optional prefix icon or widget.
  final Widget? prefixIcon;

  /// Optional suffix icon or widget.
  final Widget? suffixIcon;

  /// Optional inline prefix widget.
  final Widget? prefix;

  /// Optional inline suffix widget.
  final Widget? suffix;

  /// Optional custom theme configuration overrides.
  final TextFieldThemeDataConfig? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = resolveDecoration(context);
    final themeData = Theme.of(context);
    final componentTheme = theme ?? MechanixTextFieldTheme.of(context);

    final effectiveCursorColor =
        cursorColor ??
        componentTheme.cursorColor ??
        themeData.colorScheme.primary;

    final effectiveStyle =
        style ??
        themeData.textTheme.bodyLarge?.copyWith(
          color: themeData.colorScheme.onSurface,
        );

    return TextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      decoration: effectiveDecoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: effectiveStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: readOnly,
      showCursor: showCursor,
      autofocus: autofocus,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: effectiveCursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      onTap: onTap,
      onTapOutside: onTapOutside,
      mouseCursor: mouseCursor,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      canRequestFocus: canRequestFocus,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
    );
  }

  /// Resolves the full [InputDecoration] for this [MechanixTextField].
  InputDecoration resolveDecoration(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;
    final shapeTheme =
        themeData.extension<ShapeTheme>() ?? ShapeTheme.standard();
    final componentTheme = theme ?? MechanixTextFieldTheme.of(context);

    final isFilled = variant == MechanixTextFieldVariant.filled;

    // Resolve borders responding to WidgetState
    final WidgetStateInputBorder baseBorder = _buildBorder(
      isFilled: isFilled,
      colorScheme: colorScheme,
      shapeTheme: shapeTheme,
      componentTheme: componentTheme,
    );

    // Dynamic fill color responding to states
    final WidgetStateColor? dynamicFillColor = isFilled
        ? WidgetStateColor.resolveWith((states) {
            final override = componentTheme.fillColor?.resolve(states);
            if (override != null) return override;

            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.04);
            }
            if (states.contains(WidgetState.hovered)) {
              return Color.alphaBlend(
                colorScheme.onSurface.withValues(alpha: 0.05),
                colorScheme.surfaceContainerHighest,
              );
            }
            return colorScheme.surfaceContainerHighest;
          })
        : null;

    final effectiveLabelText = labelText;
    final effectiveLabel =
        label ?? (effectiveLabelText != null ? Text(effectiveLabelText) : null);
    final effectiveHelperText = supportingText ?? helperText;

    // Typography
    final effectiveLabelStyle =
        componentTheme.labelStyle ??
        textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant);

    final effectiveFloatingLabelStyle = WidgetStateTextStyle.resolveWith((
      states,
    ) {
      final base =
          componentTheme.floatingLabelStyle ??
          textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ) ??
          const TextStyle(fontSize: 12);

      final stateBorderColor = componentTheme.borderColor?.resolve(states);
      if (stateBorderColor != null) {
        return base.copyWith(color: stateBorderColor);
      }

      if (states.contains(WidgetState.error)) {
        return base.copyWith(color: colorScheme.error);
      }
      if (states.contains(WidgetState.focused)) {
        return base.copyWith(color: colorScheme.primary);
      }
      if (states.contains(WidgetState.disabled)) {
        return base.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.38),
        );
      }
      return base.copyWith(
        color: componentTheme.labelStyle?.color ?? colorScheme.onSurfaceVariant,
      );
    });

    final effectiveHintStyle =
        componentTheme.hintStyle ??
        textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          fontWeight: FontWeight.w300,
        );

    final effectiveHelperStyle =
        componentTheme.helperStyle ??
        textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant);

    final effectiveErrorStyle =
        componentTheme.errorStyle ??
        textTheme.bodySmall?.copyWith(color: colorScheme.error);

    final dynamicIconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return colorScheme.error;
      }
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withValues(alpha: 0.38);
      }
      return componentTheme.prefixIconColor ?? colorScheme.onSurfaceVariant;
    });

    final defaultDecoration = InputDecoration(
      filled: isFilled,
      fillColor: isFilled ? dynamicFillColor : Colors.transparent,
      border: baseBorder,
      label: effectiveLabel,
      hintText: hintText,
      hintStyle: effectiveHintStyle,
      helperText: effectiveHelperText,
      helperStyle: effectiveHelperStyle,
      errorText: errorText,
      errorStyle: effectiveErrorStyle,
      prefixIcon: prefixIcon,
      prefixIconColor: dynamicIconColor,
      suffixIcon: suffixIcon,
      suffixIconColor: dynamicIconColor,
      prefix: prefix,
      suffix: suffix,
      labelStyle: effectiveLabelStyle,
      floatingLabelStyle: effectiveFloatingLabelStyle,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding:
          componentTheme.contentPadding ??
          (isFilled
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
      isDense: false,
    );

    if (decoration != null) {
      return defaultDecoration.copyWith(
        icon: decoration!.icon,
        iconColor: decoration!.iconColor,
        label: decoration!.label ?? defaultDecoration.label,
        labelText: decoration!.labelText ?? defaultDecoration.labelText,
        labelStyle: decoration!.labelStyle ?? defaultDecoration.labelStyle,
        floatingLabelStyle:
            decoration!.floatingLabelStyle ??
            defaultDecoration.floatingLabelStyle,
        helperText: decoration!.helperText ?? defaultDecoration.helperText,
        helperStyle: decoration!.helperStyle ?? defaultDecoration.helperStyle,
        helperMaxLines: decoration!.helperMaxLines,
        hintText: decoration!.hintText ?? defaultDecoration.hintText,
        hintStyle: decoration!.hintStyle ?? defaultDecoration.hintStyle,
        hintTextDirection: decoration!.hintTextDirection,
        hintMaxLines: decoration!.hintMaxLines,
        error: decoration!.error,
        errorText: decoration!.errorText ?? defaultDecoration.errorText,
        errorStyle: decoration!.errorStyle ?? defaultDecoration.errorStyle,
        errorMaxLines: decoration!.errorMaxLines,
        floatingLabelBehavior:
            decoration!.floatingLabelBehavior ??
            defaultDecoration.floatingLabelBehavior,
        floatingLabelAlignment: decoration!.floatingLabelAlignment,
        isDense: decoration!.isDense ?? defaultDecoration.isDense,
        contentPadding:
            decoration!.contentPadding ?? defaultDecoration.contentPadding,
        isCollapsed: decoration!.isCollapsed,
        prefixIcon: decoration!.prefixIcon ?? defaultDecoration.prefixIcon,
        prefixIconConstraints: decoration!.prefixIconConstraints,
        prefix: decoration!.prefix ?? defaultDecoration.prefix,
        prefixText: decoration!.prefixText,
        prefixStyle: decoration!.prefixStyle,
        prefixIconColor:
            decoration!.prefixIconColor ?? defaultDecoration.prefixIconColor,
        suffixIcon: decoration!.suffixIcon ?? defaultDecoration.suffixIcon,
        suffix: decoration!.suffix ?? defaultDecoration.suffix,
        suffixText: decoration!.suffixText,
        suffixStyle: decoration!.suffixStyle,
        suffixIconColor:
            decoration!.suffixIconColor ?? defaultDecoration.suffixIconColor,
        suffixIconConstraints: decoration!.suffixIconConstraints,
        counter: decoration!.counter,
        counterText: decoration!.counterText,
        counterStyle: decoration!.counterStyle,
        filled: decoration!.filled ?? defaultDecoration.filled,
        fillColor: decoration!.fillColor ?? defaultDecoration.fillColor,
        focusColor: decoration!.focusColor,
        hoverColor: decoration!.hoverColor,
        errorBorder: decoration!.errorBorder,
        focusedBorder: decoration!.focusedBorder,
        focusedErrorBorder: decoration!.focusedErrorBorder,
        disabledBorder: decoration!.disabledBorder,
        enabledBorder: decoration!.enabledBorder,
        border: decoration!.border ?? defaultDecoration.border,
        enabled: decoration!.enabled,
        semanticCounterText: decoration!.semanticCounterText,
        alignLabelWithHint: decoration!.alignLabelWithHint,
        constraints: decoration!.constraints,
      );
    }

    return defaultDecoration;
  }

  WidgetStateInputBorder _buildBorder({
    required bool isFilled,
    required ColorScheme colorScheme,
    required ShapeTheme shapeTheme,
    required TextFieldThemeDataConfig componentTheme,
  }) {
    final borderRadius =
        componentTheme.borderRadius ??
        (isFilled
            ? BorderRadius.vertical(
                top: Radius.circular(shapeTheme.extraSmall.topLeft.x),
              )
            : shapeTheme.extraSmall);

    final dynamicBorderColor = WidgetStateColor.resolveWith((states) {
      final override = componentTheme.borderColor?.resolve(states);
      if (override != null) return override;

      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.error)) {
        return colorScheme.error;
      }
      if (states.contains(WidgetState.focused)) {
        return colorScheme.primary;
      }
      if (states.contains(WidgetState.hovered)) {
        return colorScheme.onSurface;
      }
      return isFilled
          ? colorScheme.onSurfaceVariant.withValues(alpha: 0.38)
          : colorScheme.outline;
    });

    final dynamicBorderWidth = WidgetStateProperty.resolveWith<double>((states) {
      final override = componentTheme.borderWidth?.resolve(states);
      if (override != null) return override;

      if (states.contains(WidgetState.focused) ||
          states.contains(WidgetState.error)) {
        return 2.0;
      }
      return 1.0;
    });

    return WidgetStateInputBorder.resolveWith((states) {
      final borderSide = BorderSide(
        color: dynamicBorderColor.resolve(states),
        width: dynamicBorderWidth.resolve(states),
      );

      return isFilled
          ? UnderlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            )
          : OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            );
    });
  }
}

/// A form field version of [MechanixTextField] that integrates with [Form].
class MechanixTextFormField extends StatelessWidget {
  const MechanixTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.variant = MechanixTextFieldVariant.filled,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.labelText,
    this.label,
    this.hintText,
    this.supportingText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.theme,
  });

  /// The visual variant (filled or outlined).
  final MechanixTextFieldVariant variant;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// An optional initial value.
  final String? initialValue;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Base decoration to customize or extend.
  final InputDecoration? decoration;

  /// The type of keyboard to use.
  final TextInputType? keyboardType;

  /// Capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Action button for the keyboard.
  final TextInputAction? textInputAction;

  /// The text style.
  final TextStyle? style;

  /// Strut style for line height.
  final StrutStyle? strutStyle;

  /// Text direction.
  final TextDirection? textDirection;

  /// Horizontal text alignment.
  final TextAlign textAlign;

  /// Vertical text alignment.
  final TextAlignVertical? textAlignVertical;

  /// Whether to auto focus.
  final bool autofocus;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to show the cursor.
  final bool? showCursor;

  /// Obscuring character for passwords.
  final String obscuringCharacter;

  /// Whether to hide the text.
  final bool obscureText;

  /// Whether autocorrection is enabled.
  final bool autocorrect;

  /// Smart dashes type.
  final SmartDashesType? smartDashesType;

  /// Smart quotes type.
  final SmartQuotesType? smartQuotesType;

  /// Whether suggestions are enabled.
  final bool enableSuggestions;

  /// How max length is enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Maximum line count.
  final int? maxLines;

  /// Minimum line count.
  final int? minLines;

  /// Whether to expand to parent height.
  final bool expands;

  /// Max character count.
  final int? maxLength;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Callback on tap.
  final GestureTapCallback? onTap;

  /// Callback on tap outside.
  final TapRegionCallback? onTapOutside;

  /// Callback when editing completes.
  final VoidCallback? onEditingComplete;

  /// Callback on field submit.
  final ValueChanged<String>? onFieldSubmitted;

  /// Callback when form is saved.
  final FormFieldSetter<String>? onSaved;

  /// Validation logic.
  final FormFieldValidator<String>? validator;

  /// Input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether field is enabled.
  final bool? enabled;

  /// Thickness of the cursor.
  final double cursorWidth;

  /// Height of the cursor.
  final double? cursorHeight;

  /// Corner radius of the cursor.
  final Radius? cursorRadius;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Keyboard brightness.
  final Brightness? keyboardAppearance;

  /// Padding around scrollable.
  final EdgeInsets scrollPadding;

  /// Selection enablement.
  final bool? enableInteractiveSelection;

  /// Selection controls.
  final TextSelectionControls? selectionControls;

  /// Scroll physics.
  final ScrollPhysics? scrollPhysics;

  /// Autofill hints.
  final Iterable<String>? autofillHints;

  /// Autovalidate mode.
  final AutovalidateMode? autovalidateMode;

  /// Scroll controller.
  final ScrollController? scrollController;

  /// Restoration ID.
  final String? restorationId;

  /// Stylus handwriting support.
  final bool stylusHandwritingEnabled;

  /// IME personalized learning.
  final bool enableIMEPersonalizedLearning;

  /// Mouse cursor.
  final MouseCursor? mouseCursor;

  /// Spell check configuration.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Magnifier configuration.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Optional label string.
  final String? labelText;

  /// Optional widget label.
  final Widget? label;

  /// Optional placeholder / hint text.
  final String? hintText;

  /// Supporting text displayed below the field (alias for [helperText]).
  final String? supportingText;

  /// Helper text displayed below the field.
  final String? helperText;

  /// Optional prefix icon or widget.
  final Widget? prefixIcon;

  /// Optional suffix icon or widget.
  final Widget? suffixIcon;

  /// Optional inline prefix widget.
  final Widget? prefix;

  /// Optional inline suffix widget.
  final Widget? suffix;

  /// Optional custom theme configuration overrides.
  final TextFieldThemeDataConfig? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = MechanixTextField(
      variant: variant,
      labelText: labelText,
      label: label,
      hintText: hintText,
      supportingText: supportingText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefix: prefix,
      suffix: suffix,
      theme: theme,
      decoration: decoration,
    ).resolveDecoration(context);

    final themeData = Theme.of(context);
    final componentTheme = theme ?? MechanixTextFieldTheme.of(context);

    final effectiveCursorColor =
        cursorColor ??
        componentTheme.cursorColor ??
        themeData.colorScheme.primary;

    final effectiveStyle =
        style ??
        themeData.textTheme.bodyLarge?.copyWith(
          color: themeData.colorScheme.onSurface,
        );

    return TextFormField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      decoration: effectiveDecoration,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      style: effectiveStyle,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: effectiveCursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      scrollController: scrollController,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
    );
  }
}
