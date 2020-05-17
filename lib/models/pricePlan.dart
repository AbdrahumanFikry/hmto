class PriceTaxesPlan {
  List<GroupPrice> groupPrice;
  List<Taxes> taxes;

  PriceTaxesPlan({this.groupPrice, this.taxes});

  PriceTaxesPlan.fromJson(Map<String, dynamic> json) {
    if (json['group_price'] != null) {
      groupPrice = new List<GroupPrice>();
      json['group_price'].forEach((v) {
        groupPrice.add(new GroupPrice.fromJson(v));
      });
    }
    if (json['taxes'] != null) {
      taxes = new List<Taxes>();
      json['taxes'].forEach((v) {
        taxes.add(new Taxes.fromJson(v));
      });
    }
  }
}

class GroupPrice {
  int id;
  String name;

  GroupPrice({this.id, this.name});

  GroupPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Taxes {
  int id;
  String name;
  double amount;

  Taxes({this.id, this.name, this.amount});

  Taxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = double.tryParse(json['amount'].toString());
  }
}
