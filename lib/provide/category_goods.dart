import 'package:flutter/material.dart';
import '../model/category_goods_model.dart';

class CategoryGoodsProvide extends ChangeNotifier {
  List<CategoryGoods> goodsList = [];

  void getGoodsList(List<CategoryGoods> list) {
    goodsList = list;
    notifyListeners();
  }

  void addGoodsList(List<CategoryGoods> newList) {
    goodsList.addAll(newList);
    notifyListeners();
  }
}
