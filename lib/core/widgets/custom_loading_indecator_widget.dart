import 'package:flutter/material.dart';

class CustomLoadingIndecatorWidget extends StatelessWidget {
  const CustomLoadingIndecatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}