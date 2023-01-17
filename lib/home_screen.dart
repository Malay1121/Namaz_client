import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/namaz_timing.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:new_version/new_version.dart';
import 'package:time/time.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

dynamic _namaz_timing = {
  "list": [
    {
      "name": "Masjid-E-Amin",
      "img": "https://i.ibb.co/x7T8x0P/2019-06-04.jpg",
      "timing": {
        "isha": {"jammat_time": "2022-10-30T00:28:26.650000"}
      }
    },
    {
      "name": "Masjid-E-Noori",
      "img": "https://i.ibb.co/5x6MQN2/2022-09-06.jpg",
      "timing": {
        "isha": {"jammat_time": "2022-10-30T00:28:26.680000"}
      }
    },
    {
      "name": "Masjid-E-Bibima",
      "img": "https://i.ibb.co/mvYsmKN/2022-03-05.jpg",
      "timing": {
        "isha": {"jammat_time": "2022-10-30T00:28:26.680000"}
      }
    }
  ],
  "time": {
    "start": "2022-11-05T19:19:28.331000",
    "end": "2022-11-05T05:25:28.331000"
  }
};
bool _showSpiner = true;
List allList = [];
List list = [];
var _currentMasjid;
var _currentMasjidIndex = 0;
bool loop = true;

class _HomePageState extends State<HomePage> {
  Future getData() async {
    final response =
        await http.get(Uri.parse('https://api.namaz.co.in/currentnamaz'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        _namaz_timing = jsonDecode(response.body);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future getData() async {
        final response =
            await http.get(Uri.parse('https://api.namaz.co.in/currentnamaz'));

        if (response.statusCode != 200) {
          http
              .get(Uri.parse(
                  'https://api.telegram.org/bot5917352634:AAGQK_HUfAn9ViRZYpeLQX-H1IngSvkYdgU/sendMessage?chat_id=933725202&text="Error loaing message ${response.statusCode}"'))
              .then((value) {
            return showAboutDialog(
              context: context,
              children: [
                Text('Error loading Masjids, Please try again later!'),
                Container(
                  color: Color(0xFF77B255),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Error loading Masjids, Please try again later!'),
                  ),
                ),
              ],
            );
          });
        }

        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.

          setState(() {
            _namaz_timing = jsonDecode(response.body);
            _showSpiner = false;
          });
          var key = _namaz_timing['list'][0]['timing'].keys.toList();
          for (var namazType in _namaz_timing['list'].toList()) {
            var now = DateTime.now();

            var time = DateTime.parse(
                namazType['timing'][key.first.toString()]['jammat_time']);
            var namazTime = DateTime(
              now.year,
              now.month,
              now.day,
              time.hour,
              time.minute,
              time.second,
            );
            allList.add(namazTime);
            if (DateTime.now().isBefore(namazTime + 3.minutes) == true) {
              list.add(namazTime);
            }
            // print(list.toString() + 'asduyga');
          }

          setState(() {
            _currentMasjid = list.reduce((a, b) =>
                a.difference(DateTime.now() - 3.minutes).abs() <
                        b.difference(DateTime.now()).abs()
                    ? a
                    : b);
            _currentMasjidIndex = allList.indexOf(_currentMasjid);
          });
          // print(_currentMasjid.toString() + 'asd');
          var duration =
              (_currentMasjid.difference(DateTime.now())) + 3.minutes;
          // print(duration.toString() + 'asd');
          Future.delayed(duration, () {
            setState(() {
              loop = true;
            });
          });
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      }

      await getData();
      final newVersion = NewVersion(
        iOSId: 'com.google.Vespa',
        androidId: 'co.namaz.near.me',
      );
      const simpleBehavior = true;

      if (simpleBehavior) {
        basicStatusCheck(newVersion);
      } else {
        advancedStatusCheck(newVersion);
      }
    });
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var _key = _namaz_timing['list'][0]['timing'].keys;
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: ModalProgressHUD(
        opacity: 1,
        inAsyncCall: _showSpiner,
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
                          'Home',
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
                          SizedBox(
                            width: responsiveWidth(150, context),
                            child: AutoSizeText(
                              _namaz_timing['list'][_currentMasjidIndex]['name']
                                  .toString(),
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
                          SizedBox(
                            height: responsiveHeight(10, context),
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
                                  SizedBox(
                                    width: responsiveWidth(80, context),
                                    child: AutoSizeText(
                                      _namaz_timing['list'][0]['timing']
                                              .keys
                                              .first
                                              .toString() +
                                          ' Prayer',
                                      minFontSize: 5,
                                      maxLines: 1,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveText(10, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(150, context),
                                    child: AutoSizeText(
                                      TimeOfDay.fromDateTime(
                                        DateTime.parse(
                                          _namaz_timing['list']
                                                          [_currentMasjidIndex]
                                                      ['timing']
                                                  [_key.first.toString()]
                                              ['jammat_time'],
                                        ),
                                      ).format(context).toString(),
                                      minFontSize: 5,
                                      maxLines: 1,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Color(0xFF77B255),
                                          fontSize: responsiveText(24, context),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(150, context),
                                    child: AutoSizeText(
                                      'From ' +
                                          TimeOfDay.fromDateTime(
                                            DateTime.parse(
                                                _namaz_timing['time']['start']),
                                          ).format(context).toString() +
                                          '- ' +
                                          TimeOfDay.fromDateTime(
                                            DateTime.parse(
                                                _namaz_timing['time']['end']),
                                          ).format(context).toString(),
                                      minFontSize: 5,
                                      maxLines: 1,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Color(0xFFA3A3A3),
                                          fontSize: responsiveText(10, context),
                                        ),
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
              child: RefreshIndicator(
                onRefresh: getData,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        for (var namaz in _namaz_timing['list'])
                          NamazCard(
                            image: namaz['img'],
                            masjidName: namaz['name'],
                            timing: namaz['timing'],
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
                              throw 'Could not launch Whatsapp';
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
              currentPage: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}

class NamazCard extends StatelessWidget {
  const NamazCard({
    Key? key,
    required this.masjidName,
    required this.image,
    required this.timing,
  }) : super(key: key);

  final String masjidName;
  final String image;
  final Map timing;

  @override
  Widget build(BuildContext context) {
    dynamic key = timing.keys;
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
                  child: Image.network(
                    '$image',
                    width: responsiveWidth(62, context),
                    height: responsiveHeight(62, context),
                  ),
                ),
                SizedBox(
                  width: responsiveWidth(12, context),
                ),
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
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: AutoSizeText(
                        TimeOfDay.fromDateTime(
                          DateTime.parse(
                            timing[key.first.toString()]['jammat_time'],
                          ),
                        ).format(context).toString(),
                        minFontSize: 5,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveText(16, context),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(6, context),
                    ),
                    AutoSizeText(
                      key.first.toString(),
                      maxLines: 1,
                      minFontSize: 5,
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
