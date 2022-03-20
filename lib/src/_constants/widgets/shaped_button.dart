import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ShapedButton extends StatefulWidget {
  final Function onPressFunction;
  final String title;
  const ShapedButton(
      {required this.title, required this.onPressFunction, Key? key})
      : super(key: key);

  @override
  State<ShapedButton> createState() => _ShapedButtonState();
}

class _ShapedButtonState extends State<ShapedButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressFunction(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 45),
            painter: CurvePainter(context),
          ),
          Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final BuildContext context;
  CurvePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width * 0.5, size.height * 0.5),
        size.height * 2,
        [
          Colors.orange,
          Colors.red,
        ],
      )
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.92, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.08, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
