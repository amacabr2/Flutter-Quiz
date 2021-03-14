import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

@swidget
ElevatedButton button(String text, Color primary, VoidCallback onPressed) {
  return new ElevatedButton(
    onPressed: () => onPressed(),
    child: Text(text),
    style: ElevatedButton.styleFrom(
        primary: primary,
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )
    ),
  );
}