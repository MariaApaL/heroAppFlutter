import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginHeaderWidget extends StatelessWidget {
const LoginHeaderWidget({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage("assets/images/welcome.png"),
          height: size.height * 0.2,
        ),
        Text(
          "Bienvenido a SuperheroLab",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          "Inicia sesión para continuar",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}