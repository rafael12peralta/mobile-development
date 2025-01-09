import 'location.dart';
import 'networking.dart';

class WeatherModel {
  final String baseUrl;
  final String apiKey;

  Future<dynamic> getWeatherDataByCity(String cityName) async {
    Networking networking = Networking();
    var weatherData = await networking.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location;
    await location.getCurrentPosition();

    Networking networking = Networking(
        url: '$baseUrl?lat=${location.latitude}&lon=${location.longitude}');
    var weatherData = await networking.getData();
    return weatherData;
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
