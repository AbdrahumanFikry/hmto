class Answer {
  int questionId;
  String answer;

  Answer({
    this.questionId,
    this.answer,
  });
  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    return data;
  }
}
