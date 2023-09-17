import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherio/api/ApiManager.dart';
import 'package:weatherio/helpers/convertTime.dart';
import 'package:weatherio/models/WeatherResponseModel.dart';
import 'package:weatherio/screens/SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  final String locationText;

  const HomeScreen({
    super.key,
    required this.locationText,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";

  getSharedPreferenceData() async {
    var prefs = await SharedPreferences.getInstance();
    var isPrefName = prefs.getString("name");

    if (isPrefName != null) {
      setState(() {
        name = isPrefName;
      });
    }
  }

  @override
  void initState() {
    getSharedPreferenceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Weather>(
          future: ApiManager.getCurrentWeatherDetails(
              cityName: widget.locationText!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while fetching data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle errors here
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              // Handle cases where data is not available
              return Text('Data not available');
            } else {
              // Data is available, you can access it from snapshot.data
              final weather = snapshot.data!;
              print(weather.current.cloud);

              // Now you can build your UI using the weather data
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 24, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "weatherwise",
                          style: GoogleFonts.alata(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 24, left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.,
                            children: [
                              Text("Hi $name,",
                                  style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700)),
                              Text(
                                'Feels like ${weather.current.feelslikeC}\u00B0',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // child: TextField(
                            //   decoration: InputDecoration(
                            //     fillColor: Color(0xFFFDFCFC),
                            //     suffixIcon: Icon(
                            //       Icons.search,
                            //       color: Color(0xFFC4C4C4),
                            //     ),
                            //     contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            //     hintText: 'Search Location',
                            //     hintStyle: GoogleFonts.poppins(
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: 15,
                            //         height: 1.5,
                            //         color: Color(0xFFC4C4C4)),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //       borderSide: BorderSide.none,
                            //     ),
                            //   ),
                            // ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                icon: Icon(Icons.search_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchScreen()));
                                },
                                iconSize: 35,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          "http:${weather.current.condition.icon}",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        child: Text(weather.current.condition.text,
                            style: GoogleFonts.sora(
                                fontSize: 20, fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(weather.location.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 11,
                          ),
                          Image.asset("assets/images/pointer.png"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                            "${weather.location.region}, ${weather.location.country}",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  Text(
                    '${weather.current.tempC}\u00B0',
                    style: GoogleFonts.poppins(
                      fontSize: 70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 20, top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 2, // Blur radius
                                offset: Offset(0, 2),
                              )
                            ],
                          ),

                          //height: MediaQuery.of(context).size.height * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Humidity",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      "assets/images/humidity.png")),
                                            ],
                                          ),
                                          Text(
                                            weather.current.humidity.toString(),
                                            style: GoogleFonts.sora(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "RainFall",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      "assets/images/rainfall.png")),
                                            ],
                                          ),
                                          Text(
                                            weather.current.precipMm.toString(),
                                            style: GoogleFonts.sora(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Clouds",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      "assets/images/clouds.png")),
                                            ],
                                          ),
                                          Text(
                                            weather.current.cloud.toString(),
                                            style: GoogleFonts.sora(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Pressure",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      "assets/images/pressure.png")),
                                            ],
                                          ),
                                          Text(
                                            weather.current.pressureIn
                                                .toString(),
                                            style: GoogleFonts.sora(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 2, // Blur radius
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),

                            //height: MediaQuery.of(context).size.height * 0.5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 80,
                                    child: Image.asset(
                                      "assets/images/wind.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    "Wind",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${weather.current.windKph.toString()}kph",
                                    style: GoogleFonts.sora(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 140,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weather.forecastList?.length,
                          itemBuilder: ((context, index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 2, // Blur radius
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  width: 85,
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            convertTime(weather
                                                .forecastList![index].time),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.sora(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.network(
                                              "http:${weather.forecastList![index].condition.icon}",
                                              fit: BoxFit.contain,
                                            )),
                                        Text(
                                            "${weather.forecastList![index].tempC}\u00B0C")
                                      ],
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
