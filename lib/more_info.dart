import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.water_drop,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Humidity',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '95',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.wind_power,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Wind Speed',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '945.4',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.beach_access,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Pressure',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '945',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
