import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroapp/views/login_widgets/password_form_field_widget.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.emailController,
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
                labelText: "Email",
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
            const SizedBox(height: 10.0),
            TextFormField(
              controller: widget.passwordController,
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
                labelText: "Password",
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
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventForgotPassword());
                },
                 style: TextButton.styleFrom(
                    foregroundColor:
                        const Color.fromARGB(255, 0, 0, 0), // Cambia el color del texto del TextButton aquí
                  ),
                child: const Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String email = widget.emailController.text;
                  String password = widget.passwordController.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogIn(
                          email,
                          password,
                        ),
                      );
                },
                 style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 128, 27, 27), // Cambia el color de fondo del ElevatedButton aquí
                ),
                child: const Text("LOGIN"),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't you have an account yet?"),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventShouldRegister());
                  },
                   style: TextButton.styleFrom(
                    foregroundColor:
                        const Color.fromARGB(255, 0, 0, 0), ),
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}