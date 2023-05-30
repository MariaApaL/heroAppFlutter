import 'package:flutter/material.dart';
import 'package:heroapp/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: '¿Quieres cerrar sesión?',
    optionsBuilder: () => {
      'Cancelar': false,
      'Salir': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
