import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_input_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autoValidateMode;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.autofillHints,
    this.autoValidateMode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      keyboardType: TextInputType.visiblePassword,
      autofillHints: widget.autofillHints ?? const [AutofillHints.password],
      onChanged: widget.onChanged,
      controller: widget.controller,
      label: widget.label,
      hintText: widget.hintText,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureText,
      suffixIcon: _obscureText ? Icons.visibility_off : Icons.visibility,
      onSuffixIconPressed: () => setState(() => _obscureText = !_obscureText),
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      autoValidateMode: widget.autoValidateMode,
    );
  }
}
