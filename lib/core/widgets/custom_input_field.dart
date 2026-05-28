import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconPressed;
  final Key? formFieldKey;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autoValidateMode;
  final Iterable<String>? autofillHints;

  const CustomInputField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onSuffixIconPressed,
    this.formFieldKey,
    this.onChanged,
    this.textInputAction,
    this.autoValidateMode,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        TextFormField(
          autofillHints: autofillHints,
          cursorColor: Theme.brightnessOf(context) == Brightness.dark
              ? Colors.white.withAlpha(220)
              : Colors.black.withAlpha(220),
          autovalidateMode: autoValidateMode,
          onChanged: onChanged,
          key: formFieldKey,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: _getIconColor(context))
                : null,
            suffixIcon: suffixIcon != null
                ? onSuffixIconPressed != null
                      ? IconButton(
                          icon: Icon(suffixIcon),
                          onPressed: onSuffixIconPressed,
                          color: _getIconColor(context),
                        )
                      : Icon(suffixIcon, color: _getIconColor(context))
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.brightnessOf(context) == Brightness.dark
                    ? Colors.white.withAlpha(200)
                    : Colors.black.withAlpha(200),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.brightnessOf(context) == Brightness.dark
                    ? Colors.white.withAlpha(200)
                    : Colors.black.withAlpha(200),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.indigo, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Color _getIconColor(BuildContext context) =>
      Theme.brightnessOf(context) == Brightness.dark
      ? Colors.white.withAlpha(220)
      : Colors.black.withAlpha(220);
}
