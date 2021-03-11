class DataForNewShop {
  bool success;
  Data data;
  String message;

  DataForNewShop({this.success, this.data, this.message});

  DataForNewShop.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  List<Competitors> competitors;
  List<Question> question;

  Data({this.competitors, this.question});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['competitors'] != null) {
      competitors = new List<Competitors>();
      json['competitors'].forEach((v) {
        competitors.add(new Competitors.fromJson(v));
      });
    }
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
  }
}

class Competitors {
  int competitorId;
  String name;
  String createdBy;

  Competitors({this.competitorId, this.name, this.createdBy});

  Competitors.fromJson(Map<String, dynamic> json) {
    competitorId = json['competitor_id'];
    name = json['name'];
    createdBy = json['created_by'];
  }
}

class Question {
  int id;
  String name;
  String type;
  List<dynamic> options;

  Question({
    this.id,
    this.name,
    this.type,
    this.options,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    options = (json['options'] == null || json['options'] == "")
        ? <dynamic>[]
        : json['options'];
  }
}
