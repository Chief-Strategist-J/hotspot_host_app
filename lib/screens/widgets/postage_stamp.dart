import 'package:flutter/material.dart';
import 'package:hotspot_host_app/core/utils.dart';

class PostageStamp extends StatelessWidget {
  final String text;
  final bool selected;
  final String? imagePath;

  const PostageStamp({
    super.key,
    required this.text,
    this.imagePath,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[800], // Change background color to gray
          border: Border.all(
            color: Colors.white, // Change border color to white
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imagePath != null && imagePath!.isNotEmpty) // Check if imagePath is valid
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      imagePath!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Image not available'));
                      },
                    ),
                  ),
                if (selected)
                  Text(
                    text,
                    style: boldTextStyle(height: 0),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Change dotted border color to white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round // Ensures the ends of the stroke are rounded
      ..strokeJoin = StrokeJoin.bevel; // Rounds the corners of the stroke

    const dashWidth = 8;
    const dashSpace = 12;
    double distance = 0;

    while (distance < size.width) {
      canvas.drawLine(
        Offset(distance, 0),
        Offset(distance + dashWidth, 0),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    distance = 0;
    while (distance < size.height) {
      canvas.drawLine(
        Offset(0, distance),
        Offset(0, distance + dashWidth),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    distance = 0;
    while (distance < size.width) {
      canvas.drawLine(
        Offset(distance, size.height),
        Offset(distance + dashWidth, size.height),
        paint,
      );
      distance += dashWidth + dashSpace;
    }

    distance = 0;
    while (distance < size.height) {
      canvas.drawLine(
        Offset(size.width, distance),
        Offset(size.width, distance + dashWidth),
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
