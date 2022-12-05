import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namaz_timing/namaz_timing.dart';
import 'package:namaz_timing/responsive.dart';

import 'all_mosque.dart';
import 'home_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  final currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: responsiveHeight(80, context),
      decoration: BoxDecoration(
        color: Color(0xFF111119),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(
          color: Color(0xFF272738),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (currentPage != 'Home') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentPage == 'Home'
                      ? 'assets/home_enabled.png'
                      : 'assets/home_disabled.png',
                  width: responsiveText(16.5, context),
                  height: responsiveText(16.5, context),
                ),
                SizedBox(
                  height: responsiveHeight(6.2, context),
                ),
                AutoSizeText(
                  'Home',
                  minFontSize: 5,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: currentPage == 'Home'
                          ? Color(0xFFFB7A24)
                          : Colors.white,
                      fontSize: responsiveText(10, context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentPage != 'Mosque') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AllMosque()));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentPage == 'Mosque'
                      ? 'assets/mosque_enabled.png'
                      : 'assets/mosque_disabled.png',
                  width: responsiveText(16.5, context),
                  height: responsiveText(16.5, context),
                ),
                SizedBox(
                  height: responsiveHeight(6.2, context),
                ),
                AutoSizeText(
                  'All Mosque',
                  minFontSize: 5,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: currentPage == 'Mosque'
                          ? Color(0xFFFB7A24)
                          : Colors.white,
                      fontSize: responsiveText(10, context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentPage != 'Timing') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NamazTimingScreen()));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentPage == 'Timing'
                      ? 'assets/timing_enabled.png'
                      : 'assets/timing_disabled.png',
                  width: responsiveText(16.5, context),
                  height: responsiveText(16.5, context),
                ),
                SizedBox(
                  height: responsiveHeight(6.2, context),
                ),
                AutoSizeText(
                  'Timings',
                  minFontSize: 5,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: currentPage == 'Timing'
                          ? Color(0xFFFB7A24)
                          : Colors.white,
                      fontSize: responsiveText(10, context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
