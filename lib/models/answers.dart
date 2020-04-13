class Answer {
  int questionId;
  String answer;

  Answer({
    this.questionId,
    this.answer,
  });
  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    return data;
  }
}
