import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_goods.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartGoodsModel> cartList = [];
  double totalMoney = 0;
  int totalCount = 0;
  bool isCheckAll = false;

  // 加入购物车 bak
  // join(String goodsId, String goodsName, String images, num price, int count,
  //     bool isCheck) async {
  //   SharedPreferences spf = await SharedPreferences.getInstance();
  //   cartString = spf.getString("cartInfo");
  //   var temp = cartString == null ? [] : json.decode(cartString);
  //   List<Map> tempList = (temp as List).cast();
  //   bool isHave = false;
  //   int ival = 0;
  //   tempList.forEach((item) {
  //     // 如果有数据
  //     if (item['goodsId'] == goodsId) {
  //       isHave = true;
  //       tempList[ival]["count"] += 1;
  //       cartList[ival].count += 1;
  //     }
  //   });
  //   // 如果没有数据
  //   if (!isHave) {
  //     Map<String, dynamic> newGoods = {
  //       "goodsId": goodsId,
  //       "goodsName": goodsName,
  //       "images": images,
  //       "price": price,
  //       "count": count,
  //       "isCheck": isCheck,
  //     };

  //     tempList.add(newGoods);
  //     cartList.add(new CartGoodsModel.fromJson(newGoods));
  //   }
  //   totalCount += count;
  //   totalMoney += (price * count);
  //   //持久化数据
  //   cartString = json.encode(tempList).toString();
  //   spf.setString("cartInfo", cartString);
  //   notifyListeners();
  // }

  // 加入购物车
  join(String goodsId, String goodsName, String images, num price, int count,
      bool isCheck) async {
    // 修改购物车列表
    bool isHave = false;
    cartList.forEach((item) {
      if (goodsId == item.goodsId) {
        item.count++;
        isHave = true;
      }
    });
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        "goodsId": goodsId,
        "goodsName": goodsName,
        "images": images,
        "price": price,
        "count": count,
        "isCheck": isCheck,
      };
      cartList.add(CartGoodsModel.fromJson(newGoods));
    }
    // 计算总价和总数量
    totalCount += count;
    totalMoney += (price * count);
    // 持久化购物车数据
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString("cartInfo", json.encode(cartList));

    notifyListeners();
  }

  // 增加减少商品数量
  addOrReduce(String goodsId, String todo) async {
    cartList.forEach((item) {
      if (item.goodsId == goodsId) {
        if (todo == "add") {
          item.count += 1;
        } else if (item.count > 1) {
          item.count -= 1;
        }
      }
    });
    _total();
    SharedPreferences spf = await SharedPreferences.getInstance();
    cartString = json.encode(cartList).toString();
    spf.setString("cartInfo", cartString);
    notifyListeners();
  }

  // 输入框修改数量
  changGoodsCount(String goodsId, int count) async {
    cartList.forEach((item) {
      if (item.goodsId == goodsId) {
        item.count = count;
      }
    });
    _total();
    SharedPreferences spf = await SharedPreferences.getInstance();
    cartString = json.encode(cartList).toString();
    spf.setString("cartInfo", cartString);
    notifyListeners();
  }

  // 删除购物车商品
  removeCartGoods(String goodsId) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    int delIndex = 0;
    int tempIndex = 0;
    bool isCheck = false;
    cartList.forEach((item) {
      if (item.goodsId == goodsId) {
        delIndex = tempIndex;
        isCheck = item.isCheck;
      }
      tempIndex++;
    });
    cartList.removeAt(delIndex);
    if (isCheck) _total(); // 如果商品是选中的,重新计算购物车总价和总数量
    if (cartList.length == 0) isCheckAll = false;
    cartString = json.encode(cartList).toString();
    spf.setString("cartInfo", cartString);
    notifyListeners();
  }

  // 清空购物车
  clean() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove("cartInfo");
    cartString = "[]";
    cartList = [];
    isCheckAll = false;
    totalCount = 0;
    totalMoney = 0;
    print("清空了购物车");
    notifyListeners();
  }

  //获取购物车信息
  getCartInfo() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    cartList = [];
    cartString = spf.getString("cartInfo");
    if (cartString == null) {
      cartList = [];
      isCheckAll = false;
    } else {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      tempList.forEach((item) {
        cartList.add(CartGoodsModel.fromJson(item));
      });
    }
    _total();
    notifyListeners();
  }

  // 勾选商品
  changeCheck(CartGoodsModel cartItem) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    cartList.forEach((item) {
      if (cartItem.goodsId == item.goodsId) {
        item.isCheck = cartItem.isCheck;
      }
    });
    if (!cartItem.isCheck) {
      isCheckAll = false;
    }
    _total(); // 如果商品是选中的,重新计算购物车总价和总数量
    cartString = json.encode(cartList).toString();
    spf.setString("cartInfo", cartString);
    notifyListeners();
  }

  changCheckAll(bool val) {
    isCheckAll = val;
    // 修改商品选中状态
    cartList.forEach((item) {
      item.isCheck = val;
    });
    // 计算总价和总数量
    if (val) {
      _total();
    } else {
      totalCount = 0;
      totalMoney = 0;
    }
    notifyListeners();
  }

  // 计算总价和总数量
  _total() {
    totalMoney = 0;
    totalCount = 0;
    int checkTrue = 0;
    cartList.forEach((item) {
      if (item.isCheck) {
        totalMoney += (item.count * item.price);
        totalCount += item.count;
        checkTrue += 1;
      }
    });
    if (checkTrue == cartList.length && checkTrue > 0) {
      isCheckAll = true;
    }
  }
}
