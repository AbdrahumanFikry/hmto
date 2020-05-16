class DebitInvoicesModel {
  List<DebitInvoice> data;

  DebitInvoicesModel({this.data});

  DebitInvoicesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DebitInvoice>();
      json['data'].forEach((v) {
        data.add(new DebitInvoice.fromJson(v));
      });
    }
  }
}

class DebitInvoice {
  int transactionId;
  int locationId;
  String finalTotal;
  String totalBeforeTax;
  String taxAmount;
  String amountPaid;
  int amountMustBePaid;

  DebitInvoice(
      {this.transactionId,
      this.locationId,
      this.finalTotal,
      this.totalBeforeTax,
      this.taxAmount,
      this.amountPaid,
      this.amountMustBePaid});

  DebitInvoice.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    locationId = json['location_id'];
    finalTotal = json['final_total'];
    totalBeforeTax = json['total_before_tax'];
    taxAmount = json['tax_amount'];
    amountPaid = json['amout_paid'];
    amountMustBePaid = json['amout_must_be_paid'];
  }
}
