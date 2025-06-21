import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
            color: ColorsManager.errorColor,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              errorMessage,
              style: TextStyle(
                fontSize: 20,
                color: ColorsManager.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
