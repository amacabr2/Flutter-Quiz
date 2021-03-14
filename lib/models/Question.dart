class Question {
  String question;
  bool response;
  String explanation;
  String image;

  Question(this.question, this.response, this.explanation, this.image);

  bool goodResponse(bool response) => this.response == response;
}