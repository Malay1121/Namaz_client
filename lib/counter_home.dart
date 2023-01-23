import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/constants.dart';
import 'package:namaz_timing/counter_page.dart';
import 'package:namaz_timing/main.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:namaz_timing/single_mosque_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'navbar.dart';

class CounterHome extends StatefulWidget {
  const CounterHome({Key? key}) : super(key: key);

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

List masjidList = [];
dynamic _allMosque = {"Masjids": []};

class _CounterHomeState extends State<CounterHome> {
  // Future<void> getData() async {
  //   var response =
  //       await http.get(Uri.parse('https://api.namaz.co.in/getMasjids'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     setState(() {
  //       _allMosque = jsonDecode(response.body);
  //       masjidList = _allMosque['Masjids'];
  //       getStorage.read('pinnedMasjid') != null
  //           ? masjidList.removeWhere((element) =>
  //               element['_id'] == getStorage.read('pinnedMasjid')['_id'])
  //           : null;
  //     });
  //     print(getStorage.read('pinnedMasjid'));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load namaz');
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     getData() async {
  //       var response =
  //           await http.get(Uri.parse('https://api.namaz.co.in/getMasjids'));

  //       if (response.statusCode == 200) {
  //         // If the server did return a 200 OK response,
  //         // then parse the JSON.
  //         setState(() {
  //           _allMosque = jsonDecode(response.body);
  //           _showSpinner = false;
  //           masjidList = _allMosque['Masjids'];
  //           getStorage.read('pinnedMasjid') != null
  //               ? masjidList.removeWhere((element) =>
  //                   element['_id'] == getStorage.read('pinnedMasjid')['_id'])
  //               : null;
  //         });
  //         print(masjidList);
  //         print(getStorage.read('pinnedMasjid'));
  //       } else {
  //         // If the server did not return a 200 OK response,
  //         // then throw an exception.
  //         throw Exception('Failed to load namaz');
  //       }
  //     }

  //     await getData();
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
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
                      for (var counter in getStorage.read('counters') == null
                          ? []
                          : getStorage.read('counters'))
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CounterPage(
                                          counterId: counter,
                                        ))).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: responsiveHeight(92, context),
                            width: responsiveWidth(343, context),
                            decoration: BoxDecoration(
                              color: Color(0xFF2D2D30),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(offset: Offset(0, 4), blurRadius: 40)
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: responsiveWidth(10, context),
                                ),
                                CircleAvatar(
                                  radius: responsiveText(31, context),
                                  backgroundColor: Color(0xFF77B255),
                                  child: Text(
                                    getStorage
                                        .read(counter)['count']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: inter,
                                      fontWeight: FontWeight.w500,
                                      fontSize: responsiveText(26, context),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: responsiveWidth(12, context),
                                ),
                                SizedBox(
                                  width: responsiveWidth(246, context),
                                  child: AutoSizeText(
                                    getStorage.read(counter)['name'].toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: inter,
                                      fontWeight: FontWeight.w600,
                                      fontSize: responsiveText(16, context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: responsiveHeight(33, context),
                      ),
                      GestureDetector(
                        onTap: () {
                          List counters = getStorage.read('counters') == null
                              ? []
                              : getStorage.read('counters');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CounterPage(
                                counterId:
                                    getStorage.read('counters') == null ||
                                            getStorage.read('counters') == []
                                        ? '0'
                                        : (int.parse(json
                                                    .decode(getStorage
                                                        .read('counters')
                                                        .last
                                                        .toString())['tag']
                                                    .toString()) +
                                                1)
                                            .toString(),
                              ),
                            ),
                          );
                          setState(() {
                            counters.add(
                              getStorage.read('counters') == null ||
                                      getStorage.read('counters') == []
                                  ? 0.toString()
                                  : (int.parse(jsonDecode(
                                                  getStorage.read('counters'))
                                              .last['tag']
                                              .toString()) +
                                          1)
                                      .toString(),
                            );
                            getStorage.write(
                                getStorage.read('counters') == null ||
                                        getStorage.read('counters') == []
                                    ? 0.toString()
                                    : (int.parse(jsonDecode(
                                                    getStorage.read('counters'))
                                                .last['tag']
                                                .toString()) +
                                            1)
                                        .toString(),
                                {
                                  'name': '',
                                  'tag': getStorage.read('counters') == null ||
                                          getStorage.read('counters') == []
                                      ? '0'
                                      : (int.parse(jsonDecode(getStorage
                                                      .read('counters'))
                                                  .last['tag']
                                                  .toString()) +
                                              1)
                                          .toString(),
                                  'count': 0
                                });
                            getStorage.write('counters', counters);
                          });
                          print(getStorage
                                  .read(jsonDecode(getStorage.read('counters'))
                                      .last
                                      .toString())
                                  .toString() +
                              'asf');
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
                              'Add New Counter',
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
          NavBar(
            currentPage: 'Mosque',
          ),
        ],
      ),
    );
  }
}
