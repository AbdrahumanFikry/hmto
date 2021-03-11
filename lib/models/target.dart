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
  int target;
  int ownMonthlyBalance;
  int ownDailyBalance;
  int visitsTarget;
  int cashTarget;
  List<TargetProduct> targetProduct;

  TargetSells({
    this.target,
    this.ownMonthlyBalance,
    this.cashTarget,
    this.visitsTarget,
    this.ownDailyBalance,
    this.targetProduct,
  });

  TargetSells.fromJson(Map<String, dynamic> json) {
    target = json['Target'];
    ownMonthlyBalance = json['ownMonthlyBalance'];
    ownDailyBalance = json['ownDailyBalance'];
    cashTarget = json['Target_cash'];
    visitsTarget = json['target_visit'];
    if (json['TargetProduct'] != null) {
      targetProduct = new List<TargetProduct>();
      json['TargetProduct'].forEach((v) {
        targetProduct.add(new TargetProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Target'] = this.target;
    data['ownMonthlyBalance'] = this.ownMonthlyBalance;
    data['ownDailyBalance'] = this.ownDailyBalance;
    data['target_visit'] = this.visitsTarget;
    data['Target_cash'] = this.cashTarget;
    if (this.targetProduct != null) {
      data['TargetProduct'] =
          this.targetProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TargetProduct {
  int id;
  ProductName productName;
  String targetQuantity;
  String reachedQuantity;
  String targetReachedQuantityPercentage;
  String maximumBonusPrice;
  String currentBonus;

  TargetProduct(
      {this.id,
      this.productName,
      this.targetQuantity,
      this.reachedQuantity,
      this.targetReachedQuantityPercentage,
      this.maximumBonusPrice,
      this.currentBonus});

  TargetProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'] != null
        ? new ProductName.fromJson(json['product_name'])
        : null;
    targetQuantity = json['target_quantity'];
    reachedQuantity = json['reached_quantity'];
    targetReachedQuantityPercentage =
        json['target_reached_quantity_percentage'];
    maximumBonusPrice = json['maximum_bonus_price'];
    currentBonus = json['current_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productName != null) {
      data['product_name'] = this.productName.toJson();
    }
    data['target_quantity'] = this.targetQuantity;
    data['reached_quantity'] = this.reachedQuantity;
    data['target_reached_quantity_percentage'] =
        this.targetReachedQuantityPercentage;
    data['maximum_bonus_price'] = this.maximumBonusPrice;
    data['current_bonus'] = this.currentBonus;
    return data;
  }
}

class ProductName {
  int id;
  String name;
  String defaultSellPrice;

  ProductName({this.id, this.name, this.defaultSellPrice});

  ProductName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultSellPrice = json['default_sell_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['default_sell_price'] = this.defaultSellPrice;
    return data;
  }
}
