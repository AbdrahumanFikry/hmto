class FieldForceSeniorTargetModel {
  String message;
  Data data;

  FieldForceSeniorTargetModel({this.message, this.data});

  FieldForceSeniorTargetModel.fromJson(Map<String, dynamic> json) {
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
  String totalVisitedPer;
  String totalnewStorePer;

  Data({this.totalVisitedPer, this.totalnewStorePer});

  Data.fromJson(Map<String, dynamic> json) {
    totalVisitedPer = json['TotalVisitedPer'];
    totalnewStorePer = json['TotalnewStorePer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalVisitedPer'] = this.totalVisitedPer;
    data['TotalnewStorePer'] = this.totalnewStorePer;
    return data;
  }
}