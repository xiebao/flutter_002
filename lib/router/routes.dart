import 'package:fluro/fluro.dart';
import 'handler.dart';

class Routes {
  static String root = "/";

  static void configureRoutes(Router router) {
    // 404
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      print("404, 找不到路由 -_-!!! ");
    });

    // 商品详情
    router.define("/detail", handler: detailHandler);

    // 购物车
    router.define("/cart", handler: cartHandler);
  }
}
