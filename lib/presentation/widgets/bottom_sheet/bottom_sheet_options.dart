import 'package:flutter/material.dart';

void showOptions(BuildContext context, List<ListTile> options) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: options,
      );
    },
  );
}