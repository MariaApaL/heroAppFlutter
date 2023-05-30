import 'package:flutter/material.dart';
import 'package:heroapp/views/register_widgets/register_form_widget.dart';
import 'package:heroapp/views/register_widgets/register_header_widget.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                RegisterHeaderWidget(size: size),
                RegisterFormWidget( emailController: _email,  passwordController: _password),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








