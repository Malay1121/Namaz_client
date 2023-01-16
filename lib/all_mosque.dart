import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/main.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:namaz_timing/single_mosque_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'navbar.dart';

class AllMosque extends StatefulWidget {
  const AllMosque({Key? key}) : super(key: key);

  @override
  State<AllMosque> createState() => _AllMosqueState();
}

var pinnedMasjid = {};
bool _showSpinner = true;
dynamic _allMosque = {"Masjids": []};

class _AllMosqueState extends State<AllMosque> {
  Future<void> getData() async {
    var response =
        await http.get(Uri.parse('https://api.namaz.co.in/getMasjids'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        _allMosque = jsonDecode(response.body);
        _allMosque['Masjids'].remove(getStorage.read('pinnedMasjid'));
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load namaz');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData() async {
        var response =
            await http.get(Uri.parse('https://api.namaz.co.in/getMasjids'));

        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          setState(() {
            _allMosque = jsonDecode(response.body);
            _showSpinner = false;
            _allMosque['Masjids'].remove(getStorage.read('pinnedMasjid'));
          });
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load namaz');
        }
      }

      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
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
                      child: Center(
                        child: AutoSizeText(
                          'All Mosques',
                          minFontSize: 5,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveText(18, context),
                              fontWeight: FontWeight.w500,
                            ),
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
              child: RefreshIndicator(
                onRefresh: () => getData(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: responsiveHeight(11, context),
                        ),
                        // MosqueCard(
                        //   image: _allMosque['Masjids'][_allMosque['Masjids']
                        //       .indexOf(
                        //           getStorage.read('pinnedMasjid'))]!['img'],
                        //   masjidName: _allMosque['Masjids'][
                        //       _allMosque['Masjids'].indexOf(
                        //           getStorage.read('pinnedMasjid'))]!['name'],
                        //   directions: _allMosque['Masjids'][
                        //       _allMosque['Masjids'].indexOf(getStorage
                        //           .read('pinnedMasjid'))]!['map_link'],
                        //   id: _allMosque['Masjids'][_allMosque['Masjids']
                        //       .indexOf(
                        //           getStorage.read('pinnedMasjid'))]!['_id'],
                        // ),
                        getStorage.read('pinnedMasjid') != null
                            ? MosqueCard(
                                image: getStorage
                                    .read('pinnedMasjid')['img']
                                    .toString(),
                                masjidName: getStorage
                                    .read('pinnedMasjid')['name']
                                    .toString(),
                                directions: getStorage
                                    .read('pinnedMasjid')['map_link']
                                    .toString(),
                                id: getStorage
                                    .read('pinnedMasjid')['_id']
                                    .toString(),
                              )
                            : SizedBox(),
                        for (var mosque in _allMosque['Masjids']!)
                          MosqueCard(
                            image: mosque['img'],
                            masjidName: mosque['name'],
                            directions: mosque['map_link'],
                            id: mosque['_id'],
                          ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunchUrlString(
                                'https://api.whatsapp.com/send?phone=918200440994&text=Helllo%20I%20would%20like%20to%20add%20my%20masjid')) {
                              await launchUrlString(
                                'https://api.whatsapp.com/send?phone=918200440994&text=Helllo%20I%20would%20like%20to%20add%20my%20masjid',
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("An Error Occured")));
                              ;
                            }
                          },
                          child: SizedBox(
                            width: responsiveWidth(150, context),
                            child: AutoSizeText(
                              'Unable to find your masjid ?',
                              minFontSize: 5,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsiveText(16, context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            NavBar(
              currentPage: 'Mosque',
            ),
          ],
        ),
      ),
    );
  }
}

class MosqueCard extends StatelessWidget {
  const MosqueCard(
      {Key? key,
      required this.masjidName,
      required this.image,
      required this.directions,
      required this.id})
      : super(key: key);

  final String masjidName;
  final String image;
  final String directions;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveHeight(11, context),
      ),
      child: BounceInRight(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleMosqueScreen(id: id)));
          },
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
                    child: Image.network(
                      image,
                      width: responsiveWidth(62, context),
                      height: responsiveHeight(62, context),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: responsiveWidth(12, context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: responsiveWidth(150, context),
                        child: AutoSizeText(
                          masjidName,
                          minFontSize: 5,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: responsiveText(16, context),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(6, context),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunchUrlString(directions)) {
                            await launchUrlString(directions,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $directions';
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/location.png',
                              width: responsiveText(7.5, context),
                              height: responsiveHeight(8.74, context),
                            ),
                            SizedBox(
                              width: responsiveWidth(100, context),
                              child: AutoSizeText(
                                'Get Direction',
                                minFontSize: 5,
                                maxLines: 1,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Color(0xFF77B255),
                                    fontSize: responsiveText(10, context),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
