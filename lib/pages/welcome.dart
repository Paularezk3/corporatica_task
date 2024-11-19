
import 'package:flutter/material.dart';

import '../AI Model/detector_screen.dart';
import 'photo_gallery_app.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
               const SizedBox(
                height: 100,
              ),
               const Text("Object Detection App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 22,
              ),

               const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetectorPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  padding: WidgetStateProperty.all(
                       const EdgeInsets.symmetric(horizontal: 99, vertical: 15)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(66))),
                ),
                child:  const Text(
                  "Object Detection",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  PhotoGalleryApp()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 85, vertical: 15)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(66))),
                ),
                child: const Text(
                  "Gallery",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
