import 'package:flutter/material.dart';
import '../model/goods_detail_model.dart';
import '../service/service_method.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel goodsModel;
  String barState = "详情";

  setGoodsModel(String id) async {
    if (id == null) return;

    await getGoodsInfoFuture(id).then((val) {
      goodsModel = GoodsDetailModel.fromJson(val);

      notifyListeners();
    });
  }

  changeBarState(String state) {
    barState = state;
    notifyListeners();
  }
}
