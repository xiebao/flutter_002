import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../model/cart_goods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants.dart';

class CartCount extends StatelessWidget {
  final CartGoodsModel cartGoods;

  CartCount(this.cartGoods);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        TextEditingController(text: "${cartGoods.count}");

    return Container(
      height: ScreenUtil().setHeight(40),
      child: Row(
        children: <Widget>[
          _btn(
            text: "+",
            onTap: () {
              Provide.value<CartProvide>(context)
                  .addOrReduce(cartGoods.goodsId, "add");
            },
          ),
          _cartInput(context, _controller),
          // Container(
          //   width: ScreenUtil().setWidth(80),
          //   height: ScreenUtil().setHeight(40),
          //   child: Text(
          //     "${cartGoods.count}",
          //     style: TextStyle(
          //       fontSize: ScreenUtil().setSp(25),
          //     ),
          //   ),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 1, color: Constants.BorderColor),
          //   ),
          // ),
          _btn(
            text: "-",
            onTap: () {
              Provide.value<CartProvide>(context)
                  .addOrReduce(cartGoods.goodsId, "reduce");
            },
          ),
        ],
      ),
    );
  }

  //按钮
  Widget _btn({String text, Function onTap}) {
    return InkWell(
      splashColor: Colors.pink,
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(40),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(32),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Constants.BorderColor),
        ),
      ),
    );
  }

  // 购物车数量输入框
  Widget _cartInput(context, controller) {
    return Container(
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Constants.BorderColor),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(2),
          border: InputBorder.none,
        ),
        controller: controller,
        keyboardType: TextInputType.number,
        onSubmitted: (String str) {
          num val = num.tryParse(str).toInt(); //字符串转int
          if (val < 1) {
            val = 1;
          }
          // 修改购物车商品数量
          Provide.value<CartProvide>(context)
              .changGoodsCount(cartGoods.goodsId, val);
        },
      ),
    );
  }
}
