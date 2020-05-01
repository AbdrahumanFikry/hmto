class OldInvoices {
  List<InvoiceData> data;

  OldInvoices({this.data});

  OldInvoices.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<InvoiceData>();
      json['data'].forEach((v) {
        data.add(new InvoiceData.fromJson(v));
      });
    }
  }
}

class InvoiceData {
  int transactionId;
  int businessId;
  int locationId;
  int storeId;
  String storeName;
  String finalTotal;
  List<Products> products;

  InvoiceData({
    this.transactionId,
    this.businessId,
    this.locationId,
    this.storeId,
    this.storeName,
    this.finalTotal,
    this.products,
  });

  InvoiceData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    businessId = json['business_id'];
    locationId = json['location_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    finalTotal = json['final_total'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  int id;
  String product;
  int quantity;
  String unitPrice;
  String quantityReturned;

  Products({
    this.id,
    this.product,
    this.quantity,
    this.unitPrice,
    this.quantityReturned,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    quantityReturned = json['quantity_returned'];
  }
}
