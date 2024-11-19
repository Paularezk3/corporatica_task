import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx_controllers/detector_controller.dart';
import 'bounding_boxs.dart';

class DetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetectorController controller = Get.put(DetectorController());

    return WillPopScope(
      onWillPop: () async {
        controller.onClose(); // Clean up resources on back
        return true;
      },
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "captureButton",
              backgroundColor: const Color(0xFFA7BAE0),
              onPressed: () {
                if (controller.isCameraInitialized.value) {
                  controller.capturePhoto();
                } else {
                  print("Cannot capture photo, camera is not initialized.");
                }
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: "togglePreviewButton",
              backgroundColor: const Color(0xFFA7BAE0),
              onPressed: () {
                if (controller.isCameraInitialized.value) {
                  controller.togglePreview();
                } else {
                  print("Cannot toggle preview, camera is not initialized.");
                }
              },
              child: Obx(
                    () => Icon(
                  controller.isPreviewPaused.value
                      ? Icons.play_arrow
                      : Icons.pause,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Obx(() {
          if (!controller.isCameraInitialized.value) {
            print("Camera not initialized yet.");
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFA7BAE0)),
            );
          }

          if (controller.cameraController == null) {
            print("CameraController is null.");
            return const Center(
              child: Text("Camera initialization failed."),
            );
          }

          return Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: controller.cameraController!.value.aspectRatio,
                  child: CameraPreview(controller.cameraController!),
                ),
              ),
              Obx(() {
                print("Current recognitions: ${controller.recognitions}");
                return BoundingBoxes(
                  recognitions: controller.recognitions,
                  cameraHeight: controller.cameraHeight,
                  cameraWidth: controller.cameraWidth,
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}

