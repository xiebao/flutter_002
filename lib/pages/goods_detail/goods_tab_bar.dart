import 'package:flutter/material.dart';
import '../../provide/goods_detail_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(50),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              _tabBarItem(context, "详情"),
              _tabBarItem(context, "评论"),
            ],
          ),
        );
      },
    );
  }

  Widget _tabBarItem(BuildContext context, String barName) {
    bool isSelected =
        Provide.value<GoodsDetailProvide>(context).barState == barName;

    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailProvide>(context).changeBarState(barName);
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: isSelected ? 2 : 1,
              color: isSelected ? Colors.pink : Colors.black26,
            ),
          ),
        ),
        child: Text(
          '$barName',
          style: TextStyle(
            color: isSelected ? Colors.pink : Colors.black,
            fontSize: ScreenUtil().setSp(31),
          ),
        ),
      ),
    );
  }
}
