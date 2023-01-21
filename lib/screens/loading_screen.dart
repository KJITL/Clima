import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import 'package:clima/screens/location_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    dynamic weatherData;
    dynamic timeData;
    try {
      weatherData = await Future.value(WeatherModel().GetLocationWeather())
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      print('Failed to get data by $e');
    }

    try {
      timeData = await Future.value(
        WeatherModel().GetTime(),
      ).timeout(const Duration(seconds: 20));
    } catch (e) {
      print('Failed to get data by $e');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(weatherData, timeData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loadingwp.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SpinKitDancingSquare(
            color: Colors.white,
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
