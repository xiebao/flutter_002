class GoodsDetailModel {
  String code;
  String message;
  GoodsDetail data;

  GoodsDetailModel({this.code, this.message, this.data});

  GoodsDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new GoodsDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsDetail {
  AdvertesPicture advertesPicture;
  GoodInfo goodsInfo;
  List<String> goodComments;

  GoodsDetail({this.advertesPicture, this.goodsInfo, this.goodComments});

  GoodsDetail.fromJson(Map<String, dynamic> json) {
    advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;
    goodsInfo = json['goodInfo'] != null
        ? new GoodInfo.fromJson(json['goodInfo'])
        : null;
    goodComments = json['goodComments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    if (this.goodsInfo != null) {
      data['goodInfo'] = this.goodsInfo.toJson();
    }
    data['goodComments'] = this.goodComments;
    return data;
  }
}

class AdvertesPicture {
  String tOPLACE;
  String pICTUREADDRESS;

  AdvertesPicture({this.tOPLACE, this.pICTUREADDRESS});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    tOPLACE = json['TO_PLACE'];
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TO_PLACE'] = this.tOPLACE;
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    return data;
  }
}

class GoodInfo {
  String goodsId;
  int state;
  String comPic;
  String isOnline;
  int amount;
  String image2;
  String image1;
  num presentPrice;
  String shopId;
  String goodsDetail;
  num oriPrice;
  String image4;
  String image3;
  String goodsSerialNumber;
  String goodsName;
  String image5;

  GoodInfo(
      {this.goodsId,
      this.state,
      this.comPic,
      this.isOnline,
      this.amount,
      this.image2,
      this.image1,
      this.presentPrice,
      this.shopId,
      this.goodsDetail,
      this.oriPrice,
      this.image4,
      this.image3,
      this.goodsSerialNumber,
      this.goodsName,
      this.image5});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    state = json['state'];
    comPic = json['comPic'];
    isOnline = json['isOnline'];
    amount = json['amount'];
    image2 = json['image2'];
    image1 = json['image1'];
    presentPrice = json['presentPrice'];
    shopId = json['shopId'];
    goodsDetail = json['goodsDetail'];
    oriPrice = json['oriPrice'];
    image4 = json['image4'];
    image3 = json['image3'];
    goodsSerialNumber = json['goodsSerialNumber'];
    goodsName = json['goodsName'];
    image5 = json['image5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['state'] = this.state;
    data['comPic'] = this.comPic;
    data['isOnline'] = this.isOnline;
    data['amount'] = this.amount;
    data['image2'] = this.image2;
    data['image1'] = this.image1;
    data['presentPrice'] = this.presentPrice;
    data['shopId'] = this.shopId;
    data['goodsDetail'] = this.goodsDetail;
    data['oriPrice'] = this.oriPrice;
    data['image4'] = this.image4;
    data['image3'] = this.image3;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['goodsName'] = this.goodsName;
    data['image5'] = this.image5;
    return data;
  }
}
