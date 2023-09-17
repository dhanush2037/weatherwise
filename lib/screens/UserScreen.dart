import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherio/screens/HomeScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();

  bool isButtonSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              style: GoogleFonts.poppins(
                  fontSize: 50, fontWeight: FontWeight.w500),
              cursorColor: Colors.black,
              controller: userNameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Name",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 50, color: Colors.grey[500])),
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              style: GoogleFonts.poppins(fontSize: 40),
              cursorColor: Colors.black,
              controller: locationNameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Location",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 40, color: Colors.grey[500])),
            ),
            IconButton(
                onPressed: () async {
                  setState(() {
                    isButtonSelected = !isButtonSelected;
                  });
                  String locationText = locationNameController.text;
                  String name = userNameController.text;

                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString("name", name);
                  prefs.setBool("isIN", true);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(locationText: locationText)));
                },
                icon: Icon(
                  isButtonSelected
                      ? Icons.arrow_circle_right
                      : Icons.arrow_circle_right_outlined,
                  size: 70,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
