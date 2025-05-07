import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showToast(BuildContext context, String message, {Color? color}) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: color ?? const Color(0xFFFAE5E5), // Light error background
    flushbarPosition: FlushbarPosition.BOTTOM,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.redAccent,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    borderRadius: BorderRadius.circular(12),
    boxShadows: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6.0,
        offset: Offset(0, 3),
      ),
    ],
    messageColor: Colors.black87,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  )..show(context);
}
