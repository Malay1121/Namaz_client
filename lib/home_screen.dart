import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/responsive.dart';

import 'navbar.dart';

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
                      'Home',
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
          SizedBox(
            height: responsiveHeight(11, context),
          ),
          FlipInY(
            preferences: AnimationPreferences(
              offset: Duration(seconds: 1),
            ),
            child: Container(
              width: responsiveWidth(338, context),
              height: responsiveHeight(129, context),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: responsiveWidth(25, context),
                  top: responsiveHeight(18, context),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jama Masjid',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveText(16, context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsiveHeight(14, context),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Color(0xFF77B255),
                              size: responsiveText(64, context),
                            ),
                            SizedBox(
                              width: responsiveWidth(15, context),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dhuhr Prayer ',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(10, context),
                                    ),
                                  ),
                                ),
                                Text(
                                  '12:30 PM',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Color(0xFF77B255),
                                      fontSize: responsiveText(24, context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'From 1:30 PM  - 3:35 PM',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: responsiveText(10, context),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/castle.png',
                      width: responsiveWidth(52, context),
                      height: responsiveHeight(104, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(26, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: responsiveHeight(11, context),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    NamazCard(
                      image: 'masjid1.png',
                      masjidName: 'Jama Masjid',
                      time: '12:30 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid2.png',
                      masjidName: 'Jamia Masjid',
                      time: '12:45 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid3.png',
                      masjidName: 'Adina Mosque',
                      time: '01:00 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid4.png',
                      masjidName: 'Atala Masjid',
                      time: '01:15 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid5.png',
                      masjidName: 'Charminar',
                      time: '01:30 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid1.png',
                      masjidName: 'Jama Masjid',
                      time: '1:45 PM',
                      namaz: 'Dhuhr',
                    ),
                    NamazCard(
                      image: 'masjid2.png',
                      masjidName: 'Jamia Masjid',
                      time: '02:00 PM',
                      namaz: 'Dhuhr',
                    ),
                  ],
                ),
              ],
            ),
          ),
          NavBar(
            currentPage: 'Home',
          ),
        ],
      ),
    );
  }
}

class NamazCard extends StatelessWidget {
  const NamazCard({
    Key? key,
    required this.masjidName,
    required this.image,
    required this.time,
    required this.namaz,
  }) : super(key: key);

  final String masjidName;
  final String image;
  final String time;
  final String namaz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveHeight(11, context),
      ),
      child: FadeInLeft(
        child: Container(
          width: responsiveWidth(343, context),
          height: responsiveHeight(92, context),
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(10, context),
              top: responsiveHeight(15, context),
              bottom: responsiveHeight(15, context),
              right: responsiveWidth(10, context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/$image',
                    width: responsiveWidth(62, context),
                    height: responsiveHeight(62, context),
                  ),
                ),
                SizedBox(
                  width: responsiveWidth(12, context),
                ),
                Text(
                  masjidName,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: responsiveText(16, context),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: responsiveText(16, context),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(6, context),
                    ),
                    Text(
                      namaz,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Color(0xFFA3A3A3),
                          fontSize: responsiveText(10, context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
