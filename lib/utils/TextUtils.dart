import 'package:flutter/material.dart';

class TextUtils extends Text {
  TextUtils(String text, {color: Colors.black, textScaleFactor: 1.0}):
      super(
          text,
          textScaleFactor: textScaleFactor,
          style: new TextStyle(color: color)
      );
}