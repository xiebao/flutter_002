import 'package:dio/dio.dart';
import '../config/service_url.dart';
import 'dart:io';
import 'dart:convert';

Future post(String url, {formData}) async {
  // print("开始查询:..............");
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.data.toString());
      return jsonData;

      // return response.data;
    } else {
      throw Exception("后端接口出现问题.请检查代码情况.....");
    }
  } catch (e) {
    print("Errot=======>$e");
  }
}

//首页内容接口
Future getHomePageFuture() async {
  print("首页内容接口:getHomePageFuture");
  String url = servicePath['homePageContext'];
  var formData = {'lon': '115.02932', 'lat': '35.76189'};
  return post(url, formData: formData);
}

//首页火爆商品列表接口
Future getHotGoodsFuture({int page = 1}) async {
  print("首页火爆商品列表接口:getHotGoodsFuture");
  String url = servicePath['homePageBelowConten'];
  var formData = {"page": page};
  return post(url, formData: formData);
}

//获取商品分类接口
Future getCatgoeryFuture() async {
  print("获取商品分类接口:getCatgoeryFuture");
  String url = servicePath['getCategory'];
  return post(url);
}

//分类商品列表
Future getCategoryGoodsListFuture(
  String categoryId,
  String categorySubId,
  int page,
) async {
  print("分类商品列表接口:getCategoryGoodsFuture");
  var data = {
    "categoryId": categoryId,
    "categorySubId": categorySubId,
    "page": page,
  };
  String url = servicePath['getMallGoods'];
  return post(url, formData: data);
}

// 商品详情
Future getGoodsInfoFuture(String id) async {
  print("商品详情接口");
  var data = {"goodId": id};
  String url = servicePath['getGoodDetailById'];
  return post(url, formData: data);
}
