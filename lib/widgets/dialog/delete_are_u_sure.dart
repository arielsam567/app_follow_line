import 'package:app_follow_line/config/themes/colors.dart';
import 'package:flutter/material.dart';

void openDialogAreUSure(BuildContext context,
    {required String content, required void Function() onPressed}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        elevation: 10,
        title: const Text('Deseja excluir?'),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              onPressed();
              Navigator.pop(context);
            },
            child: const Text(
              'EXCLUIR',
              style: TextStyle(
                color: MyColors.error,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCELAR',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}
