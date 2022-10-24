import 'package:flutter/material.dart';
import 'package:namaz_timing/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Column(
        children: [
          Container(
            height: responsiveHeight(100, context),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF77B255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: responsiveHeight(55, context),
                  left: responsiveWidth(15, context)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: responsiveText(30, context),
                    height: responsiveText(30, context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
