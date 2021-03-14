import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

@swidget
List<Widget> loadingIcon() {
  return <Widget>[
    SizedBox(
      child: CircularProgressIndicator(),
      width: 60,
      height: 60,
    ),
    Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text('Awaiting result...'),
    )
  ];
}