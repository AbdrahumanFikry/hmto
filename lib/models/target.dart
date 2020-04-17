class TargetForceField {
  String message;
  Data data;

  TargetForceField({this.message, this.data});

  TargetForceField.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String targetPer;
  String visited;
  String newStorePer;

  Data({this.targetPer, this.visited, this.newStorePer});

  Data.fromJson(Map<String, dynamic> json) {
    targetPer = json['TargetPer'];
    visited = json['Visited'];
    newStorePer = json['newStorePer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TargetPer'] = this.targetPer;
    data['Visited'] = this.visited;
    data['newStorePer'] = this.newStorePer;
    return data;
  }
}