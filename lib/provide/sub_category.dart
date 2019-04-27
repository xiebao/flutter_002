import 'package:flutter/material.dart';
import '../model/category_model.dart';

class SubCategoryProvide with ChangeNotifier {
  int page = 1;
  int currentIndex = 0;
  String categoryId = "4";
  String subId = "";
  List<SubCategory> subCategoryList = [];

  //点击大类时更换
  setChildCategoryList(List<SubCategory> list, String id) {
    page = 1;
    subId = ''; //点击大类时，把子类ID清空
    categoryId = id;
    currentIndex = 0;

    SubCategory all = SubCategory(); //"全部"子分类
    all.mallCategoryId = id;
    all.mallSubId = "";
    all.mallSubName = '全部';
    all.comments = 'null';

    subCategoryList = [all];
    subCategoryList.addAll(list);
    notifyListeners();
  }

  changeCurrentIndex(index) {
    page = 1;
    currentIndex = index;
    notifyListeners();
  }

  setPage(newPage) {
    page = newPage;
    notifyListeners();
  }
}
