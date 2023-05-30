
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
   State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.fingerprint),
        labelText: "Contraseña",
        hintText: "Contraseña",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: _obscureText ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye_sharp),
        ),
      ),
    );
  }
}