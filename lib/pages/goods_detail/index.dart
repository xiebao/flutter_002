import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail_provide.dart';
import 'goods_top.dart';
import 'goods_explain.dart';
import 'goods_tab_bar.dart';
import 'goods_web.dart';
import 'goods_bottom.dart';

class GoodsDetail extends StatelessWidget {
  final String goodsId;

  GoodsDetail(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getData(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(255, 228, 225, 1),
      body: FutureBuilder(
        future: _getData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    GoodsDetailTop(),
                    GoodsExplain(),
                    GoodsTabBar(),
                    GoodsWeb(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GoodsBottom(),
                ),
              ],
            );
          } else {
            return Text('加载中........');
          }
        },
      ),
    );
  }

  //加载数据
  Future _getData(BuildContext context) async {
    await Provide.value<GoodsDetailProvide>(context).setGoodsModel(goodsId);
    return '完成加载';
  }
}
