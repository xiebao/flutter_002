import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Provide<CartProvide>(
        builder: (context, child, val) {
          return Row(
            children: <Widget>[
              _checkALL(context),
              _total(context),
              _goPayBtn(context),
            ],
          );
        },
      ),
    );
  }

  //全选
  Widget _checkALL(context) {
    return Container(
      width: ScreenUtil().setWidth(170),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(60),
            height: ScreenUtil().setHeight(150),
            margin: EdgeInsets.only(right: 10),
            child: Checkbox(
              value: Provide.value<CartProvide>(context).isCheckAll,
              activeColor: Colors.pink,
              onChanged: (bool val) {
                Provide.value<CartProvide>(context).changCheckAll(val);
              },
            ),
          ),
          Text(
            '全选',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  //合计金额
  Widget _total(BuildContext context) {
    double totalMoney = Provide.value<CartProvide>(context).totalMoney;

    return Container(
      height: ScreenUtil().setHeight(150),
      width: ScreenUtil().setWidth(400),
      padding: EdgeInsets.only(top: 10, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "合计:",
                style: TextStyle(fontSize: ScreenUtil().setSp(36)),
              ),
              Text(
                "￥ ${totalMoney.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          Text('满10元免配送费,预购免配送费'),
        ],
      ),
    );
  }

  // 结算按钮
  Widget _goPayBtn(BuildContext context) {
    int count = Provide.value<CartProvide>(context).totalCount;
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.redAccent,
      ),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(80),
      child: Text(
        '结算($count)',
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}
