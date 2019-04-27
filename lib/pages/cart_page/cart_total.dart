import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';

import '../../model/cart_goods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants.dart';

class CartItem extends StatelessWidget {
  final CartGoodsModel cart;

  CartItem(this.cart);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(15, 10, 10, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Constants.BorderColor)),
      ),
      child: Row(
        children: <Widget>[
          _checkBtn(),
          _goodsPic(cart.images),
          _goodsName(cart.goodsName),
          _goodsPrices(cart.price, cart.price)
        ],
      ),
    );
  }

  Widget _checkBtn() {
    return Container(
      width: ScreenUtil().setWidth(80),
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  Widget _goodsPic(String url) {
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Image.network(url),
    );
  }

  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(280),
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.topLeft,
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(32),
        ),
      ),
    );
  }

  Widget _goodsPrices(num pirice1, num pirice2) {
    return Container(
      width: ScreenUtil().setWidth(170),
      height: ScreenUtil().setHeight(150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "￥ $pirice1",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            "￥ $pirice2",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(21),
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: InkWell(
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
