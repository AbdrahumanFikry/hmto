class QuestionsList {
  bool success;
  List<Question> questions;
  String message;

  QuestionsList({this.success, this.questions, this.message});

  QuestionsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      questions = new List<Question>();
      json['data'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Question {
  int id;
  String name;
  String type;

  Question({
    this.id,
    this.name,
    this.type,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }
}
