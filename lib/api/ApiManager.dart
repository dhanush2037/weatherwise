import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherio/models/WeatherResponseModel.dart';

class ApiManager {
  static Future<Weather> getCurrentWeatherDetails(
      {String cityName = "Mangalore"}) async {
    List<Hour> forecastList = [];
    // var response = await http.get(
    //   Uri.parse(
    //       'http://api.weatherapi.com/v1/current.json?key=8da1a1533b0d4f1a8ac84448231509&q=mangalore&aqi=no'),
    // );
    var response1 = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=8da1a1533b0d4f1a8ac84448231509&q=${cityName}&days=1&aqi=no&alerts=no'));
    //print(response1.body);
    if (response1.statusCode == 200) {
      final Map<String, dynamic> weatherData = json.decode(response1.body);
      //print(weatherData["forecast"]["forecastday"][0]["hour"]);

      for (var hourlyWeather in weatherData["forecast"]["forecastday"][0]
          ["hour"]) {
        Hour hour = hourFromJson(jsonEncode(hourlyWeather));
        forecastList.add(hour);
      }
      Weather weather = weatherFromJson(jsonEncode(weatherData));
      weather.forecastList = forecastList;
      //print(weather.current.condition.text);
      return weather;
    } else {
      throw "No data";
    }
  }
}
