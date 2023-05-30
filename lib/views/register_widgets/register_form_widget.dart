import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroapp/views/register_widgets/register_password_field.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';

class RegisterFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterFormWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                labelText: "Correo electrónico",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(
                        255, 0, 0, 0), // Cambia el color de los bordes enfocados aquí
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.fingerprint,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                labelText: "Contraseña",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(
                        255, 0, 0, 0), // Cambia el color de los bordes enfocados aquí
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _obscureText = !_obscureText;
                  },
                  icon: _obscureText
                      ? const Icon(Icons.remove_red_eye_outlined)
                      : const Icon(Icons.remove_red_eye_sharp),
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  context.read<AuthBloc>().add(AuthEventRegister(
                      email,
                      password,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 0, 0, 0), // Cambia el color de fondo del ElevatedButton aquí
                ),
                child: const Text(
                  "REGISTRARSE",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿Ya tienes cuenta?"),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                        const Color.fromARGB(255, 0, 0, 0), // Cambia el color del texto del TextButton aquí
                  ),
                  child: const Text("Inicia Sesión"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}