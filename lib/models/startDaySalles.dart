class StartDayData {
  List<CarProduct> productsInOwnCar;
  int ownMoney;
  bool productTransferredToday;

  StartDayData({
    this.productsInOwnCar,
    this.ownMoney,
    this.productTransferredToday,
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
  }
}

class CarProduct {
  int productId;
  String productName;
  String serialNumber;
  String quantity;
  String priceForEach;

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
    quantity = json['quantity'];
    priceForEach = json['default_sell_price'];
  }
}
