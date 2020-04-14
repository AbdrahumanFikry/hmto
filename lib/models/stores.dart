class Stores {
  List<Data> data;

  Stores({this.data});

  Stores.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int id;
  int businessId;
  String type;
  String storeName;
  String customerName;
  String mobile;
  String alternateName;
  String alternateNumber;
  String landmark;
  String lat;
  String long;
  int rate;
  String imageIn;
  String imageOut;
  String imageStoreAds;
  String imageStoreFront;
  bool isVisited;

  Data(
      {this.id,
      this.businessId,
      this.type,
      this.storeName,
      this.customerName,
      this.mobile,
      this.alternateName,
      this.alternateNumber,
      this.landmark,
      this.lat,
      this.long,
      this.rate,
      this.imageIn,
      this.imageOut,
      this.imageStoreAds,
      this.imageStoreFront,
      this.isVisited});

  Data.fromJson(Map<String, dynamic> json) {
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
    rate = json['rate'];
    imageIn = json['image_in'];
    imageOut = json['image_out'];
    imageStoreAds = json['image_storeAds'];
    imageStoreFront = json['image_storeFront'];
    isVisited = json['is_visited'];
  }
}
