class StartDayData {
  List<CarProduct> productsInOwnCar;
  int ownMoney;
  bool productTransferredToday;
  int locationId;

  StartDayData(
      {this.productsInOwnCar,
      this.ownMoney,
      this.productTransferredToday,
      this.locationId});

  StartDayData.fromJson(Map<String, dynamic> json) {
    if (json['products_in_own_car'] != null) {
      productsInOwnCar = new List<CarProduct>();
      json['products_in_own_car'].forEach((v) {
        productsInOwnCar.add(new CarProduct.fromJson(v));
      });
    }
    ownMoney = json['ownMoney'];
    productTransferredToday = json['product_transfered_today'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productsInOwnCar != null) {
      data['products_in_own_car'] =
          this.productsInOwnCar.map((v) => v.toJson()).toList();
    }
    data['ownMoney'] = this.ownMoney;
    data['product_transfered_today'] = this.productTransferredToday;
    data['location_id'] = this.locationId;
    return data;
  }
}

class CarProduct {
  int productId;
  String productName;
  String serialNumber;
  int quantity;
  double priceForEach;
  List<GroupPriceStartDay> groupPrice;

  CarProduct(
      {this.productId,
      this.productName,
      this.serialNumber,
      this.quantity,
      this.priceForEach,
      this.groupPrice});

  CarProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    serialNumber = json['Sku'];
    quantity = double.tryParse(json['quantity'].toString()).round();
    priceForEach = double.tryParse(json['default_sell_price'].toString());
    if (json['group_price'] != null) {
      groupPrice = new List<GroupPriceStartDay>();
      json['group_price'].forEach((v) {
        groupPrice.add(new GroupPriceStartDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['Sku'] = this.serialNumber;
    data['quantity'] = this.quantity;
    data['default_sell_price'] = this.priceForEach;
    if (this.groupPrice != null) {
      data['group_price'] = this.groupPrice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupPriceStartDay {
  int id;
  String priceGroupName;
  double priceIncTax;

  GroupPriceStartDay({this.id, this.priceGroupName, this.priceIncTax});

  GroupPriceStartDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceGroupName = json['price_group_name'];
    priceIncTax = double.tryParse(json['price_inc_tax'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price_group_name'] = this.priceGroupName;
    data['price_inc_tax'] = this.priceIncTax;
    return data;
  }
}
