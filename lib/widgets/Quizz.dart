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
  final QuestionFactory _questionFactory = new QuestionFactory();
  Question _question;
  int _index = 0;
  int _score = 0;


  @override
  void initState() {
    super.initState();
    _question = _questionFactory.questions[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new TextUtils('Quizz | Partie'),
      ),
      body: new Center(
        child: Text('nouvelle page')
      ),
    );
  }

}
