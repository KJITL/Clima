import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/services.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/city_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: {
        'loading': (context) => LoadingScreen(),
        'city': (context) => CityScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
