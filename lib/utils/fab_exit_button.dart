
import 'package:flutter/material.dart';

import 'custom_color.dart';

Widget fabExitButton(BuildContext context) {
  return FloatingActionButton(
    foregroundColor: Colors.black45,
    backgroundColor: CustomColor.gold,
    child: const Icon(
      Icons.close_sharp,
      size: 30
    ),
    onPressed: () {
      Navigator.of(context).pop();
    }
  );
}