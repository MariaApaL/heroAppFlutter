// import 'package:flutter/material.dart';

// class RegisterPasswordFormField extends StatefulWidget {
//   const RegisterPasswordFormField({super.key});

//   @override
//   State<RegisterPasswordFormField> createState() =>
//       _RegisterPasswordFormFieldState();
// }

// class _RegisterPasswordFormFieldState extends State<RegisterPasswordFormField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: _obscureText,
//       enableSuggestions: false,
//       autocorrect: false,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.fingerprint,
//           color: Color.fromARGB(255, 0, 0, 0),
//         ),
//         labelStyle: const TextStyle(
//           color: Color.fromARGB(255, 0, 0, 0),
//         ),
//         labelText: "Contraseña",
   
//         border: const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 2.0,
//             color: Color.fromARGB(255, 0, 0, 0),
//           ),
//         ),
//         focusedBorder:const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 2.0,
//             color: Color.fromARGB(
//                 255, 0, 0, 0), // Cambia el color de los bordes enfocados aquí
//           ),
//         ),
//         suffixIcon: IconButton(
//           onPressed: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           icon: _obscureText
//               ? const Icon(Icons.remove_red_eye_outlined)
//               : const Icon(Icons.remove_red_eye_sharp),
//         color: const Color.fromARGB(255, 0, 0, 0),
//         ),
//       ),
//     );
//   }
// }
