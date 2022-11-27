import 'dart:convert';
import 'package:weather_app/auth/secrets.dart';
import 'package:http/http.dart';

final String apiKey = apiId;

class WeatherService {
  String? city = '';
  double lat = 0.0;
  double lon = 0.0;
  bool failed = false;
  dynamic error;

  Map? currentData;
  Map? forecastData;
  
  WeatherService({ this.city });

  Future<void> getLatLon() async {

    try {
      String uri = "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey";


      Response response = await get(Uri.parse(uri));

      List data = jsonDecode(response.body);

      lat = data[0]['lat'];

      lon = data[0]['lon'];

    }
    catch (e) {
      failed = true;
      error = e;
      print(e);
    }
    // print('data[0]);
  }

  Future<void> getWeather() async {

    try {
      String currentUri = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey";
      String forecastUri = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&cnt=5&appid=$apiKey";

      print(city);

      Response current = await get(Uri.parse(currentUri));
      Response forecast = await get(Uri.parse(forecastUri));

      currentData = jsonDecode(current.body);
      forecastData = jsonDecode(forecast.body);

      // print(forecastData?['list'][0]['dt']);

    }
    catch (e) {
      failed = true;
      error = e;
      print(e);
    }
  }

}

