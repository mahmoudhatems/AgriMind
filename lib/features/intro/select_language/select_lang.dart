import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
               {
                  context.setLocale(const Locale('en'));
                   GoRouter.of(context).pushReplacement(Routes.home);
                }
              },
              child: const Text('English'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
               {
                  context.setLocale(const Locale('ar'));
                  GoRouter.of(context).pushReplacement(Routes.home);
                }
              },
              child: const Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
