import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/factories/QuestionFactory.dart';
import 'package:flutter_quizz/models/Question.dart';
import 'package:flutter_quizz/utils/TextUtils.dart';

class Quizz extends StatefulWidget {
  Quizz({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  Question _question;
  int _index = 0;
  int _score = 0;

  final Future<List<Question>> _initQuestions = QuestionFactory.questions;

  @override
  Widget build(BuildContext context) {
    double size  = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: new TextUtils('Quizz | Partie'),
      ),
      body: FutureBuilder<List<Question>>(
        future: _initQuestions,
        builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            _question = snapshot.data[_index];
            log('---snapshot---');
            log(_question.question);
            children = <Widget>[
              new TextUtils('Question #${_index + 1}', color: Colors.grey[900]),
              new TextUtils('Score : $_score / $_index', color: Colors.grey[900]),
              new Card(
                elevation: 8,
                child: new Container(
                  height: size,
                  width: size,
                  child: Image.asset('assets/${_question.image}'),
                ),
              )
            ];
          } else if (snapshot.hasError) {
            log(snapshot.toString());
            log(snapshot.error.toString());
            children = <Widget>[
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
          } else {
            children = const <Widget>[
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

          return new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: children
              )
          );
        },
      )
    );
  }

}
