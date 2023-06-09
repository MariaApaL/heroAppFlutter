
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Color.fromARGB(255, 160, 36, 27), // Cambiar el color de la AppBar
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please, open tu verify your account."),
          const Text(
              "If you haven't received your verification email yet, press your button below"),
          TextButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 155, 45, 37), // Cambiar el color del TextButton
            ),
            child: const Text("Send email verification."),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 121, 39, 33), // Cambiar el color del TextButton
            ),
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}