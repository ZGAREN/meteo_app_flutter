import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = "TA_CLE_API"; // Remplace par ta clé API
  static const String _baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>?> getWeather(String city) async {
    final url =
        Uri.parse("$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=fr");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Erreur : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Erreur : $e");
      return null;
    }
  }
}
