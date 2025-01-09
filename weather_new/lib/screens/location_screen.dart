import 'package:flutter/material.dart';
import 'package:weather_new/screens/city_screen.dart';
import 'package:weather_new/services/weather.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String currentCity = '';
  String weatherIcon = '☀️';
  String weatherMessage = '';
  //"It's 🍦 time";

  void updateUI(int temp, String newCity, int condition) {
    setState(() {
      temperature = temp;
      currentCity = newCity;
      weatherIcon = WeatherModel().getWeatherIcon(condition);
      weatherMessage = WeatherModel().getMessage(temp);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    final weather = WeatherModel();
    var weatherData = await weather.getWeatherData();

    if (weatherData != null && weatherData['main'] != null) {
      int temp = (weatherData['main']['temp'] ?? 0).toInt();
      int condition = (weatherData['weather'][0]['id'] ?? 0).toInt();
      String cityName = weatherData['name'] ?? '';
      updateUI(temp, cityName, condition);
    } else {
      print("Error: No se pudieron obtener los datos del clima.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                    onPressed: () {
                      fetchWeatherData();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName =
                          await Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ));
                      if (cityName != null) {
                        final weather = new WeatherModel();
                        var weatherData =
                            await weather.getWeatherDataByCity(cityName);

                        if (weatherData != null &&
                            weatherData['main'] != null) {
                          int temp = (weatherData['main']['temp'] ?? 0).toInt();
                          int condition =
                              (weatherData['weather'][0]['id'] ?? 0).toInt();
                          updateUI(temp, cityName, condition);
                        } else {
                          print("Error: Datos inválidos");
                        }
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString() + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage + " in " + currentCity,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
