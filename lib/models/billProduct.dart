class BillProduct {
  int productId;
  double unitPriceBeforeDiscount;
  double unitPrice;
  int quantity;
  double unitPriceIncTax;

  BillProduct({
    this.productId,
    this.unitPriceBeforeDiscount,
    this.unitPrice,
    this.quantity,
    this.unitPriceIncTax,
  });

  BillProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    unitPriceBeforeDiscount = json['unit_price_before_discount'];
    unitPrice = json['unit_price'];
    quantity = double.tryParse(json['quantity'].toString()).round();
    unitPriceIncTax = double.tryParse(json['unit_price_inc_tax'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['unit_price_before_discount'] = this.unitPriceBeforeDiscount;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['unit_price_inc_tax'] = this.unitPriceIncTax;
    return data;
  }
}
