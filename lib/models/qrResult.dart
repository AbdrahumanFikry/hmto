import '../models/dataForNewShop.dart';

class QrResult {
  StoreInfo storeInfo;
  List<Competitors> competitors;
  List<Question> question;

  QrResult({this.storeInfo, this.competitors, this.question});

  QrResult.fromJson(Map<String, dynamic> json) {
    storeInfo = json['storeInfo'] != null
        ? new StoreInfo.fromJson(json['storeInfo'])
        : null;
    if (json['competitors'] != null) {
      competitors = new List<Competitors>();
      json['competitors'].forEach((v) {
        competitors.add(new Competitors.fromJson(v));
      });
    }
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
  }
}

class StoreInfo {
  int id;
  int businessId;
  String type;
  String storeName;
  String customerName;
  String mobile;
  String alternateName;
  String alternateNumber;
  String landmark;
  String creditLimit;
  String lat;
  String long;
  int rate;
  String imageIn;
  String imageOut;
  String imageStoreAds;
  String imageStoreFront;
  String isVisited;

  StoreInfo(
      {this.id,
      this.businessId,
      this.type,
      this.storeName,
      this.customerName,
      this.mobile,
      this.alternateName,
      this.alternateNumber,
      this.creditLimit,
      this.landmark,
      this.lat,
      this.long,
      this.rate,
      this.imageIn,
      this.imageOut,
      this.imageStoreAds,
      this.imageStoreFront,
      this.isVisited});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    type = json['type'];
    storeName = json['store_name'];
    customerName = json['customer_name'];
    mobile = json['mobile'];
    alternateName = json['alternate_name'];
    alternateNumber = json['alternate_number'];
    landmark = json['landmark'];
    lat = json['lat'];
    long = json['long'];
    creditLimit = json['credit_limit'].toString();
    rate = json['rate'];
    imageIn = json['image_in'];
    imageOut = json['image_out'];
    imageStoreAds = json['image_storeAds'];
    imageStoreFront = json['image_storeFront'];
    isVisited = json['is_visited'];
  }
}
