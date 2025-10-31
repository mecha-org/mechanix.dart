import 'package:flutter/material.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';
import 'package:widgets/widgets/menu/models/menu_position.dart';

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

DropdownPosition getDropDownPositionFromTransition(MenuTransitions transition) {
  switch (transition) {
    case MenuTransitions.fade:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.scale:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.scaleX:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.scaleY:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.slideLeft:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.slideRight:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.slideDown:
      return DropdownPosition.bottomCenter;

    case MenuTransitions.slideUp:
      return DropdownPosition.bottomCenter;
  }
}
