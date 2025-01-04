import 'package:http/http.dart' as http;
import 'dart:convert';
class Networking {

  final String url;

  Networking({required this.url});

  Future getData() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}