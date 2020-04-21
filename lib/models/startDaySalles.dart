class SeniorStartDayModel {
  List<MyProduct> myProduct;
  List<MyProduct> productTransferToday;
  int ownMoney;

  SeniorStartDayModel(
      {this.myProduct, this.productTransferToday, this.ownMoney});

  SeniorStartDayModel.fromJson(Map<String, dynamic> json) {
    if (json['myProduct'] != null) {
      myProduct = new List<MyProduct>();
      json['myProduct'].forEach((v) {
        myProduct.add(new MyProduct.fromJson(v));
      });
    }
    if (json['productTransferToday'] != null) {
      productTransferToday = new List<MyProduct>();
      json['productTransferToday'].forEach((v) {
        productTransferToday.add(new MyProduct.fromJson(v));
      });
    }
    ownMoney = json['ownMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myProduct != null) {
      data['myProduct'] = this.myProduct.map((v) => v.toJson()).toList();
    }
    if (this.productTransferToday != null) {
      data['productTransferToday'] =
          this.productTransferToday.map((v) => v.toJson()).toList();
    }
    data['ownMoney'] = this.ownMoney;
    return data;
  }
}

class MyProduct {
  int productId;
  String productName;
  String sku;
  String quantity;
  String defaultSellPrice;

  MyProduct(
      {this.productId,
        this.productName,
        this.sku,
        this.quantity,
        this.defaultSellPrice});

  MyProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    sku = json['Sku'];
    quantity = json['quantity'];
    defaultSellPrice = json['default_sell_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['Sku'] = this.sku;
    data['quantity'] = this.quantity;
    data['default_sell_price'] = this.defaultSellPrice;
    return data;
  }
}