import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/AttendanceViewModel.dart';
import 'package:kapatidsync/src/ViewModel/ChangePasswordViewModel.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/ViewModel/LoginViewModel.dart';
import 'package:kapatidsync/src/ViewModel/MenuViewModel.dart';
import 'package:kapatidsync/src/ViewModel/SplashViewModel.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/Route.dart';
import 'package:kapatidsync/src/services/FirebaseService.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseServices.runFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => MenuViewModel()),
        ChangeNotifierProvider(create: (context) => KidViewModel()),
        ChangeNotifierProvider(create: (context) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (context) => ChangePasswordViewModel()),
      ],
      child: MaterialApp(
        key: GlobalKey(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteUtil.splashScreen,
        routes: RouteUtil.routes,
      ),
    );
  }
}