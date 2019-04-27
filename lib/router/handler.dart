import 'package:fluro/fluro.dart';
import '../pages/goods_detail/index.dart';
import '../pages/cart_page.dart';

Handler detailHandler = Handler(handlerFunc: (context, params) {
  String goodsId = params['id'].first;
  return GoodsDetail(goodsId);
});

Handler cartHandler = Handler(handlerFunc: (context, params) {
  return CartPage();
});
