import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen(this.locationWeather, this.timeData);
  final locationWeather;
  final timeData;
}

class _LocationScreenState extends State<LocationScreen> {
  // bring the data from original class ^ , to this widget. as required .
  @override
  void initState() {
    super.initState();
    UpdateInfo(widget.locationWeather, widget.timeData, true);
  }

  //passing the value to variable
  String city;
  String tempMSG;
  String conditionICON;

  String date;
  String timeZone;
  String day;
  String time;

  int tmp;
  void UpdateInfo(dynamic weatherData, dynamic timeData, bool timeUpdata) {
    setState(
      () {
        if (weatherData == null) {
          date = '';
          timeZone = '';
          day = '';
          tmp = 0;
          city = ' ?';
          conditionICON = ':(';
          tempMSG = ' Location unaccessable, try again ';
          return;
        }
        city = weatherData['name'];
        double temp = weatherData['main']['temp'].toDouble();
        tmp = temp.toInt();
        tempMSG = weather.getMessage(tmp);
        int conditionID = weatherData['weather'][0]['id'];
        conditionICON = weather.getWeatherIcon(conditionID);
        if (timeUpdata) {
          date = timeData['date'];
          timeZone = timeData['timeZone'];
          day = timeData['dayOfWeek'];
          time = timeData['time'];
        } else {
          date = '';
          timeZone = '';
          day = '';
          time = '';
        }
      },
    );
  }

  String searchedCity;
  WeatherModel weather = WeatherModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loadingwp.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var currentLocation = await weather.GetLocationWeather();
                      var currentTime = await weather.GetTime();
                      UpdateInfo(currentLocation, currentTime, true);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$date  $day $time',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Courgette',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      searchedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));

                      if (searchedCity != null) {
                        var cityData =
                            await weather.GetCityWeather(searchedCity);
                        var fake;
                        await UpdateInfo(cityData, fake, false);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${tmp}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      conditionICON,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "$tempMSG in $city $timeZone",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
