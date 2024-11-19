import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../AI Model/model_class.dart';
import 'package:hive/hive.dart';

import 'photo_gallery_controller.dart';

class DetectorController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxList<dynamic> recognitions = <dynamic>[].obs;
  RxBool isPreviewPaused = false.obs;

  final double cameraHeight = 720; // Camera feed height
  final double cameraWidth = 1280; // Camera feed width

  @override
  void onInit() {
    super.onInit();
    initializeCameraAndModel();
  }

  Future<void> initializeCameraAndModel() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      print("Camera is already initialized.");
      return;
    }

    try {
      print("Loading YOLO model...");
      await ModelClass.loadYOLOModel();
      print("YOLO model loaded.");

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras available.");
        return;
      }

      print("Initializing camera...");
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
      print("Camera initialized successfully.");

      startImageStream();
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  void startImageStream() {
    if (cameraController != null && ModelClass.isModelLoaded) {
      print("Starting image stream...");
      cameraController!.startImageStream((cameraImage) async {
        final predictions = await ModelClass.ImageDetection(cameraImage);
        if (predictions != null) {
          recognitions.assignAll(predictions);
          print("Current recognitions: $predictions");
        }
      });
    } else {
      print("Cannot start image stream. Camera or model not initialized.");
    }
  }
  Future<void> capturePhoto() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        print("Stopping image stream for photo capture...");
        await cameraController!.stopImageStream();

        final directory = await getApplicationDocumentsDirectory();
        final filePath = path.join(directory.path, '${DateTime.now()}.jpg');
        print("Saving photo to path: $filePath");

        final capturedFile = await cameraController!.takePicture();
        final savedImage = await File(capturedFile.path).copy(filePath);

        print("Photo saved successfully: ${savedImage.path}");

        // Notify PhotoGalleryController of the new image
        final photoGalleryController = Get.find<PhotoGalleryController>();
        photoGalleryController.savedImages.add(savedImage);

        // Save to Hive
        final photosBox = Hive.box<String>('photos');
        photosBox.add(savedImage.path);

        print("Photo path added to Hive: ${savedImage.path}");

        startImageStream();
      } catch (e) {
        print("Capture photo error: $e");
      }
    } else {
      print("CameraController is not initialized.");
    }
  }


  void togglePreview() {
    if (cameraController != null) {
      if (isPreviewPaused.value) {
        cameraController!.resumePreview();
        print("Resumed camera preview.");
      } else {
        cameraController!.pausePreview();
        print("Paused camera preview.");
      }
      isPreviewPaused.toggle();
    } else {
      print("CameraController is null. Cannot toggle preview.");
    }
  }

  @override
  Future<void> onClose() async {
    print("Cleaning up DetectorController resources...");
    if (cameraController != null && cameraController!.value.isStreamingImages) {
      print("Stopping camera stream...");
      await cameraController!.stopImageStream();
    }
    print("Disposing CameraController...");
    await cameraController?.dispose();
    cameraController = null;

    await ModelClass.closeModel();
    print("Resources cleaned up.");
    super.onClose();
  }
}
