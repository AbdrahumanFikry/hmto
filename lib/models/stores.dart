class Stores {
  List<StoresData> data;

  Stores({this.data});

  Stores.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<StoresData>();
      json['data'].forEach((v) {
        data.add(new StoresData.fromJson(v));
      });
    }
  }
}

class StoresData {
  int id;
  String storeName;
  String landmark;
  String lat;
  String long;
  String imageIn;
  String imageOut;
  String imageStoreAds;
  String imageStoreFront;
  String isVisited;

  StoresData(
      {this.id,
      this.storeName,
      this.landmark,
      this.lat,
      this.long,
      this.imageIn,
      this.imageOut,
      this.imageStoreAds,
      this.imageStoreFront,
      this.isVisited});

  StoresData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    landmark = json['landmark'];
    lat = json['lat'];
    long = json['long'];
    imageIn = json['image_in'];
    imageOut = json['image_out'];
    imageStoreAds = json['image_storeAds'];
    imageStoreFront = json['image_storeFront'];
    isVisited = json['is_visited'];
  }
}
