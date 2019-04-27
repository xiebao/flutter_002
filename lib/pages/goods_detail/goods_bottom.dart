import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/goods_detail_provide.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../../router/application.dart';
import '../../provide/index.dart';

class GoodsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _cartBtn(context),
          _button(
            name: "加入购物车",
            bgColor: Colors.green,
            onTap: () {
              var goodsInfo = Provide.value<GoodsDetailProvide>(context)
                  .goodsModel
                  .data
                  .goodsInfo;

              String goodsId = goodsInfo.goodsId;
              String goodsName = goodsInfo.goodsName;
              String image = goodsInfo.image1;
              num price = goodsInfo.presentPrice;
              int count = 1;

              Provide.value<CartProvide>(context)
                  .join(goodsId, goodsName, image, price, count, true);

              return Fluttertoast.showToast(
                msg: "成功加入购物车",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIos: 1,
                fontSize: ScreenUtil().setSp(30),
                textColor: Colors.white,
                backgroundColor: Colors.pink,
                gravity: ToastGravity.CENTER,
              );
            },
          ),
          _button(
            name: "立即购买",
            bgColor: Colors.orange,
            onTap: () {
              Provide.value<CartProvide>(context).clean();
            },
          ),
        ],
      ),
    );
  }

  Widget _button({String name, Color bgColor, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setHeight(300),
        height: ScreenUtil().setHeight(70),
        alignment: Alignment.center,
        color: bgColor,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
      ),
    );
  }

  // 购物车按钮
  Widget _cartBtn(BuildContext context) {
    return Stack(children: <Widget>[
      InkWell(
        onTap: () {
          Provide.value<IndexProvide>(context).changeIndex(2);
          Navigator.pop(context);
        },
        child: Container(
          width: ScreenUtil().setWidth(110),
          height: ScreenUtil().setHeight(70),
          color: Colors.white,
          child: Icon(
            Icons.shopping_cart,
            color: Colors.red,
            size: 35,
          ),
        ),
      ),
      Provide<CartProvide>(
        builder: (context, child, cartProvide) {
          return Positioned(
            top: 0,
            right: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
              child: Text(
                "${cartProvide.totalCount}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(22),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.pink,
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0)),
            ),
          );
        },
      ),
    ]);
  }
}
