import 'dart:developer';

class Question {
  String question;
  bool response;
  String explanation;
  String image;

  Question(this.question, this.response, this.explanation, this.image);

  Question.fromJson(json) {
    Question(
      json['question'],
      json['response'],
      json['explanation'],
      json['image'],
    );
  }
}