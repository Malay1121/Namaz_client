import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/responsive.dart';

import 'navbar.dart';

class AllMosque extends StatefulWidget {
  const AllMosque({Key? key}) : super(key: key);

  @override
  State<AllMosque> createState() => _AllMosqueState();
}

class _AllMosqueState extends State<AllMosque> {
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
                      'All Mosques',
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
                      height: responsiveHeight(11, context),
                    ),
                    MosqueCard(
                      image: 'masjid1.png',
                      masjidName: 'Jama Masjid',
                    ),
                    MosqueCard(
                      image: 'masjid2.png',
                      masjidName: 'Jamia Masjid',
                    ),
                    MosqueCard(
                      image: 'masjid3.png',
                      masjidName: 'Adina Mosque',
                    ),
                    MosqueCard(
                      image: 'masjid4.png',
                      masjidName: 'Atala Masjid',
                    ),
                    MosqueCard(
                      image: 'masjid5.png',
                      masjidName: 'Charminar',
                    ),
                    MosqueCard(
                      image: 'masjid1.png',
                      masjidName: 'Jama Masjid',
                    ),
                    MosqueCard(
                      image: 'masjid2.png',
                      masjidName: 'Jamia Masjid',
                    ),
                  ],
                ),
              ],
            ),
          ),
          NavBar(
            currentPage: 'Mosque',
          ),
        ],
      ),
    );
  }
}

class MosqueCard extends StatelessWidget {
  const MosqueCard({
    Key? key,
    required this.masjidName,
    required this.image,
  }) : super(key: key);

  final String masjidName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveHeight(11, context),
      ),
      child: BounceInRight(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      height: responsiveHeight(6, context),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/location.png',
                          width: responsiveText(7.5, context),
                          height: responsiveHeight(8.74, context),
                        ),
                        Text(
                          'Get Direction',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Color(0xFF77B255),
                              fontSize: responsiveText(10, context),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
