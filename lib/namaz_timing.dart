import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namaz_timing/responsive.dart';

import 'constants.dart';
import 'navbar.dart';

class NamazTimingScreen extends StatefulWidget {
  const NamazTimingScreen({Key? key}) : super(key: key);

  @override
  State<NamazTimingScreen> createState() => _NamazTimingScreenState();
}

class _NamazTimingScreenState extends State<NamazTimingScreen> {
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
              image: DecorationImage(
                image: AssetImage('assets/tab_design.png'),
                fit: BoxFit.fill,
              ),
              color: Color(0xFF77B255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: responsiveHeight(55, context),
                left: responsiveWidth(15, context),
                right: responsiveWidth(15, context),
                bottom: responsiveHeight(18, context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: responsiveText(30, context),
                    height: responsiveText(30, context),
                  ),
                  FadeInDown(
                    child: Text(
                      'Namaz Timing',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: responsiveText(18, context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/message.png',
                    width: responsiveText(26, context),
                    height: responsiveText(26, context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: responsiveHeight(20, context),
                    ),
                    Text(
                      'Know The Namaz Timing',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: responsiveText(16, context),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(20, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeInLeft(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 300)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                        FadeInRight(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 300)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeInLeft(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 600)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                        FadeInRight(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 600)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeInLeft(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 900)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                        FadeInRight(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 900)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeInLeft(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 1200)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                        FadeInRight(
                          preferences: AnimationPreferences(
                              offset: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 1200)),
                          child: NamazTimingCard(
                            name: 'Fajr',
                            time: '06:30 PM-06:30 PM',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          NavBar(
            currentPage: 'Timing',
          ),
        ],
      ),
    );
  }
}

class NamazTimingCard extends StatelessWidget {
  const NamazTimingCard({
    Key? key,
    required this.name,
    required this.time,
  }) : super(key: key);

  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveHeight(12, context),
      ),
      child: Container(
        width: responsiveWidth(165, context),
        height: responsiveHeight(145, context),
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              height: responsiveHeight(20, context),
            ),
            Image.asset(
              'assets/cloud.png',
              width: responsiveText(42, context),
              height: responsiveText(42, context),
            ),
            SizedBox(
              height: responsiveHeight(29, context),
            ),
            Text(
              name,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: Color(0xFFDADADA),
                  fontSize: responsiveText(16, context),
                ),
              ),
            ),
            SizedBox(
              height: responsiveHeight(3, context),
            ),
            Text(
              time,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: responsiveText(16, context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
