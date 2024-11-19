import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoGalleryController extends GetxController {
  RxList<File> savedImages = <File>[].obs;
  RxSet<String> uploadedImages = <String>{}.obs;
  RxSet<String> uploadingImages = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadGallery();
  }

  Future<void> loadGallery() async {
    try {
      print("Loading photos from Hive...");
      final photosBox = Hive.box<String>('photos');
      final paths = photosBox.values.toList();
      print("Retrieved photo paths from Hive: $paths");

      savedImages.value = paths.map((path) => File(path)).toList();

      // Load uploaded images from Hive
      final uploadedPathsBox = Hive.box<bool>('uploaded_images');
      final uploadedKeys = uploadedPathsBox.keys.where((key) => uploadedPathsBox.get(key) == true);

      uploadedImages.addAll(uploadedKeys.cast<String>());

      print("Photo files loaded into gallery: ${savedImages.value}");
    } catch (e) {
      print("Error loading gallery: $e");
    }
  }

  Future<void> deleteImage(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        print("File deleted: ${file.path}");
      }

      // Remove photo path from Hive
      final photosBox = Hive.box<String>('photos');
      final key = photosBox.keys.firstWhere((k) => photosBox.get(k) == file.path);
      await photosBox.delete(key);
      print("File path removed from Hive: ${file.path}");

      savedImages.remove(file);

      // Remove from uploadedImages set
      uploadedImages.remove(file.path);

      // Remove from uploaded_images Hive box
      final uploadedPathsBox = Hive.box<bool>('uploaded_images');
      await uploadedPathsBox.delete(file.path);
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  bool isUploaded(String path) => uploadedImages.contains(path);
   bool isDirectlyUploaded=false;

  bool isUploading(String path) => uploadingImages.contains(path);
  Future<void> uploadImageToFirestore(File image) async {
    final imagePath = image.path;
    try {
      uploadingImages.add(imagePath); // Indicate that the image is being uploaded

      // Convert image to base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Generate a unique ID for the document
      final docId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload to Firestore
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('images').doc(docId).set({
        'fileName': image.uri.pathSegments.last,
        'base64Image': base64Image,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      print("Image uploaded to Firestore with doc ID: $docId");

      // Mark as uploaded in Hive
      final uploadedPathsBox = Hive.box<bool>('uploaded_images');
      await uploadedPathsBox.put(imagePath, true);

      // Immediately update the uploadedImages set
      uploadedImages.add(imagePath); // Triggers UI update
      print("Image marked as uploaded: $imagePath");

    } catch (e) {
      print("Error uploading image: $e");
    } finally {
      uploadingImages.remove(imagePath); // Remove from the uploading set
    }
  }

}
