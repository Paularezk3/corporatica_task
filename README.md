# Object Detection & AR Application 📱🤖

## 🌟 Project Overview
This Flutter application integrates **ARCore** and **YOLOv2 Tiny** for **real-time object detection** and **augmented reality** marker placement. It allows users to interact with objects detected through the camera feed, place markers on them in 3D space, and manage captured images through a gallery system. The app utilizes **Firestore** for cloud storage and **Hive** for local storage.

The project was built with **Flutter**, using **GetX** for state management, to create a seamless and efficient experience on Android devices.

## 🚀 Key Features

- **Real-Time Object Detection** 🕵️‍♂️
  - Integrates **YOLOv2 Tiny** for lightweight object detection.
  - Detects and marks objects in real-time with ARCore.

- **AR Marker Placement** 🏷️
  - Places a visual marker (dot or bounding box) on detected objects in 3D space.
  - Dynamically adjusts markers with camera movements.

- **Photo Capture & Gallery** 📸
  - Capture photos from the camera and store them locally using **Hive**.
  - View and manage saved photos in the app's gallery.
  - Upload photos to **Firestore** with an option to flag them for upload status.

- **Firebase Integration** 🔥
  - Retrieve photos from Firestore and delete them as needed.
  - Upload photos to Firestore and track their upload status.
  - Firebase **Firestore** for cloud storage (no Firebase Storage or messaging used).

- **User Interface** 🎨
  - A simple **Welcome Screen** with two buttons: **Object Detection** and **Gallery**.
  - **Object Detection** page with buttons to pause detection and take photos.
  - **Gallery** page to manage saved photos and upload them to Firestore.

- **Optimized for Performance** ⚡
  - Focused on smooth performance with minimal latency and battery usage, even with real-time object detection.

- **Testing & Compatibility** 🧪
  - Thoroughly tested across various Android devices for consistent performance and compatibility.

## 📸 Screenshots

### Object Detection Page
![Object Detection](https://github.com/Paularezk3/corporatica_task/blob/master/Assets/images/Screenshot_20241119_055045.jpg?raw=true)

### Gallery Page
![Gallery Page](https://github.com/Paularezk3/corporatica_task/blob/master/Assets/images/Screenshot_20241119_055054.jpg?raw=true)

## 🛠️ Technologies Used

- **Flutter** 🦄
- **ARCore** for Augmented Reality
- **YOLOv2 Tiny** for Object Detection
- **GetX** for State Management
- **Hive** for Local Database Storage
- **Firebase Firestore** for Cloud Storage
- **Android** for mobile app development

## 📱 Installation Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/object-detection-ar-app.git
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Firebase:
  - Create a Firebase project and configure Firestore.
  - Download the `google-services.json` and place it in the `android/app` directory.
4. Build and run the app:
  ```bash
  flutter run
  ```

## 🎮 Usage Instructions

### Welcome Screen
- Tap on **Object Detection** to open the object detection page.
- Tap on **Gallery** to open the gallery of captured photos.

### Object Detection Page
- The **Object Detection** page automatically starts detecting objects in real-time using the device's camera.
- Use the **Pause Detection** floating button to temporarily stop the detection process.
- Tap the **Capture Photo** floating button to take a snapshot of the camera feed and save it to local storage.

### Gallery Page
- The **Gallery** displays all photos captured during object detection, stored locally using **Hive**.
- Each photo includes a status flag indicating whether it has been uploaded to **Firestore**.
- Available actions:
  - **Delete Photos**: Remove photos from the local storage and gallery.
  - **Upload to Firestore**: Upload selected photos to **Firestore**.
- Photos that have already been uploaded to Firestore are clearly marked to avoid duplication.

## 🔧 Development Setup

### Local Storage with Hive
- Photos captured in the app are stored locally in a lightweight **Hive** database for quick access and offline functionality.

### Firebase Firestore Integration
- The app uses **Firestore** to store uploaded photos, providing cloud access and retrieval.
- Each photo's upload status is tracked to distinguish between locally stored photos and those available in the cloud.

### ARCore and YOLOv2 Tiny
- ARCore ensures accurate marker placement in a 3D environment, dynamically updating markers as the user moves the camera.
- YOLOv2 Tiny performs real-time object detection optimized for mobile devices, balancing accuracy and performance.

### State Management
- The app uses **GetX** for state management, ensuring responsive and efficient UI updates without additional boilerplate.

## 🧪 Testing & Compatibility
- The app has been tested on multiple Android devices to ensure smooth functionality and consistent behavior across different environments.
- Performance optimizations include reduced latency for object detection and efficient memory usage during real-time processing.

## 🤝 Contributions
We welcome contributions to improve this project! To contribute:
1. Fork the repository.
2. Create a feature branch.
3. Submit a pull request for review.

Feel free to report any issues or suggestions by opening a GitHub issue.

## 📬 Contact
For any questions or feedback, please reach out to me at [paularezk3@gmail.com](mailto:paularezk3@gmail.com).

---
