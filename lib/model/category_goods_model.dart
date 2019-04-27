class CategoryGoodsModel {
  String code;
  String message;
  List<CategoryGoods> categoryGoodsList;

  CategoryGoodsModel({this.code, this.message, this.categoryGoodsList});

  CategoryGoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      categoryGoodsList = new List<CategoryGoods>();
      json['data'].forEach((v) {
        categoryGoodsList.add(new CategoryGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.categoryGoodsList != null) {
      data['data'] = this.categoryGoodsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryGoods {
  String image;
  num oriPrice;
  num presentPrice;
  String goodsName;
  String goodsId;

  CategoryGoods(
      {this.image,
      this.oriPrice,
      this.presentPrice,
      this.goodsName,
      this.goodsId});

  CategoryGoods.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
