import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/ViewModel/LoginViewModel.dart';
import 'package:kapatidsync/src/ViewModel/MenuViewModel.dart';
import 'package:kapatidsync/src/ViewModel/SplashViewModel.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/Route.dart';
import 'package:kapatidsync/src/services/FirebaseService.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseServices.runFirebase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => MenuViewModel()),
        ChangeNotifierProvider(create: (context) => KidViewModel()),
      ],
      child: MaterialApp(
        key: GlobalKey(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteUtil.splashScreen,
        routes: RouteUtil.routes,
      )
    );
  }
}
