import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/more_info.dart';
import 'package:weather_app/secrets.dart';

import 'forecasts.dart';
import 'package:http/http.dart' as http;

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  Future getCurrentWeather() async {
    try {
      String cityName = 'Uganda';
      // uk
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherApiKey'));
      final data = jsonDecode(res.body);
      if (data['cod'] != 200) {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                getCurrentWeather();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: FutureBuilder(
          future: getCurrentWeather(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final data = snapshot.data!;
            // final currentWeatherData = data['list'][0];
            final currentTemp = data['main']['temp'];
            final currentSky = data['weather'][0]['main'];
            final humidityInfo = data['main']['humidity'].toString();
            final pressureinfo = data['main']['pressure'].toString();
            final windspeed = data['wind']['speed'].toString();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  currentSky,
                                  style: const TextStyle(fontSize: 21),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //weather forecasr cards
                  const Text(
                    'Hourly Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          const ForecastItem(
                            time: '9:23',
                            icon: Icons.cloud,
                            temp: '44.3',
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //more info
                  const Text(
                    'Additional  Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MoreInfo(
                          icon: Icons.water_drop,
                          lable: 'Humidity',
                          valuetext: humidityInfo),
                      MoreInfo(
                          icon: Icons.wind_power,
                          lable: 'Wind Speed',
                          valuetext: windspeed),
                      MoreInfo(
                          icon: Icons.beach_access,
                          lable: 'Pressure',
                          valuetext: pressureinfo),
                    ],
                  )
                ],
              ),
            );
          }),
        ));
  }
}
