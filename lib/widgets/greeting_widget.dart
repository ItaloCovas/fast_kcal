import 'package:flutter/material.dart';

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({super.key});

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    late String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = 'Bom dia!';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Boa tarde!';
    } else if (hour >= 18 && hour < 21) {
      greeting = 'Boa noite!';
    } else if (hour >= 21 || hour < 5) {
      greeting = 'Boa madrugada!';
    }

    return Text(
      greeting,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}