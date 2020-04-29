class StartDayData {
  List<CarProduct> productsInOwnCar;
  int ownMoney;
  bool productTransferredToday;
  int locationId;

  StartDayData({
    this.productsInOwnCar,
    this.ownMoney,
    this.productTransferredToday,
    this.locationId,
  });

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
}

class CarProduct {
  int productId;
  String productName;
  String serialNumber;
  int quantity;
  double priceForEach;

  CarProduct({
    this.productId,
    this.productName,
    this.serialNumber,
    this.quantity,
    this.priceForEach,
  });

  CarProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    serialNumber = json['Sku'];
    quantity = double.tryParse(json['quantity'].toString()).round();
    priceForEach = double.tryParse(json['default_sell_price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['Sku'] = this.serialNumber;
    data['quantity'] = this.quantity;
    data['default_sell_price'] = this.priceForEach;
    return data;
  }
}
