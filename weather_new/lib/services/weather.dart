import 'package:weather_new/models/weather-data.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey = "75db86c7ea4e8ad316213caf2289c772";

  Future<WeatherData> getWeatherDataByCity(String cityName) async {
    print('$baseUrl?q=${cityName}&appid=${apiKey}&units=metric');
    Networking networking =
        Networking(url: '$baseUrl?q=${cityName}&appid=${apiKey}&units=metric');
    var data = await networking.getData();

    try {
      WeatherData weatherData = WeatherData.fromJson(data);
      return weatherData;
    } catch (e) {
      print('Error: $e'); 
      return new WeatherData();
    }
  }

  Future<WeatherData> getWeatherData() async {
    Location location = Location();
    await location.getCurrentPosition();

    Networking networking = Networking(
        url: '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}');
    var data = await networking.getData();

    try {
      WeatherData weatherData = WeatherData.fromJson(data);
      return weatherData;
    } catch (e) {
      print('Error: $e');
      return new WeatherData();
    }
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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
