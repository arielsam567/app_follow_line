import 'package:app_follow_line/config/themes/colors.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';

class CardSelector extends StatelessWidget {
  final List<String> data;
  final Function(String value, int index) onChange;
  final int selectedIndex;

  const CardSelector({
    required this.data,
    required this.onChange,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: DirectSelectList<String>(
                values: data,
                defaultItemIndex: selectedIndex,
                itemBuilder: (value) => getDropDownMenuItem(value),
                focusedItemDecoration: _getDslDecoration(),
                onItemSelectedListener: (string, index, conte) => onChange(string, index),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.unfold_more,
              color: MyColors.black,
            ),
          )
        ],
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
      value: value,
      itemBuilder: (context, value) {
        return Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: MyColors.black,
          ),
        );
      },
    );
  }

  BoxDecoration _getDslDecoration() {
    return const BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(color: Colors.black12),
        top: BorderSide(color: Colors.black12),
      ),
    );
  }
}
