import 'package:flutter/material.dart';

class BoundingBoxes extends StatelessWidget {
  final List<dynamic>? recognitions;
  final double cameraHeight;
  final double cameraWidth;

  const BoundingBoxes({
    super.key,
    required this.recognitions,
    required this.cameraHeight,
    required this.cameraWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    List<Widget> boxes = [];

    if (recognitions != null && recognitions!.isNotEmpty) {
      for (var recognition in recognitions!) {
        final rect = recognition['rect'];

        if (rect == null) continue;

        // Scale bounding box coordinates
        double x = rect['x'] * screenWidth;
        double y = rect['y'] * screenHeight;
        double w = rect['w'] * screenWidth;
        double h = rect['h'] * screenHeight;

        String detectedClass = recognition['detectedClass'] ?? 'Unknown';
        double confidence = (recognition['confidenceInClass'] ?? 0) * 100;

        // Add bounding box with label
        boxes.add(
          Positioned(
            left: x,
            top: y,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label above the box
                Container(
                  color: Colors.red.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '$detectedClass ${(confidence).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Bounding box
                Container(
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 3),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Stack(children: boxes);
  }
}
