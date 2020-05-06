class TargetForceField {
  String message;
  Data data;

  TargetForceField({this.message, this.data});

  TargetForceField.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
}

class TargetSells {
  String target;
  String completed;

  TargetSells({
    this.target,
    this.completed,
  });

  TargetSells.fromJson(Map<String, dynamic> json) {
    target = json['Target'];
    completed = json['targetCompleted'];
  }
}
