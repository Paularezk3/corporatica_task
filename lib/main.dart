
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_classification_app/pages/welcome.dart';

import 'firebase_options.dart';
// import 'package:image_classification_app/pages/login.dart';
// import 'package:image_classification_app/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open the Hive box for storing photo paths
  await Hive.openBox<String>('photos');
  await Hive.openBox<bool>('uploaded_images');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  const Welcome(),
      },
    );
  }
}


