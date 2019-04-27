import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail_provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 商品详情
    var goodsDetail = Provide.value<GoodsDetailProvide>(context)
        .goodsModel
        .data
        .goodsInfo
        .goodsDetail;

    return Provide<GoodsDetailProvide>(
      builder: (context, child, goodsDetailProvide) {
        String barState = goodsDetailProvide.barState;

        if (barState == "详情") {
          return Container(
            // width: ScreenUtil().setWidth(750),
            child: Html(
              data: goodsDetail,
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(140),
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Text('暂无评论'),
          );
        }
      },
    );
  }
}
