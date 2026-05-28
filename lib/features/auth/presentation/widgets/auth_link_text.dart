import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthLinkText extends StatelessWidget {
  const AuthLinkText({
    super.key,
    required this.text,
    required this.linkText,
    required this.onPressed,
  });

  final String text;
  final String linkText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        children: [
          TextSpan(text: "$text "),
          TextSpan(
            text: linkText,
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()..onTap = () => onPressed(),
          ),
        ],
      ),
    );
  }
}
