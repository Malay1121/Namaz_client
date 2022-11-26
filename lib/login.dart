import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:namaz_timing/admin.dart';
import 'package:namaz_timing/main.dart';
import 'package:namaz_timing/masjid_admin.dart';
import 'package:namaz_timing/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        if (preferences.getString('email') != null &&
            preferences.getString('password') != null &&
            preferences.getString('password') != 'null' &&
            preferences.getString('email') != 'null') {
          dynamic response =
              await http.post(Uri.parse('https://api.namaz.co.in/login'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode({
                    'email': preferences.getString('email'),
                    'password': preferences.getString('password')
                  }));
          var body = jsonDecode(response.body);
          SharedPreferences preference = await SharedPreferences.getInstance();

          if (body['detail'] != "email or password incorrect") {
            preference!.setString('_id', body['_id']);
            preference!.setString('name', body['name']);
            preference!.setString('password', body['password']);
            preference!.setString('masjidId', body['masjidId']);
            preference!.setString('email', body['email']);
            preference!.setBool('masjidAdmin', body['masjidAdmin']);
            preference!.setBool('namazAdmin', body['namazAdmin']);

            if (body['masjidAdmin'] == true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MasjidTimingScreen()));
            } else if (body['namazAdmin'] == true) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminScreen()));
            }
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Text(
                    'Wrong Email or Password!',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Color(0xFF77B255),
                        fontSize: responsiveText(20, context),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _mediaQuery.height / 7.96078431373,
              ),
              Text(
                'Welcome Back',
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                    color: Color(0xFF77B255),
                    fontSize: _mediaQuery.width / 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: _mediaQuery.width / 1.28865979381,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: _mediaQuery.width / 31.25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _mediaQuery.height / 12.6875,
              ),
              TextFields(
                mediaQuery: _mediaQuery,
                title: 'Email',
                controller: _emailController,
                hint: 'Type in your email',
              ),
              SizedBox(
                height: _mediaQuery.height / 54.1333333333,
              ),
              TextFields(
                mediaQuery: _mediaQuery,
                title: 'Password',
                controller: _passwordController,
                hint: '●●●●●●●●',
              ),
              SizedBox(
                height: _mediaQuery.height / 40.6,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: _mediaQuery.width / 11.71875,
                  right: _mediaQuery.width / 17.8571428571,
                ),
                child: Row(
                  children: [
                    Container(
                      height: _mediaQuery.width / 15.625,
                      width: _mediaQuery.width / 15.625,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E1FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: _mediaQuery.width / 25,
                    ),
                    Text(
                      'Remember me',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          color: Color(0xFFAAA6B9),
                          fontSize: _mediaQuery.width / 31.25,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                            color: Color(0xFF77B255),
                            fontSize: _mediaQuery.width / 31.25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _mediaQuery.height / 25.375,
              ),
              Button1(
                mediaQuery: _mediaQuery,
                title: 'Login',
                backgroudColor: Color(0xFF77B255),
                onTap: () async {
                  dynamic response = await http.post(
                      Uri.parse('https://api.namaz.co.in/login'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode({
                        'email': _emailController.text,
                        'password': _passwordController.text
                      }));
                  var body = jsonDecode(response.body);
                  SharedPreferences preference =
                      await SharedPreferences.getInstance();

                  if (body['detail'] != "email or password incorrect") {
                    preference!.setString('_id', body['_id']);
                    preference!.setString('name', body['name']);
                    preference!.setString('password', body['password']);
                    preference!.setString('masjidId', body['masjidId']);
                    preference!.setString('email', body['email']);
                    preference!.setBool('masjidAdmin', body['masjidAdmin']);
                    preference!.setBool('namazAdmin', body['namazAdmin']);

                    if (body['masjidAdmin'] == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasjidTimingScreen()));
                    } else if (body['namazAdmin'] == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Text(
                            'Wrong Email or Password!',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Color(0xFF77B255),
                                fontSize: responsiveText(20, context),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: _mediaQuery.height / 40.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  const Button1({
    required Size mediaQuery,
    required this.title,
    required this.backgroudColor,
    required this.onTap,
    this.textColor = Colors.white,
  }) : _mediaQuery = mediaQuery;

  final Size _mediaQuery;
  final String title;
  final Color backgroudColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _mediaQuery.height / 16.24,
        width: _mediaQuery.width / 1.40977443609,
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                color: textColor,
                fontSize: _mediaQuery.width / 26.7857142857,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  TextFields({
    required Size mediaQuery,
    required this.title,
    required this.controller,
    required this.hint,
  }) : _mediaQuery = mediaQuery;

  final Size _mediaQuery;
  final String title;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              color: Color(0xFF77B255),
              fontSize: _mediaQuery.width / 31.25,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
        SizedBox(
          height: _mediaQuery.height / 81.2,
        ),
        SizedBox(
          width: _mediaQuery.width / 1.18296529968,
          height: _mediaQuery.height / 16.24,
          child: TextField(
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: _mediaQuery.width / 31.25,
              ),
            ),
            obscureText: title == 'Password' ? true : false,
            controller: controller,
            keyboardType: title == 'Email'
                ? TextInputType.emailAddress
                : title == 'Password'
                    ? TextInputType.visiblePassword
                    : TextInputType.text,
            decoration: InputDecoration(
              labelStyle: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: _mediaQuery.width / 31.25,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              hintStyle: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: _mediaQuery.width / 31.25,
                ),
              ),
              hintText: hint,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
