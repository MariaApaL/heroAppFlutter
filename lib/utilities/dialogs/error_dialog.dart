import 'package:flutter/material.dart';
import 'package:heroapp/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Ha ocurrido un error',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}