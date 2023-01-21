import 'package:clima/services/networking.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';

const apiKey = '39780c2daa15ea491e05224615b7e20b';

class WeatherModel {
  Future<dynamic> GetCityWeather(String city) async {
    NetworkHelper weather = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    var weatherData = await weather.getData();
    return weatherData;
  }

  Location location;
  Future<dynamic> GetLocationWeather() async {
    location = Location();
    await location.getCurrentLocation();

    NetworkHelper weather = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await weather.getData();
    return weatherData;
  }

  // 1- import http library
  // 2- use get(url with its var & key) & return into Response type
  Future<dynamic> GetTime() async {
    location = Location();
    await location.getCurrentLocation();

    NetworkHelper time = NetworkHelper(
        'https://timeapi.io/api/Time/current/coordinate?latitude=${location.latitude}&longitude=${location.longitude}');

    var timeData = await time.getData();
    return timeData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 40) {
      return '❗ Its Extreme hot outside ⚠️, head stroke alert. ❗';
    } else if (temp > 30) {
      return 'Its hot outside , Time for shorts and 👕';
    } else if (temp > 20) {
      return 'Its normal weather 🌲 ';
    } else if (temp > 10) {
      return 'Its lovely cool weather 🍃  ';
    } else {
      return 'Its very cold, bring a 🧥 🧣 and 🧤';
    }
  }
}
