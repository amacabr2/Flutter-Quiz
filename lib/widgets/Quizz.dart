import 'package:flutter/material.dart';
import 'package:flutter_quizz/components/Button.dart';
import 'package:flutter_quizz/components/ErrorIcon.dart';
import 'package:flutter_quizz/components/LoadingIcon.dart';
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

  ElevatedButton _responseBtn(bool b) {
    return button(
        b ? "Vrai" : "False",
        b ? Colors.green : Colors.red,
        () => _dialog(b)
    );
  }

  Future<Null> _dialog (bool b) async {

  }

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
              ),
              new TextUtils(
                  _question.question,
                  color: Colors.grey[500],
                  textScaleFactor: 1.1
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _responseBtn(true),
                  _responseBtn(false),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = errorIcon(snapshot);
          } else {
            children = loadingIcon();
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
