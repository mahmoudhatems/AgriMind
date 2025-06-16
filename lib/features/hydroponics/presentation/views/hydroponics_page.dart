import 'package:flutter/material.dart';

class HydroponicsPage extends StatelessWidget {
  const HydroponicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponics'),
      ),
      body: Center(
        child: Text(
          'Hydroponics Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}