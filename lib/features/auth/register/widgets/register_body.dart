import 'package:flutter/material.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/app_icon.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// App Icon
            const AppIcon(),

            /// Register Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
              child: Column(
                children: [
                  // Facebook Button
                  Text(
                    'Register with',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      // Handle Facebook registration
                    },
                    text: 'Continue with =',
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    borderRadius: BorderRadius.circular(8),
                    icon: const Icon(Icons.facebook_outlined),
                    iconColor: Colors.white,
                  ),

                  const SizedBox(height: 20),

                  // Google Button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}