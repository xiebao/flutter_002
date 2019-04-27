import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail_provide.dart';

class GoodsDetailTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, goodsDetailProvide) {
        var data = Provide.value<GoodsDetailProvide>(context).goodsModel.data;
        if (data != null) {
          var goodInfo = data.goodsInfo;
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImg(goodInfo.image1),
                _goodsTitle(goodInfo.goodsName),
                _goodsNumber(goodInfo.goodsSerialNumber),
                _goodsPrice(goodInfo.presentPrice, goodInfo.oriPrice),
              ],
            ),
          );
        } else {
          print("加载失败");
        }
      },
    );
  }

  // 商品图片
  Widget _goodsImg(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

// 商品标题
  Widget _goodsTitle(String title) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(10, 5, 5, 3),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(42),
          color: Colors.black,
        ),
      ),
    );
  }

  //商品编号
  Widget _goodsNumber(String num) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(10, 5, 5, 3),
      child: Text(
        "编号: $num",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Colors.grey,
        ),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(num price1, num price2) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              "￥ $price1",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                color: Colors.deepOrange,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 10),
            child: Text(
              "市场价:",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.black,
              ),
            ),
          ),
          Text(
            "￥ $price2",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(22),
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          )
        ],
      ),
    );
  }
}
