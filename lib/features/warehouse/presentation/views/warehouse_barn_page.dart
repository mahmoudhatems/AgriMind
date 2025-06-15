import 'package:flutter/material.dart';

class WarehouseBarnPage extends StatelessWidget {
  const WarehouseBarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse & Barn'),
      ),
      body: Center(
        child: Text(
          'Warehouse & Barn Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}