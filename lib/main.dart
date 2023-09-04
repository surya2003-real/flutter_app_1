import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_2/model/data_model.dart';
//https://codeforgeek.com/flutter-fetch-data-from-rest-api/
void main() => runApp(const MaterialApp(
  home: ImageDisplay(),
));

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  WeatherAPP createState() => WeatherAPP();
}

class WeatherApiService {
  final String apiKey;
  final String baseUrl = 'https://api.weatherapi.com/v1/current.json';

  WeatherApiService(this.apiKey);

  Future<DataModel> fetchWeatherData(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$city&aqi=yes'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return DataModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
class WeatherAPP extends State<ImageDisplay> {

  final String apiKey = 'ff45f6a24cb542269eb175211230409'; // Replace with your API key
  late WeatherApiService apiService; // Declare it as a late variable

  final TextEditingController _cityController = TextEditingController();
  DataModel? _weatherData;

  @override
  void initState() {
    super.initState();
    apiService = WeatherApiService(apiKey); // Initialize apiService in initState
  }
  void _fetchWeatherData() async {
    try {
      final weatherData = await apiService.fetchWeatherData(_cityController.text);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Image Generator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if(img_url==img_url1) {
      //         img_url = img_url2;
      //       }
      //       else{
      //         img_url=img_url1;
      //       }
      //     });
      //   },
      //   backgroundColor: Colors.grey[800],
      //   child: Icon(Icons.add),
      // ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter a city name:'),
            SizedBox(height: 10),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'City Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (_weatherData != null)
              Column(
                children: [
                  Text('City: ${_weatherData!.location.name.toString()}'),
                  Text('Temperature: ${_weatherData!.current.tempC.toString()}°C'),
                  Text('Weather: ${_weatherData!.current.condition.text.toString()}'),
                  Text('Last Updated: ${_weatherData!.current.lastUpdated.toString()}'),
                  Text('Local Time: ${_weatherData!.location.localtime.toString()}'),

                ],
              ),
          ],
        ),
      ),

    );
  }
}