import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controllers/photo_gallery_controller.dart';

class PhotoGalleryApp extends StatelessWidget {
  final PhotoGalleryController controller = Get.put(PhotoGalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Obx(() {
        if (controller.savedImages.isEmpty) {
          return Center(child: Text('No images found'));
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: controller.savedImages.length,
          itemBuilder: (context, index) {
            final image = controller.savedImages[index];
            final isUploaded = controller.isUploaded(image.path);

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isUploaded ? Colors.green : Colors.transparent,
                      width: 3.0,
                    ),
                  ),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => controller.deleteImage(image),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Obx(() {
                    if (controller.isUploading(image.path)) {
                      return SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return IconButton(
                      icon: Icon(
                        Icons.cloud_upload,
                        color: Colors.blue,
                      ),
                      onPressed: () => controller.uploadImageToFirestore(image),
                    );
                  }),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
