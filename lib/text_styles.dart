import 'package:flutter/material.dart';

class LabelTextSytle {
  static TextStyle? bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Colors.black,
          letterSpacing: 2.0,
        );
  }
}
