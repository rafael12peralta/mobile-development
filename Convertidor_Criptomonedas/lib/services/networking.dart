import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  final String url;
  final String apiKey;

  Networking({required this.url, required this.apiKey});

  Future getData() async {
    try {
      print("Realizando solicitud a: $url");

      var response = await http.get(
        Uri.parse(url),
        headers: {
          'X-CoinAPI-Key': apiKey,
          'Content-Type': 'application/json',
        },
      );

      print("Headers: {'X-CoinAPI-Key': $apiKey, 'Content-Type': 'application/json'}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        print('Body: ${response.body}');
        return jsonResponse;
      } else {
        print('Request failed with status: ${response.statusCode}. Body: ${response.body}');
        throw "Error al realizar la solicitud: ${response.statusCode}";
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      return null;
    }
  }
}
