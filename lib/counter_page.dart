import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/main.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:namaz_timing/single_mosque_screen.dart';
import 'package:step_circle_progressbar/step_circle_progressbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'navbar.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key? key, this.counterId = ''}) : super(key: key);
  String counterId;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

var count;

class _CounterPageState extends State<CounterPage> {
  var counter;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        counter = getStorage.read(widget.counterId);

        _nameController =
            TextEditingController(text: counter == null ? '' : counter['name']);
        print(getStorage.read(widget.counterId).toString() + 'asf');
        count = counter['count'];
      });

      print(count + 'asf');
    });

    super.initState();
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: responsiveHeight(25, context),
                    ),
                  ),
                  FadeInDown(
                    child: Center(
                      child: AutoSizeText(
                        'Counter',
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
                  Icon(
                    Icons.event,
                    color: Colors.white,
                    size: responsiveHeight(25, context),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: responsiveHeight(26, context),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: responsiveWidth(16, context),
                    right: responsiveWidth(16, context),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsiveHeight(147, context),
                        width: responsiveWidth(147, context),
                        child: CircleProgressBar(
                          foregroundColor: Color(0xFF77B255),
                          backgroundColor: Color(0xFFFB7A24),
                          value: getStorage.read(widget.counterId) == null
                              ? 0
                              : getStorage.read(widget.counterId)['count'] /
                                  100,
                          animationDuration: Duration(seconds: 1),
                          strokeWidth: responsiveText(14, context),
                          child: Center(
                            child: AnimatedCount(
                              style: TextStyle(
                                color: Color(0xFFFB7A24),
                                fontFamily: inter,
                                fontWeight: FontWeight.w500,
                                fontSize: responsiveText(50, context),
                              ),
                              count: getStorage.read(widget.counterId) == null
                                  ? 0.0
                                  : double.parse(getStorage
                                      .read(widget.counterId)['count']
                                      .toString()),
                              fractionDigits: 0,
                              unit: '',
                              duration: Duration(milliseconds: 500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(11, context),
                      ),
                      SizedBox(
                        width: responsiveWidth(149, context),
                        height: responsiveHeight(39, context),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  getStorage.write(widget.counterId, {
                                    'name': _nameController.text,
                                    'count': count - 1,
                                    'tag': widget.counterId
                                  });
                                });
                              },
                              child: Container(
                                width: responsiveWidth(47, context),
                                height: responsiveHeight(39, context),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFB7A24),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: responsiveText(24, context),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  getStorage.write(widget.counterId, {
                                    'name': _nameController.text,
                                    'count': count + 1,
                                    'tag': widget.counterId
                                  });
                                });
                                print(getStorage.read(widget.counterId));
                              },
                              child: Container(
                                width: responsiveWidth(47, context),
                                height: responsiveHeight(39, context),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFB7A24),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: responsiveText(24, context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(12, context),
                      ),
                      Text(
                        'What are you reciting',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: inter,
                          fontWeight: FontWeight.w500,
                          fontSize: responsiveText(18, context),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(11, context),
                      ),
                      Container(
                        width: responsiveWidth(343, context),
                        decoration: BoxDecoration(
                          color: Color(0xFF2D2D30),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(offset: Offset(0, 4), blurRadius: 40)
                          ],
                        ),
                        child: TextField(
                          controller: _nameController,
                          maxLines: null,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: inter,
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveText(16, context),
                          ),
                          decoration: InputDecoration(
                            hintMaxLines: 2,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: inter,
                              fontWeight: FontWeight.w600,
                              fontSize: responsiveText(16, context),
                            ),
                            hintText:
                                'Reciting Daroof Shareef on jummah for 100 times',
                          ),
                          onChanged: ((value) {
                            setState(() {
                              getStorage.write(widget.counterId, {
                                'name': value,
                                'count': count,
                                'tag': widget.counterId
                              });
                            });
                            print(getStorage.read(widget.counterId));
                          }),
                        ),
                      ),
                    ],
                  ),
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
