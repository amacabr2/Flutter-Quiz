import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_quizz/models/Question.dart';

@swidget
List<Widget> errorIcon(AsyncSnapshot<List<Question>> snapshot) {
  return <Widget>[
    Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 60,
    ),
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text('Error: ${snapshot.error}'),
    )
  ];
}