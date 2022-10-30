import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:namaz_timing/responsive.dart';

class SingleMosqueScreen extends StatefulWidget {
  const SingleMosqueScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<SingleMosqueScreen> createState() => _SingleMosqueScreenState();
}

var _mosqueData = {
  "name": "Masjid",
  "map_link": "https://goo.gl/maps/4Pp38sqWWGcJXs8h6",
  "img": "https://i.ibb.co/x7T8x0P/2019-06-04.jpg",
  "background_img":
      "https://t3.ftcdn.net/jpg/04/40/04/56/360_F_440045623_BF4jzAxuOyYkDo04JJK0x9Fd0onYL3mN.jpg",
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

class _SingleMosqueScreenState extends State<SingleMosqueScreen> {
  Future<void> getData() async {
    var response = await http
        .get(Uri.parse('https://api.namaz.co.in/getMasjids/${widget.id}'));

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

  bool _showSpinner = true;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData() async {
        var response = await http
            .get(Uri.parse('https://api.namaz.co.in/getMasjids/${widget.id}'));

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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    _mosqueData['background_img'].toString(),
                    height: responsiveHeight(278, context),
                    width: double.infinity,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
