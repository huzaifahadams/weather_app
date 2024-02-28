import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String valuetext;
  
  const MoreInfo({super.key, required this.icon, required this.lable, required this.valuetext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          lable,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
         Text(
          valuetext,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
