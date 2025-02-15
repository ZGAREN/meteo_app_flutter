import 'package:flutter/material.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  void _fetchWeather() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final data = await _weatherService.getWeather(_controller.text);

    setState(() {
      _weatherData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Météo App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Entrez une ville",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _weatherData != null
                    ? Column(
                        children: [
                          Text(
                            "${_weatherData!['name']}, ${_weatherData!['sys']['country']}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${_weatherData!['main']['temp']}°C",
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            _weatherData!['weather'][0]['description'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    : Text("Aucune donnée"),
          ],
        ),
      ),
    );
  }
}
