import 'package:flutter/material.dart';

class PHScaleWidget extends StatelessWidget {
  const PHScaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const SizedBox(height: 10),
        Container(
          width: 320,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: 
            List.generate(15, (index) => Text('$index')),
          ),
        ),
        SizedBox(
          height: 50,
          child: CustomPaint(
            size: const Size(330, 50),
            painter: PHScalePainter(),
          ),
        ),
       
        const SizedBox(height: 10),
        Container(
          width: 280,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Strongly\nacidic',textAlign: TextAlign.center,),
              SizedBox(width: 20,),
              Text('Acidic'),
                SizedBox(width: 10,),
              Text('Neutral'),
               SizedBox(width: 40,),
              Text('Alkaline'),
            ],
          ),
        )
      ],
    );
  }
}

class PHScalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw background gradient for pH scale
    final gradient = LinearGradient(
      colors: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue
      ],
      stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    paint.shader = gradient.createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(25)),
      paint,
    );

    // Draw the indicator circle
    paint.shader = null;
    paint.color = Colors.green;
    canvas.drawCircle(Offset(10, size.height / 4), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
