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
}

class Data {
  int id;
  String name;
  String username;
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
}

class Analysis {
  String visited;
  String newStorePer;
  String targetPer;

  Analysis({this.visited, this.newStorePer, this.targetPer});

  Analysis.fromJson(Map<String, dynamic> json) {
    visited = double.tryParse(json['Visited']).round().toString();
    newStorePer = json['newStorePer'];
    targetPer = json['TargetPer'];
  }
}
