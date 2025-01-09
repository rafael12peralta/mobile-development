import 'location.dart';
import 'networking.dart';

class WeatherModel {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey = "75db86c7ea4e8ad316213caf2289c772";

  Future<dynamic> getWeatherDataByCity(String cityName) async {
    print('$baseUrl?q=${cityName}&appid=${apiKey}&units=metric');
    try {
      Networking networking = Networking(
          url: '$baseUrl?q=${cityName}&appid=${apiKey}&units=metric');
      var weatherData = await networking.getData();
      print(weatherData);

      if (weatherData != null && weatherData['main'] != null) {
        return weatherData;
      } else {
        throw "Datos no válidos recibidos";
      }
    } catch (e) {
      print("Error al obtener el clima: $e");
      return null;
    }
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentPosition();

    Networking networking = Networking(
        url:
            '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}');
    var data = await networking.getData();
    return data;
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
