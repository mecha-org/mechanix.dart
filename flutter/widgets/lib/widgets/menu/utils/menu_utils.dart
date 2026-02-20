import 'package:flutter/material.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/models/menu_position.dart';

Offset calculateSmartOffset({
  required BuildContext context,
  required Size menuSize,
  required MenuDropdownPosition position,
  EdgeInsets screenPadding = const EdgeInsets.all(8),
}) {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final RenderBox anchorBox = context.findRenderObject() as RenderBox;

  final anchorTopLeft = anchorBox.localToGlobal(Offset.zero, ancestor: overlay);

  final anchorRect = anchorTopLeft & anchorBox.size;

  final overlaySize = overlay.size;

  double dx;
  double dy;

  switch (position) {
    case MenuDropdownPosition.left:
      dx = anchorRect.left - menuSize.width;
      dy = anchorRect.top + (anchorRect.height - menuSize.height) / 2;
      break;

    case MenuDropdownPosition.leftStart:
      dx = anchorRect.left - menuSize.width;
      dy = anchorRect.top;
      break;

    case MenuDropdownPosition.leftEnd:
      dx = anchorRect.left - menuSize.width;
      dy = anchorRect.bottom - menuSize.height;
      break;

    case MenuDropdownPosition.right:
      dx = anchorRect.right;
      dy = anchorRect.top + (anchorRect.height - menuSize.height) / 2;
      break;

    case MenuDropdownPosition.rightStart:
      dx = anchorRect.right;
      dy = anchorRect.top;
      break;

    case MenuDropdownPosition.rightEnd:
      dx = anchorRect.right;
      dy = anchorRect.bottom - menuSize.height;
      break;

    case MenuDropdownPosition.top:
      dx = anchorRect.left + (anchorRect.width - menuSize.width) / 2;
      dy = anchorRect.top - menuSize.height;
      break;

    case MenuDropdownPosition.topStart:
      dx = anchorRect.left;
      dy = anchorRect.top - menuSize.height;
      break;

    case MenuDropdownPosition.topEnd:
      dx = anchorRect.right - menuSize.width;
      dy = anchorRect.top - menuSize.height;
      break;

    case MenuDropdownPosition.bottom:
      dx = anchorRect.left + (anchorRect.width - menuSize.width) / 2;
      dy = anchorRect.bottom;
      break;

    case MenuDropdownPosition.bottomStart:
      dx = anchorRect.left;
      dy = anchorRect.bottom;
      break;

    case MenuDropdownPosition.bottomEnd:
      dx = anchorRect.right - menuSize.width;
      dy = anchorRect.bottom;
      break;
  }

  if (dx < screenPadding.left) {
    final newDx = anchorRect.right;
    if (newDx + menuSize.width <= overlaySize.width) {
      dx = newDx;
    }
  } else if (dx + menuSize.width > overlaySize.width - screenPadding.right) {
    final newDx = anchorRect.left - menuSize.width;
    if (newDx >= screenPadding.left) {
      dx = newDx;
    }
  }

  if (dy < screenPadding.top) {
    final newDy = anchorRect.bottom;
    if (newDy + menuSize.height <= overlaySize.height) {
      dy = newDy;
    }
  } else if (dy + menuSize.height > overlaySize.height - screenPadding.bottom) {
    final newDy = anchorRect.top - menuSize.height;
    if (newDy >= screenPadding.top) {
      dy = newDy;
    }
  }

  dx = dx.clamp(
    screenPadding.left,
    overlaySize.width - menuSize.width - screenPadding.right,
  );

  dy = dy.clamp(
    screenPadding.top,
    overlaySize.height - menuSize.height - screenPadding.bottom,
  );

  return Offset(
    dx - anchorRect.left,
    dy - anchorRect.top,
  );
}

MenuPosition getDropDownPosition(DropdownPosition type) {
  switch (type) {
    case DropdownPosition.center:
      return MenuPosition(
        followerAnchor: Alignment.center,
        targetAnchor: Alignment.center,
      );
    case DropdownPosition.centerRight:
      return MenuPosition(
        followerAnchor: Alignment.centerRight,
        targetAnchor: Alignment.centerRight,
      );
    case DropdownPosition.centerLeft:
      return MenuPosition(
        followerAnchor: Alignment.centerLeft,
        targetAnchor: Alignment.centerLeft,
      );
    case DropdownPosition.bottomCenter:
      return MenuPosition(
        followerAnchor: Alignment.topCenter,
        targetAnchor: Alignment.bottomCenter,
      );
    case DropdownPosition.bottomRight:
      return MenuPosition(
        followerAnchor: Alignment.topRight,
        targetAnchor: Alignment.bottomRight,
      );
    case DropdownPosition.bottomLeft:
      return MenuPosition(
        followerAnchor: Alignment.topLeft,
        targetAnchor: Alignment.bottomLeft,
      );
    case DropdownPosition.topCenter:
      return MenuPosition(
        followerAnchor: Alignment.bottomCenter,
        targetAnchor: Alignment.topCenter,
      );
    case DropdownPosition.topRight:
      return MenuPosition(
        followerAnchor: Alignment.bottomRight,
        targetAnchor: Alignment.topRight,
      );
    case DropdownPosition.topLeft:
      return MenuPosition(
        followerAnchor: Alignment.bottomLeft,
        targetAnchor: Alignment.topLeft,
      );
  }
}
