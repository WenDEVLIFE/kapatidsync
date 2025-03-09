import 'package:firebase_core/firebase_core.dart';

class FirebaseServices {
  static const String adminEmail ='SystemAdmin@gmail.com';
  static const String adminPassword = '@WenDEVLIFE123';
  static Future<void> runFirebase() async {
    // Add your code here
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: '1:320080664161:android:800f0ae38140db8ccabc20',
        apiKey: 'AIzaSyCqLvro3Syjzcf5zA1XwE4ZpcaAI-5WF8g',
        projectId: 'kapatidsyncdb',
        messagingSenderId: '320080664161',
        storageBucket: 'kapatidsyncdb.firebasestorage.app'
      ),
    );

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          appId: '1:320080664161:android:800f0ae38140db8ccabc20',
          apiKey: 'AIzaSyCqLvro3Syjzcf5zA1XwE4ZpcaAI-5WF8g',
          projectId: 'kapatidsyncdb',
          messagingSenderId: '320080664161',
          storageBucket: 'kapatidsyncdb.firebasestorage.app'
        ),
      );
    }

    else{
      print('Firebase already running');
    }
  }
}