import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:namaz_timing/responsive.dart';

class MasjidTimingChangeScreen extends StatefulWidget {
  const MasjidTimingChangeScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  State<MasjidTimingChangeScreen> createState() =>
      _MasjidTimingChangeScreenState();
}

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
                      TimeWidget(
                        title: 'Azan Time',
                        time: TimeOfDay.now(),
                      ),
                      SizedBox(
                        height: responsiveHeight(20, context),
                      ),
                      TimeWidget(
                        title: 'Jammats Time',
                        time: TimeOfDay.fromDateTime(DateTime.now()),
                      ),
                      SizedBox(
                        height: responsiveHeight(67, context),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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

class TimeWidget extends StatefulWidget {
  TimeWidget({
    Key? key,
    required this.title,
    required this.time,
  }) : super(key: key);
  final String title;
  TimeOfDay time;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Widget build(BuildContext context) {
    void onTimeChanged(TimeOfDay newTime) {
      setState(() {
        widget.time = newTime;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
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
                value: widget.time,
                onChange: onTimeChanged,
              ),
            );

            var df = DateFormat("h:mma");
            var dt = df.parse(widget.time.format(context).replaceAll(' ', ''));

            print(DateTime(2022, 11, 1, dt.hour, dt.minute));
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
                    widget.time.format(context),
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
      ],
    );
  }
}
