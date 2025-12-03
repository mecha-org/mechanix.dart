import 'package:widgets/mechanix.dart';

class BottomBarButton {
  const BottomBarButton({
    required this.onPressed,
    this.iconPath = '',
    this.iconWidget,
  });

  final String iconPath;
  final void Function() onPressed;
  final IconWidget? iconWidget;
}
