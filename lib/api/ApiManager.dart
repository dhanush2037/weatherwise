import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherio/models/WeatherResponseModel.dart';

class ApiManager {
  static Future<Weather> getCurrentWeatherDetails(
      {String cityName = "Mangalore"}) async {
    List<Hour> forecastList = [];
    String apiKey = "YOUR API key";

    try {
      var response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=${apiKey}&q=${cityName}&days=1&aqi=no&alerts=no'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = json.decode(response.body);

        for (var hourlyWeather in weatherData["forecast"]["forecastday"][0]
            ["hour"]) {
          Hour hour = hourFromJson(jsonEncode(hourlyWeather));
          forecastList.add(hour);
        }
        Weather weather = weatherFromJson(jsonEncode(weatherData));
        weather.forecastList = forecastList;

        return weather;
      } else {
        throw "No data";
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
