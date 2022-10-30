import 'package:flutter/material.dart';
import 'package:namaz_timing/qiblah_compass.dart';

class QuiblahScreen extends StatefulWidget {
  const QuiblahScreen({Key? key}) : super(key: key);

  @override
  State<QuiblahScreen> createState() => _QuiblahScreenState();
}

class _QuiblahScreenState extends State<QuiblahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QiblahCompass(),
    );
  }
}
