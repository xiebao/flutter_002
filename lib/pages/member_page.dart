import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "../config/constants.dart";

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会员中心"),
        centerTitle: true,
      ),
      backgroundColor: Constants.BackgroundColor,
      body: Container(
        child: ListView(
          children: <Widget>[
            _topHeader(),
            _myOrder(),
            _orderTypes(),
            _actionList(),
          ],
        ),
      ),
    );
  }

  // 头像和背景
  Widget _topHeader() {
    String userName = "Vincent.X";
    String backgroundImg =
        "http://img02.tooopen.com/images/20150521/tooopen_sy_125540478467.jpg";
    String userImg =
        "http://img3.duitang.com/uploads/blog/201405/27/20140527123126_Prsnd.thumb.700_0.jpeg";
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(400),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            child: ClipOval(
              child: Image.network(userImg),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              userName,
              style: TextStyle(fontSize: ScreenUtil().setSp(36)),
            ),
          )
        ],
      ),
    );
  }

  // 我的订单
  Widget _myOrder() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 2, color: Constants.BorderColor),
        ),
      ),
      child: ListTile(
        leading: Icon(IconData(0xe63a, fontFamily: Constants.IconFontFamily)),
        title: Text('我的订单'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  // 订单类型
  Widget _orderTypes() {
    Widget __orderTypeItem(String title, int codePoint) {
      return InkWell(
        onTap: () {
          print("点击了$title");
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  IconData(
                    codePoint,
                    fontFamily: Constants.IconFontFamily,
                  ),
                  size: ScreenUtil().setSp(50),
                ),
                margin: EdgeInsets.only(bottom: 10.0),
              ),
              Text(
                title,
                style: TextStyle(fontSize: ScreenUtil().setSp(25)),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(140),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          __orderTypeItem("待付款", 0xe67f),
          __orderTypeItem("待发货", 0xe600),
          __orderTypeItem("待收货", 0xe630),
          __orderTypeItem("待评价", 0xe63d),
        ],
      ),
    );
  }

  // 操作列表
  Widget _actionList() {
    Widget __item(int codePoint, String text) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Constants.BorderColor),
          ),
        ),
        child: ListTile(
          leading:
              Icon(IconData(codePoint, fontFamily: Constants.IconFontFamily)),
          title: Text(text),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print("点击了$text");
          },
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(10),
            color: Constants.BackgroundColor,
          ),
          __item(0xe62a, "领取优惠券"),
          __item(0xe62a, "已领取优惠券"),
          __item(0xe7a4, "收货地址"),
          Container(
            height: ScreenUtil().setHeight(10),
            color: Constants.BackgroundColor,
          ),
          __item(0xe6a6, "客服电话"),
          __item(0xe602, "关于我们"),
        ],
      ),
    );
  }
}
