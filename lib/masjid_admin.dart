import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/main.dart';
import 'package:namaz_timing/masjid_time_change.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class MasjidTimingScreen extends StatefulWidget {
  const MasjidTimingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MasjidTimingScreen> createState() => _MasjidTimingScreenState();
}

dynamic _namaz_timing;
bool _showSpinner = true;

class _MasjidTimingScreenState extends State<MasjidTimingScreen> {
  Future<void> getData() async {
    var preference = await SharedPreferences.getInstance();
    var response = await http.get(
      Uri.parse(
          'https://api.namaz.co.in/getMasjid/${preference!.getString('masjidId')}'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        _namaz_timing = jsonDecode(response.body);
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
        var preference = await SharedPreferences.getInstance();
        var response = await http.get(Uri.parse(
            'https://api.namaz.co.in/getMasjid/${preference.getString('masjidId')}'));

        if (response.statusCode == 200) {
          // If the serve
          //  r did return a 200 OK response,
          // then parse the JSON.
          setState(() {
            _namaz_timing = jsonDecode(response.body);
            _showSpinner = false;
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
    var namazKeys = _namaz_timing['timing'].keys;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Text(
                        _namaz_timing['name'].toString(),
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: responsiveText(18, context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
                          height: responsiveHeight(20, context),
                        ),
                        Text(
                          'Update Masjid Namaz Timing',
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
                        GridView.count(
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: responsiveWidth(16.5, context),
                            right: responsiveWidth(16.5, context),
                          ),
                          crossAxisSpacing: responsiveWidth(12, context),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: [
                            for (var namaz in namazKeys)
                              MasjidNamazTimingCardAdmin(
                                start: TimeOfDay.fromDateTime(
                                  DateTime.parse(
                                    _namaz_timing['timing'][namaz]["azan_time"],
                                  ),
                                ),
                                end: TimeOfDay.fromDateTime(
                                  DateTime.parse(
                                    _namaz_timing['timing'][namaz]
                                        ["jammat_time"],
                                  ),
                                ),
                                name: namaz.toString().toUpperCase(),
                                time: TimeOfDay.fromDateTime(
                                      DateTime.parse(
                                        _namaz_timing!['timing'][namaz]
                                            ["azan_time"],
                                      ),
                                    ).format(context).toString() +
                                    ' - ' +
                                    TimeOfDay.fromDateTime(
                                      DateTime.parse(
                                        _namaz_timing!['timing'][namaz]
                                            ["jammat_time"],
                                      ),
                                    ).format(context).toString(),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MasjidNamazTimingCardAdmin extends StatelessWidget {
  MasjidNamazTimingCardAdmin({
    Key? key,
    required this.name,
    required this.time,
    required this.start,
    required this.end,
  }) : super(key: key);

  final String name;
  TimeOfDay start;
  TimeOfDay end;
  String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: responsiveHeight(12, context),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MasjidTimingChangeScreen(
                        name: name,
                        time1: start,
                        time2: end,
                      )));
        },
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
      ),
    );
  }
}
