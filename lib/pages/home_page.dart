import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data = {};

  final cityController = TextEditingController();

  getTime(String timeIn) {

    DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(timeIn) * 1000);

    return DateFormat.jm().format(time);
  }

  // void getWeather(String city) async {
  //   WeatherService instance = WeatherService(city: city);
  //   await instance.getLatLon();
  //   await instance.getWeather();
  //
  //
  //   Get.toNamed(
  //     '/home',
  //     arguments: {
  //       'city': instance.city,
  //       'currentData': instance.currentData,
  //       'forecastData': instance.forecastData,
  //       'failed': instance.failed,
  //       'error': instance.error,
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // getTime('1669507200');
    data = data.isNotEmpty ? data : Get.arguments;
    print(data['forecastData']['list'][3]['dt']);
    print(getTime("1669507200"));

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/background.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 70.0,
              ),
               Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: cityController,
                  onEditingComplete: () async {
                    WeatherService instance = WeatherService(city: cityController.text);
                    await instance.getLatLon();
                    await instance.getWeather();

                    print(instance.currentData);

                    setState(() {
                      data = {
                        'city': instance.city,
                        'currentData': instance.currentData,
                        'forecastData': instance.forecastData,
                        'failed': instance.failed,
                        'error': instance.error,
                      };
                    });
                  },
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Input city',
                    hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white38,
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: w,
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'http://openweathermap.org/img/wn/${data['currentData']['weather'][0]['icon']}@2x.png',
                    ),
                    Text(
                      data['currentData']['weather'][0]['description'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: w,
                padding: const EdgeInsets.only(right: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${data['currentData']['main']['temp']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      "${data['currentData']['name']}",
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              SizedBox(
                height: h * 0.3,
                child: ListView.builder(
                  itemCount: data['forecastData'].length,
                  itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0,),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                      width: 160,
                      height: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTime("${data['forecastData']['list'][index]['dt']}"),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${data['forecastData']['list'][index]['main']['temp']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Image.network(
                              "http://openweathermap.org/img/wn/${data['forecastData']['list'][index]['weather'][0]['icon']}@2x.png")
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
