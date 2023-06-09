
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({Key? key, required this.size}) : super(key: key);

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
          "Be part of SuperheroLab",style: Theme.of(context).textTheme.displaySmall?.copyWith(
    color:const Color.fromARGB(255, 129, 29, 22),
  ), 
        ),
        Text(
          "Create an acount to continue",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}