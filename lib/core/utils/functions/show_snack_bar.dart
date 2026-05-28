import 'package:flutter/material.dart';

class ShowSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
