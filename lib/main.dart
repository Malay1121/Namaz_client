import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:namaz_timing/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: EasySplashScreen(
        backgroundImage: AssetImage('assets/splash.png'),
        logo: Image.asset(
          'assets/splash.png',
          width: 0,
          height: 0,
        ),
        backgroundColor: Colors.grey.shade400,
        showLoader: true,
        loaderColor: Color(0xFF54AEB4),
        navigator: HomePage(),
        durationInSeconds: 5,
      ),
    );
  }
}
