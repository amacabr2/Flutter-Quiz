import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_quizz/models/Question.dart';

Future<String> getJson() {
  return rootBundle.loadString('assets/questions.json');
}

class QuestionFactory {
  static Future<List<Question>> get questions {
    return getJson().then((String data) {
      Iterable questionsData = jsonDecode(data);
      return List<Question>.from(questionsData.map((json) => new Question(
          json['question'],
          json['response'],
          json['explanation'],
          json['image']
      )).toList());
    });
  }
}