import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/services/weather_service.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  // String city = 'Kaduna';

  void setUpWeather(String city) async {
    WeatherService instance = WeatherService(city: city);
    await instance.getLatLon();
    await instance.getWeather();

    Get.toNamed(
      '/home',
      arguments: {
        'city': instance.city,
        'currentData': instance.currentData,
        'forecastData': instance.forecastData,
        'failed': instance.failed,
        'error': instance.error,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setUpWeather('Kaduna');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: const Center(
        child: SpinKitFadingCircle(
          size: 50.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
