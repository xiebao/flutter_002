import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';
import '../provide/cart.dart';
import '../model/cart_goods.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                _cartList(), // 购物车列表组件
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                ),
              ],
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  // 购物车列表组件
  Widget _cartList() {
    return Provide<CartProvide>(
      builder: (context, child, val) {
        List<CartGoodsModel> cartList = val.cartList;

        if (cartList.length > 0) {
          return Container(
            padding: EdgeInsets.only(bottom: 60),
            color: Colors.white,
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItem(cartList[index]);
              },
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            alignment: Alignment.center,
            child: Text(
              "暂无商品",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          );
        }
      },
    );
  }

  //获取购物车信息
  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
