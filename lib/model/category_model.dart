class CategoryModel {
  String code;
  String message;
  List<Category> categoryList;

  CategoryModel({this.code, this.message, this.categoryList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      categoryList = new List<Category>();
      json['data'].forEach((v) {
        categoryList.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.categoryList != null) {
      data['data'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String mallCategoryId;
  String mallCategoryName;
  List<SubCategory> subCategoryList;
  Null comments;
  String image;

  Category(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.subCategoryList,
      this.comments,
      this.image});

  Category.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      subCategoryList = new List<SubCategory>();
      json['bxMallSubDto'].forEach((v) {
        subCategoryList.add(new SubCategory.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.subCategoryList != null) {
      data['bxMallSubDto'] =
          this.subCategoryList.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class SubCategory {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  SubCategory(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  SubCategory.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}
