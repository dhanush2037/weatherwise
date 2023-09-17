import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherio/screens/HomeScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchFieldController = TextEditingController();
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
              textInputAction: TextInputAction.done,
              style: GoogleFonts.poppins(fontSize: 40),
              cursorColor: Colors.black,
              controller: searchFieldController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Location",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 40, color: Colors.grey[500])),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isButtonSelected = !isButtonSelected;
                  });
                  String locationText = searchFieldController.text;
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
