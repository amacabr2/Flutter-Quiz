import 'package:flutter/material.dart';
import 'package:flutter_quizz/components/Button.dart';
import 'package:flutter_quizz/components/ErrorIcon.dart';
import 'package:flutter_quizz/components/LoadingIcon.dart';
import 'package:flutter_quizz/factories/QuestionFactory.dart';
import 'package:flutter_quizz/models/Question.dart';
import 'package:flutter_quizz/utils/TextUtils.dart';

const String GOOD_ASSETS = 'assets/true.png';
const String BAD_ASSETS = 'assets/false.png';

class Quizz extends StatefulWidget {
  Quizz({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  List<Question> _questions;
  Question _question;
  int _index = 0;
  int _score = 0;

  Future<Null> _finish() async {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) => new AlertDialog(
          title: new TextUtils(
            'Fin du quizz',
            color: Colors.deepPurpleAccent,
            textScaleFactor: 1.2,
            textAlign: TextAlign.center
          ),
          contentPadding: EdgeInsets.all(10),
          content: new TextUtils('Votre score : $_score / ${_index + 1}', color: Colors.grey[900]),
          actions: [
            button(
                'Terminer',
                Colors.deepPurpleAccent,
                () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                }
            ),
          ],
        ),
        barrierDismissible: false
    );
  }

  void _getNextQuestion() async {
    if (_index < _questions.length - 1) {
      _index++;
      setState(() {
        _question = _questions[_index];
      });
    } else {
      _finish();
    }
  }

  ElevatedButton _responseBtn(bool b) {
    return button(
        b ? "Vrai" : "False",
        b ? Colors.green : Colors.red,
        () => _dialog(b)
    );
  }

  Future<Null> _dialog (bool b) async {
    bool result = _question.goodResponse(b);
    if (result) {
      _score++;
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) => new SimpleDialog(
          title: TextUtils(
            result ? 'Bravo !' : 'Dommage :(',
            textScaleFactor: 1.4,
            color: result ? Colors.green : Colors.red,
          ),
          contentPadding: EdgeInsets.all(14),
          children: [
            new Image.asset(result ? GOOD_ASSETS : BAD_ASSETS, fit: BoxFit.cover),
            new Container(height: 20),
            new TextUtils(
                _question.explanation,
                textScaleFactor: 1.1,
                color: Colors.grey[900],
                textAlign: TextAlign.center
            ),
            new Container(height: 20),
            button(
                'Question suivante',
                Colors.green,
                () {
                  Navigator.pop(context);
                  _getNextQuestion();
                }
            )
          ],
        ),
        barrierDismissible: false
    );
  }

  @override
  Widget build(BuildContext context) {
    double size  = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: new TextUtils('Quizz | Partie'),
      ),
      body: FutureBuilder<List<Question>>(
        future: QuestionFactory.questions,
        builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            _questions = snapshot.data;
            _question = snapshot.data[_index];
            children = <Widget>[
              new TextUtils('Question #${_index + 1}', color: Colors.grey[900]),
              new TextUtils('Score : $_score / ${_index + 1}', color: Colors.grey[900]),
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
