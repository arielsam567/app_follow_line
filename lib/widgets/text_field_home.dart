import 'package:app_follow_line/config/themes/colors.dart';
import 'package:app_follow_line/models/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldHome extends StatelessWidget {
  final TextFieldModel model;
  final Function updateLock;
  final Function? addTextField;
  final Function? removeTextField;

  const TextFieldHome({
    required this.model,
    required this.updateLock,
    this.addTextField,
    this.removeTextField,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            margin: const EdgeInsets.only(right: 8.0),
            child: TextFormField(
              initialValue: model.key,
              enabled: !model.blocked,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                model.key = value;
              },
              decoration: const InputDecoration(
                labelText: 'Key',
              ),
            ),
          ),
          Flexible(
            child: TextFormField(
              initialValue: model.value,
              enabled: !model.blocked,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                model.value = value;
              },
              decoration: const InputDecoration(
                labelText: 'Value',
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 20,
            onPressed: () => updateLock(),
            icon: Icon(
              model.blocked ? Icons.lock_open : Icons.lock_outline,
              color: model.blocked ? MyColors.error : MyColors.black,
            ),
          ),
          if (addTextField != null) ...[
            IconButton(
              padding: EdgeInsets.zero,
              splashRadius: 20,
              onPressed: () => addTextField!(),
              icon: const Icon(Icons.add, color: MyColors.success),
            ),
          ] else ...[
            Visibility(
              visible: !model.blocked,
              child: IconButton(
                splashRadius: 20,
                onPressed: () => removeTextField!(),
                icon: const Icon(Icons.remove, color: MyColors.error),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
