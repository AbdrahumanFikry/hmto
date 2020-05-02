class ReturnedProduct {
  int productId;
  int quantity;

  ReturnedProduct({
    this.productId,
    this.quantity,
  });

  ReturnedProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = double.tryParse(json['quantity_returned'].toString()).round();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity_returned'] = this.quantity;
    return data;
  }
}
