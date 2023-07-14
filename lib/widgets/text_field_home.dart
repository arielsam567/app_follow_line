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

  static const List<String> list = [
    'Desbloquear',
    'Bloquear',
    'Adicionar campo',
    'Remover campo',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Container(
            width: 45,
            margin: const EdgeInsets.only(right: 4.0),
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
              textInputAction: TextInputAction.next,
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
          Container(
            height: 40,
            width: 30,
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              onSelected: handleClick,
              itemBuilder: (context) {
                return {
                  model.blocked ? list[0] : list[1],
                  addTextField != null ? list[2] : list[3],
                }.map((choice) {
                  return PopupMenuItem<String>(
                    textStyle: const TextStyle(color: Colors.black),
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleClick(String value) {
    if (value == list[0]) {
      updateLock();
    } else if (value == list[1]) {
      updateLock();
    } else if (value == list[2]) {
      addTextField!();
    } else if (value == list[3]) {
      removeTextField!();
    }
  }
}
