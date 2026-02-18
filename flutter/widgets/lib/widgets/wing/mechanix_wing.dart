import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class MechanixWing extends StatelessWidget {
  const MechanixWing({
    super.key,
    required this.size,
    required this.child,
    this.wingWidth = 25.0,
    this.color,
    this.borderColor,
    this.borderWidth = 0.5,
    this.shadowColor,
    this.elevation = 4,
  });

  final Size size;
  final Widget child;
  final double wingWidth;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final Color? shadowColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: _MechanixWingClipper(wingWidth: wingWidth),
      color: color ?? context.surfaceContainerHigh,
      elevation: 20,
      shadowColor: shadowColor ?? context.surface.withAlpha(90),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          painter: _MechanixWingBorderPainter(
            wingWidth: wingWidth,
            borderColor: borderColor ?? context.surfaceContainerHighest,
            borderWidth: borderWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _MechanixWingClipper extends CustomClipper<Path> {
  const _MechanixWingClipper({this.wingWidth = 25.0});

  final double wingWidth;

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    final Path p = Path();

    const double radius = 8;
    const double tabHeight = 12.0;
    final tabWidth = wingWidth;
    const double slopeWidth = 4.0;
    const double slopeHeight = 10.0;

    p.moveTo(radius, tabHeight);
    p.lineTo(width - tabWidth - slopeWidth - radius, tabHeight);

    p.quadraticBezierTo(width - tabWidth - slopeWidth, tabHeight,
        width - tabWidth - (slopeWidth / 2), slopeHeight / 2);

    p.quadraticBezierTo(
        width - tabWidth + 3, 0, width - tabWidth + radius - 2, 0);

    p.lineTo(width - radius, 0);
    p.quadraticBezierTo(width, 0, width, radius);

    p.lineTo(width, height - radius);
    p.quadraticBezierTo(width, height, width - radius, height);

    p.lineTo(radius, height);
    p.quadraticBezierTo(0, height, 0, height - radius);

    p.lineTo(0, tabHeight + radius);
    p.quadraticBezierTo(0, tabHeight, radius, tabHeight);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _MechanixWingBorderPainter extends CustomPainter {
  _MechanixWingBorderPainter({
    required this.wingWidth,
    required this.borderColor,
    required this.borderWidth,
  });

  final double wingWidth;
  final Color borderColor;
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _MechanixWingClipper(wingWidth: wingWidth).getClip(size);

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
