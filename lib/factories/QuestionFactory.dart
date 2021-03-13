import 'package:flutter_quizz/models/Question.dart';
import 'package:flutter_quizz/utils/StorageUtils.dart';

bool parseBool(String text) => text.toLowerCase() == 'true';

class QuestionFactory {
  final StorageUtils storage = new StorageUtils('questions.txt');
  List<Question> _questions;

  QuestionFactory() {
    storage.read().then((List<String>lines) => {
      lines.forEach((String line) {
        List<String> question = line.split(' | ');
        _questions.add(new Question(question[0], parseBool(question[1]), question[2], question[3]));
      })
    });
  }

  List<Question> get questions => _questions;
}