import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/flippers/flip_in_y.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/all_mosque.dart';
import 'package:namaz_timing/namaz_timing.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';
import 'package:time/time.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'constants.dart';

class SingleMosqueScreen extends StatefulWidget {
  const SingleMosqueScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<SingleMosqueScreen> createState() => _SingleMosqueScreenState();
}

dynamic _mosqueData = {
  "name": "Masjid",
  "map_link": "https://goo.gl/maps/4Pp38sqWWGcJXs8h6",
  "img":
      "https://t3.ftcdn.net/jpg/04/40/04/56/360_F_440045623_BF4jzAxuOyYkDo04JJK0x9Fd0onYL3mN.jpg",
  "background_img": "https://i.ibb.co/x7T8x0P/2019-06-04.jpg",
  "city": "surat",
  "area": "adajan patiya",
  "timing": {
    "fajr": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    },
    "jumma": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    },
    "zohr": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    },
    "asr": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    },
    "magrib": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    },
    "isha": {
      "azan_time": "2022-10-30T00:28:26.650000",
      "jammat_time": "2022-10-30T00:28:26.650000"
    }
  }
};
bool _showSpinner = true;

var _currentNamaz;
var _currentNamazName;

dynamic getTime = {
  "name": "fajr",
  "start": "2022-11-05T05:26:28.331000",
  "end": "2022-11-05T06:40:28.331000",
  "city": "surat"
};

class _SingleMosqueScreenState extends State<SingleMosqueScreen> {
  Future<void> getData() async {
    var response = await http
        .get(Uri.parse('https://api.namaz.co.in/getMasjid/${widget.id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        _mosqueData = jsonDecode(response.body);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load namaz');
    }
  }

  List _list = [];
  List _key = [];
  List _allList = [];

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData() async {
        var response = await http
            .get(Uri.parse('https://api.namaz.co.in/getMasjid/${widget.id}'));

        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          setState(() {
            _mosqueData = jsonDecode(response.body);
            _showSpinner = false;
          });
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load namaz');
        }
      }

      await getData();
      for (var namazType in _mosqueData['timing'].keys.toList()) {
        var now = DateTime.now();

        var time = DateTime.parse(
            _mosqueData['timing'][namazType.toString()]['jammat_time']);
        var namazTime = DateTime(
          now.year,
          now.month,
          namazType.toString() == 'fajr'
              ? now.isBefore(DateTime(now.year, now.month, now.day, 12)) == true
                  ? now.day
                  : now.day + 1
              : now.day,
          time.hour,
          time.minute,
          time.second,
        );
        _allList.add(namazTime);
        if (DateTime.now().isBefore(namazTime + 3.minutes) == true) {
          _list.add(namazTime);
        }
        print(_list.toString() + 'asduyga');
        _key.add(namazType);
      }

      setState(() {
        _currentNamaz = _list.reduce((a, b) =>
            a.difference(DateTime.now()).abs() <
                    b.difference(DateTime.now()).abs()
                ? a
                : b);
        _currentNamazName = _key[_allList.indexOf(_currentNamaz)];
      });
      var response = await http.get(Uri.parse(
          'https://api.namaz.co.in/namaz/${_currentNamazName.toString()}'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        setState(() {
          getTime = jsonDecode(response.body);
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load namaz');
      }
    });
    // print('https://api.namaz.co.in/namaz/${_currentNamazName.toString()}' +
    //     'asdaf');
  }

  @override
  Widget build(BuildContext context) {
    var _mosqueKeys = _mosqueData['timing'].keys;

    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: responsiveHeight(338, context),
                    ),
                    Container(
                      height: responsiveHeight(278, context),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            _mosqueData['background_img'].toString(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: FlipInY(
                        preferences: AnimationPreferences(
                          offset: Duration(seconds: 1),
                        ),
                        child: Container(
                          width: responsiveWidth(308, context),
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
                                        _mosqueData['name'].toString(),
                                        minFontSize: 5,
                                        maxLines: 1,
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                responsiveText(16, context),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  responsiveWidth(100, context),
                                              child: AutoSizeText(
                                                _currentNamazName.toString(),
                                                minFontSize: 5,
                                                maxLines: 1,
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: responsiveText(
                                                        10, context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  responsiveWidth(130, context),
                                              child: AutoSizeText(
                                                TimeOfDay.fromDateTime(
                                                  DateTime.parse(_mosqueData[
                                                                  'timing'][
                                                              _currentNamazName
                                                                  .toString()]
                                                          ['jammat_time']
                                                      .toString()),
                                                ).format(context).toString(),
                                                minFontSize: 5,
                                                maxLines: 1,
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                    color: Color(0xFF77B255),
                                                    fontSize: responsiveText(
                                                        24, context),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  responsiveWidth(130, context),
                                              child: AutoSizeText(
                                                TimeOfDay.fromDateTime(
                                                      DateTime.parse(
                                                          getTime['start']
                                                              .toString()),
                                                    )
                                                        .format(context)
                                                        .toString() +
                                                    ' - ' +
                                                    TimeOfDay.fromDateTime(
                                                      DateTime.parse(
                                                          getTime['end']
                                                              .toString()),
                                                    )
                                                        .format(context)
                                                        .toString(),
                                                minFontSize: 5,
                                                maxLines: 1,
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                    color: Color(0xFFA3A3A3),
                                                    fontSize: responsiveText(
                                                        10, context),
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
                                  width: responsiveWidth(12, context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: responsiveHeight(55, context),
                      left: responsiveWidth(16, context),
                      right: responsiveWidth(16, context),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllMosque()));
                            },
                            child: Image.asset(
                              'assets/back.png',
                              height: responsiveText(30, context),
                              width: responsiveText(30, context),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrlString(
                                  _mosqueData['map_link'])) {
                                await launchUrlString(
                                  _mosqueData['map_link'],
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                throw 'Could not launch ${_mosqueData['map_link']}';
                              }
                            },
                            child: Container(
                              width: responsiveWidth(87, context),
                              height: responsiveHeight(30, context),
                              decoration: BoxDecoration(
                                color: Color(0xFF2D2D30),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/location.png',
                                    height: responsiveText(10, context),
                                    width: responsiveText(10, context),
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(50, context),
                                    child: AutoSizeText(
                                      'Get Direction',
                                      maxLines: 1,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Color(0xFF77B255),
                                          fontSize: responsiveText(8, context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(20, context),
                ),
                for (var key in _mosqueKeys)
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: responsiveHeight(10, context)),
                    child: Container(
                      width: responsiveWidth(343, context),
                      height: responsiveHeight(62, context),
                      decoration: BoxDecoration(
                        color: Color(0xFF2D2D30),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: responsiveWidth(16, context),
                          ),
                          Image.asset(
                            'assets/praying-man.png',
                            height: responsiveText(24, context),
                            width: responsiveText(24, context),
                          ),
                          SizedBox(
                            width: responsiveWidth(15, context),
                          ),
                          SizedBox(
                            width: responsiveWidth(100, context),
                            child: AutoSizeText(
                              key,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Color(0xFFDADADA),
                                  fontSize: responsiveText(16, context),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                'Azan Time - ${TimeOfDay.fromDateTime(DateTime.parse(_mosqueData['timing'][key]['azan_time'])).format(context)}',
                                maxLines: 1,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Color(0xFFDADADA),
                                    fontSize: responsiveText(12, context),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(4, context),
                              ),
                              AutoSizeText(
                                'Jammat Time - ${TimeOfDay.fromDateTime(DateTime.parse(_mosqueData['timing'][key]['jammat_time'])).format(context)}',
                                maxLines: 1,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Color(0xFFDADADA),
                                    fontSize: responsiveText(12, context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: responsiveWidth(16, context),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
