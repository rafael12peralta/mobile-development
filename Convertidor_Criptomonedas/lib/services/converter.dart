import 'package:convertidor_criptomonedas/services/networking.dart';

class CurrencyConverter {
  final String baseUrl = "https://rest.coinapi.io/v1/exchangerate";
  final String apiKey = "6d997540-cc50-4993-b98d-6d6f0ab3a5b7";

  Future<dynamic> getExchangeRate(String crypto, String currency) async {
    String url = "$baseUrl/$crypto/$currency";

    try {
      Networking networking = Networking(url: url, apiKey: apiKey);
      var exchangeData = await networking.getData();

      if (exchangeData != null && exchangeData['rate'] != null) {
        return exchangeData['rate'];
      } else {
        throw "Datos no válidos recibidos.";
      }
    } catch (e) {
      print("Error al obtener la tasa de cambio: $e");
      return null;
    }
  }
}
