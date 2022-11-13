import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:namaz_timing/home_screen.dart';
import 'package:namaz_timing/login.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

void main() => runApp(new MyApp());

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
        navigator: MainScreen(),
        durationInSeconds: 5,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Center(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/compass.png',
                          height: responsiveText(275, context),
                          width: responsiveText(275, context),
                        ),
                        SizedBox(
                          height: responsiveText(275, context),
                          width: responsiveText(275, context),
                          child: SmoothCompass(
                            rotationSpeed: 200,
                            height: responsiveText(200, context),
                            width: responsiveText(200, context),
                            compassAsset: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/needle.png"),
                                ),
                              ),
                            ),
                            compassBuilder: (context,
                                AsyncSnapshot<CompassModel>? compassData,
                                Widget compassAsset) {
                              return compassAsset;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
          child: Text('Compass'),
        ),
        GestureDetector(
          child: Text(
            'Admin Login',
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        GestureDetector(
          child: Text(
            'Go to normal app',
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    );
  }
}
