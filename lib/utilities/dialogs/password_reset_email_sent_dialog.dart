import 'package:flutter/material.dart';
import 'package:heroapp/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Restablecer contraseña',
    content:
        'Hemos enviado un correo electrónico a tu cuenta para restablecer tu contraseña.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}