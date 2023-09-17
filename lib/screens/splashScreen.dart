import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherio/screens/HomeScreen.dart';
import 'package:weatherio/screens/UserScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isIN = false;
  getSharedPreferceData() async {
    var prefs = await SharedPreferences.getInstance();
    var isINFromPrefs = prefs.getBool("isIN");
    if (isINFromPrefs != null) {
      isIN = isINFromPrefs;
    }
    if (isIN == true) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      locationText: "Mangalore",
                    )));
      });
    } else if (isIN == null || isIN == false) {
      print("navigated to Userscreen");
      print(isIN);
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserScreen()));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "weatherwise",
          style: GoogleFonts.alata(
              fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
