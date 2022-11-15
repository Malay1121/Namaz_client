import 'dart:convert';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:namaz_timing/admin.dart';
import 'package:namaz_timing/masjid_admin.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasjidTimingChangeScreen extends StatefulWidget {
  MasjidTimingChangeScreen({
    Key? key,
    required this.name,
    this.uveshAdmin = false,
    required this.time1,
    required this.time2,
    this.masjidId = '',
  }) : super(key: key);

  final String name;
  TimeOfDay time1;
  TimeOfDay time2;
  final bool uveshAdmin;
  String masjidId;

  @override
  State<MasjidTimingChangeScreen> createState() =>
      _MasjidTimingChangeScreenState();
}

var final2;
var final1;

class _MasjidTimingChangeScreenState extends State<MasjidTimingChangeScreen> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RollIn(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: responsiveText(20, context),
                      ),
                    ),
                  ),
                  Spacer(),
                  FadeInDown(
                    child: Text(
                      widget.name,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: responsiveText(18, context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: responsiveWidth(16, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: responsiveHeight(20, context),
                      ),
                      Center(
                        child: Text(
                          'Update ${widget.name} Timing',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: responsiveText(16, context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(40, context),
                      ),
                      Text(
                        widget.uveshAdmin == true ? 'From' : 'Azan Time',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: Color(0xFFDADADA),
                                fontSize: responsiveText(12, context))),
                      ),
                      SizedBox(
                        height: responsiveHeight(12, context),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: widget.time1,
                              onChange: (val) {
                                setState(() {
                                  widget.time1 = val;
                                });
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: responsiveWidth(342, context),
                          height: responsiveHeight(56, context),
                          decoration: BoxDecoration(
                            color: Color(0xFF2D2D30),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 40,
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: responsiveWidth(19, context),
                                ),
                                child: Text(
                                  widget.time1.format(context),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(16, context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(20, context),
                      ),
                      Text(
                        widget.uveshAdmin == true ? 'To' : 'Jammat Time',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: Color(0xFFDADADA),
                                fontSize: responsiveText(12, context))),
                      ),
                      SizedBox(
                        height: responsiveHeight(12, context),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: widget.time2,
                              onChange: (val) {
                                widget.time2 = val;
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: responsiveWidth(342, context),
                          height: responsiveHeight(56, context),
                          decoration: BoxDecoration(
                            color: Color(0xFF2D2D30),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 40,
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: responsiveWidth(19, context),
                                ),
                                child: Text(
                                  widget.time2.format(context),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(16, context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(67, context),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            var df1 = DateFormat("h:mma");
                            var dt1 = df1.parse(widget.time1
                                .format(context)
                                .replaceAll(' ', ''));
                            final1 =
                                DateTime(2022, 11, 1, dt1.hour, dt1.minute);
                            var df2 = DateFormat("h:mma");
                            var dt2 = df2.parse(widget.time2
                                .format(context)
                                .replaceAll(' ', ''));

                            setState(() {
                              final2 =
                                  DateTime(2022, 11, 1, dt2.hour, dt2.minute);
                            });
                          });
                          SharedPreferences preference =
                              await SharedPreferences.getInstance();
                          widget.uveshAdmin == true
                              ? await http.post(
                                  Uri.parse(
                                      'https://api.namaz.co.in/updateNamazTime'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                    'x-api-key':
                                        preference.getString('_id').toString(),
                                  },
                                  body: jsonEncode({
                                    "name": widget.name.toLowerCase(),
                                    "start": final1.toString() == 'null'
                                        ? widget.time1
                                        : final1.toString(),
                                    "end": final2.toString() == 'null'
                                        ? widget.time2
                                        : final2.toString(),
                                  }))
                              : http.put(
                                  Uri.parse(
                                      'https://api.namaz.co.in/updateMasjidNamazTime/${preference.getString('masjidId')}/${widget.name.toLowerCase()}'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                    'x-api-key':
                                        preference.getString('_id').toString(),
                                  },
                                  body: jsonEncode({
                                    "azan_time": final1.toString() == 'null'
                                        ? widget.time1
                                        : final1.toString(),
                                    "jammat_time": final2.toString() == 'null'
                                        ? widget.time2
                                        : final2.toString(),
                                  }),
                                );
                          ;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      widget.uveshAdmin == true
                                          ? AdminScreen()
                                          : MasjidTimingScreen()));
                        },
                        child: Container(
                          height: responsiveHeight(56, context),
                          width: responsiveWidth(342, context),
                          decoration: BoxDecoration(
                            color: Color(0xFFFB7A24),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Update',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsiveText(16, context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
