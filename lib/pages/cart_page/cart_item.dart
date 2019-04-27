import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../../model/cart_goods.dart';
import '../../provide/cart.dart';
import 'cart_count.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/application.dart';
import '../../config/constants.dart';

class CartItem extends StatelessWidget {
  final CartGoodsModel cart;

  CartItem(this.cart);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Constants.BorderColor)),
      ),
      child: Row(
        children: <Widget>[
          _checkBtn(context, cart),
          _goodsPic(context, cart),
          _goodsName(cart),
          _goodsPrices(context, cart)
        ],
      ),
    );
  }

  Widget _checkBtn(BuildContext context, CartGoodsModel item) {
    return Container(
      width: ScreenUtil().setWidth(60),
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheck(item);
        },
      ),
    );
  }

  Widget _goodsPic(context, CartGoodsModel cart) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${cart.goodsId}");
      },
      child: Container(
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(135),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
        ),
        child: Image.network(cart.images),
      ),
    );
  }

  Widget _goodsName(CartGoodsModel cart) {
    return Container(
      width: ScreenUtil().setWidth(280),
      height: ScreenUtil().setHeight(135),
      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            cart.goodsName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(27),
            ),
          ),
          CartCount(cart),
        ],
      ),
    );
  }

  Widget _goodsPrices(BuildContext context, CartGoodsModel item) {
    num pirice1 = item.price;
    num pirice2 = item.price;
    return Container(
      width: ScreenUtil().setWidth(170),
      height: ScreenUtil().setHeight(135),
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
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .removeCartGoods(item.goodsId);
              },
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
