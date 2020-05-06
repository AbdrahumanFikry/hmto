class SellsAgents {
  List<Data> data;

  SellsAgents({this.data});

  SellsAgents.fromJson(Map<String, dynamic> json) {
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
  String email;
  int businessId;
  double targetMonthlyBalance;
  double ownMonthlyBalance;
  double ownDailyBalance;

  Data(
      {this.id,
      this.name,
      this.email,
      this.businessId,
      this.targetMonthlyBalance,
      this.ownMonthlyBalance,
      this.ownDailyBalance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    businessId = json['business_id'];
    targetMonthlyBalance =
        double.tryParse(json['TargetMonthlyBalance'].toString());
    ownMonthlyBalance = double.tryParse(json['ownMonthlyBalance'].toString());
    ownDailyBalance = double.tryParse(json['ownDailyBalance'].toString());
  }
}
