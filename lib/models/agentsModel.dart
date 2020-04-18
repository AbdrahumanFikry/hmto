class AgentsModel {
  List<Data> data;

  AgentsModel({this.data});

  AgentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  Null username;
  String email;
  int businessId;
  Analysis analysis;

  Data(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.businessId,
        this.analysis});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    businessId = json['business_id'];
    analysis = json['analysis'] != null
        ? new Analysis.fromJson(json['analysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['business_id'] = this.businessId;
    if (this.analysis != null) {
      data['analysis'] = this.analysis.toJson();
    }
    return data;
  }
}

class Analysis {
  String visited;
  String newStorePer;
  String targetPer;

  Analysis({this.visited, this.newStorePer, this.targetPer});

  Analysis.fromJson(Map<String, dynamic> json) {
    visited = json['Visited'];
    newStorePer = json['newStorePer'];
    targetPer = json['TargetPer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Visited'] = this.visited;
    data['newStorePer'] = this.newStorePer;
    data['TargetPer'] = this.targetPer;
    return data;
  }
}