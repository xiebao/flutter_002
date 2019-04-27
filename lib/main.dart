import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';
import 'provide/sub_category.dart';
import 'provide/category_goods.dart';
import 'provide/goods_detail_provide.dart';
import 'provide/cart.dart';
import 'provide/index.dart';

import './router/application.dart';

main(List<String> args) {
  //加载provide
  var providers = Providers();
  var counter = Counter();
  var childCategory = SubCategoryProvide();
  var goodsListProvide = CategoryGoodsProvide();
  var goodsDetailProvide = GoodsDetailProvide();
  var cartProvide = CartProvide();
  var indexProvide = IndexProvide();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<SubCategoryProvide>.value(childCategory))
    ..provide(Provider<CategoryGoodsProvide>.value(goodsListProvide))
    ..provide(Provider<GoodsDetailProvide>.value(goodsDetailProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<IndexProvide>.value(indexProvide));

  // 加载路由
  Application.initRouter();

  runApp(
    ProviderNode(
      child: Myapp(),
      providers: providers,
    ),
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        onGenerateRoute: Application.router.generator,
        title: "demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pinkAccent),
        home: IndexPage(),
      ),
    );
  }
}
