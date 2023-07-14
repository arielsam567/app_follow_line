import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/models/text_field.dart';
import 'package:app_follow_line/widgets/dialog/delete_are_u_sure.dart';
import 'package:flutter/material.dart';

class CardSavedItems extends StatelessWidget {
  final List<TextFieldModel> models;
  final Function delete;
  final Function select;

  const CardSavedItems({
    required this.models,
    required this.delete,
    required this.select,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => select(),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...models.map(
                  (e) => Text(
                    '${e.key}:${e.value}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  onPressed: () => openDialogAreUSure(
                    context,
                    content: 'Deseja excluir este item?',
                    onPressed: () => delete(),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: MyColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
