import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

extension BorderExtension on BuildContext {
  Border get borderXs => Border.all(
        width: mechanixBorderWidthXs,
        color: Theme.of(this).colorScheme.outline,
        style: BorderStyle.solid,
      );

  Border get borderSm => Border.all(
        width: mechanixBorderWidthSm,
        color: Theme.of(this).colorScheme.outline,
        style: BorderStyle.solid,
      );

  Border get borderMd => Border.all(
        width: mechanixBorderWidthMd,
        color: Theme.of(this).colorScheme.outline,
        style: BorderStyle.solid,
      );

  Border get borderLg => Border.all(
        width: mechanixBorderWidthLg,
        color: Theme.of(this).colorScheme.outline,
        style: BorderStyle.solid,
      );

  Border get borderXl => Border.all(
        width: mechanixBorderWidthXl,
        color: Theme.of(this).colorScheme.outline,
        style: BorderStyle.solid,
      );

  Border border(
          {Color? color,
          double value = mechanixBorderWidthMd,
          BorderStyle style = BorderStyle.solid}) =>
      Border.all(
        color: color ?? Theme.of(this).colorScheme.outline,
        width: value,
        style: style,
      );

  Border only(
          {BorderSide left = const BorderSide(),
          BorderSide top = const BorderSide(),
          BorderSide right = const BorderSide(),
          BorderSide bottom = const BorderSide()}) =>
      Border(left: left, top: top, right: right, bottom: bottom);
}

extension BorderSideExtension on BuildContext {
  BorderSide get borderSideXs => BorderSide(
        width: mechanixBorderWidthXs,
        style: BorderStyle.solid,
      );

  BorderSide get borderSideSm => BorderSide(
        width: mechanixBorderWidthSm,
        style: BorderStyle.solid,
      );

  BorderSide get borderSideMd => BorderSide(
        width: mechanixBorderWidthMd,
        style: BorderStyle.solid,
      );

  BorderSide get borderSideLg => BorderSide(
        width: mechanixBorderWidthLg,
        style: BorderStyle.solid,
      );

  BorderSide get borderSideXl => BorderSide(
        width: mechanixBorderWidthXl,
        style: BorderStyle.solid,
      );

  BorderSide borderSide(
          {Color? color,
          double value = mechanixBorderWidthMd,
          BorderStyle style = BorderStyle.solid}) =>
      BorderSide(
          color: color ?? Theme.of(this).colorScheme.outline,
          style: style,
          width: value);
}
