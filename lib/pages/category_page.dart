import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../router/application.dart';
import '../model/category_model.dart';
import '../model/category_goods_model.dart';
import '../provide/sub_category.dart';
import '../provide/category_goods.dart';
import '../config/constants.dart';
import '../service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftNav(),
            Column(children: <Widget>[
              RightNav(),
              GoodsListWidget(),
            ]),
          ],
        ),
      ),
    );
  }
}

//左边大类导航
class LeftNav extends StatefulWidget {
  LeftNavState createState() => LeftNavState();
}

class LeftNavState extends State<LeftNav> {
  List<Category> categoryList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategoryList();
    _getGoodsList();
  }

  //加载大类和小类列表
  void _getCategoryList([String categoryId = ""]) async {
    await getCatgoeryFuture().then(
      (val) {
        CategoryModel data = CategoryModel.fromJson(val);
        setState(() {
          categoryList = data.categoryList;
        });

        // 设置子类列表
        if (categoryId.isEmpty) {
          categoryId = categoryList[0].mallCategoryId;
        }

        Provide.value<SubCategoryProvide>(context).setChildCategoryList(
            categoryList[currentIndex].subCategoryList, categoryId);
      },
    );
  }

  //加载商品列表
  void _getGoodsList([String categoryId = "4"]) async {
    int page = 1;
    await getCategoryGoodsListFuture(categoryId, "", page).then(
      (val) {
        CategoryGoodsModel data = CategoryGoodsModel.fromJson(val);

        Provide.value<CategoryGoodsProvide>(context)
            .getGoodsList(data.categoryGoodsList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Constants.BorderColor),
        ),
      ),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return _leftInkWel(index);
        },
      ),
    );
  }

  Widget _leftInkWel(int index) {
    bool isClick = currentIndex == index;
    return InkWell(
      onTap: () {
        String categoryId = categoryList[index].mallCategoryId;
        _getCategoryList(categoryId); // 加载右边子分类
        _getGoodsList(categoryId); //加载分类商品列表
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20),
        height: ScreenUtil().setHeight(100),
        child: Text(
          '${categoryList[index].mallCategoryName}',
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(240, 240, 240, 1) : Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: Constants.BorderColor)),
        ),
      ),
    );
  }
}

// 右边nav
class RightNav extends StatefulWidget {
  _RightNavState createState() => _RightNavState();
}

class _RightNavState extends State<RightNav> {
  void _getGoodsListData(String categoryId, String categorySubId,
      {int page: 1}) async {
    await getCategoryGoodsListFuture(categoryId, categorySubId, page).then(
      (val) {
        CategoryGoodsModel data = CategoryGoodsModel.fromJson(val);
        List<CategoryGoods> goodsList = data.categoryGoodsList;
        Provide.value<CategoryGoodsProvide>(context).getGoodsList(goodsList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<SubCategoryProvide>(
        builder: (context, child, childCategory) {
      List<SubCategory> list = childCategory.subCategoryList;
      return Container(
        width: ScreenUtil().setWidth(550),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Constants.BorderColor, width: 1),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return _topNavItem(list[index], index);
          },
        ),
      );
    });
  }

  Widget _topNavItem(SubCategory subCategory, int index) {
    int currentIndex = Provide.value<SubCategoryProvide>(context).currentIndex;
    bool isCliked = currentIndex == index;
    return InkWell(
      onTap: () {
        Provide.value<SubCategoryProvide>(context).changeCurrentIndex(index);
        _getGoodsListData(
          subCategory.mallCategoryId,
          subCategory.mallSubId,
          page: 1,
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
        child: Text(
          subCategory.mallSubName,
          style: TextStyle(color: isCliked ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

// 分类商品列表
class GoodsListWidget extends StatefulWidget {
  _GoodsListWidgetState createState() => _GoodsListWidgetState();
}

class _GoodsListWidgetState extends State<GoodsListWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  var scrollController = ScrollController();

  // 商品图片
  Widget _goodsImage(CategoryGoods goods) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goods.image),
    );
  }

  //商品描述
  Widget _goodsInfo(CategoryGoods goods) {
    //商品标题
    Widget titleWidget = Container(
      width: ScreenUtil().setWidth(350),
      child: Text(
        '${goods.goodsName}',
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );

    //商品价格
    Widget priceWidget = Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(350),
      child: Row(
        children: <Widget>[
          Text(
            '价格:￥${goods.presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '￥${goods.oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );

    return Container(
      child: Column(
        children: <Widget>[
          titleWidget,
          priceWidget,
        ],
      ),
    );
  }

  Widget _goodsItem(BuildContext context, CategoryGoods goods) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${goods.goodsId}");
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Constants.BorderColor),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(goods),
            _goodsInfo(goods),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsProvide>(
      builder: (context, child, goodsListProvide) {
        try {
          if (Provide.value<SubCategoryProvide>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：${e}');
        }
        List<CategoryGoods> goodsList = goodsListProvide.goodsList;
        if (goodsList == null) {
          return Text("暂无数据");
        }
        return Container(
          width: ScreenUtil().setWidth(550),
          height: ScreenUtil().setHeight(820),

          // child: ListView.builder(
          //   itemCount: goodsList.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return _goodsItem(goodsList[index]);
          //   },
          // ),

          child: EasyRefresh(
            key: _easyRefreshKey,
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              bgColor: Colors.white,
              textColor: Colors.blue,
              moreInfoColor: Colors.pink,
              showMore: true,
              moreInfo: "加载中...",
              noMoreText: "",
              loadReadyText: "上拉加载",
            ),
            loadMore: () async {
              _getMoreList();
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: goodsList.length,
              itemBuilder: (BuildContext context, int index) {
                return _goodsItem(context, goodsList[index]);
              },
            ),
          ),
        );
      },
    );
  }

  void _getMoreList() async {
    String categoryId = Provide.value<SubCategoryProvide>(context).categoryId;
    String subId = Provide.value<SubCategoryProvide>(context).subId;
    int page = Provide.value<SubCategoryProvide>(context).page;

    await getCategoryGoodsListFuture(categoryId, subId, page).then((val) {
      // 加载数据
      CategoryGoodsModel model = CategoryGoodsModel.fromJson(val);

      if (model.categoryGoodsList == null) {
        return Fluttertoast.showToast(
          msg: "到底部了",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIos: 1,
          fontSize: ScreenUtil().setSp(36),
          textColor: Colors.white,
          backgroundColor: Colors.pink,
          gravity: ToastGravity.CENTER,
        );
      }
      Provide.value<CategoryGoodsProvide>(context)
          .addGoodsList(model.categoryGoodsList);
      // 增加页数
      page += 1;
      Provide.value<SubCategoryProvide>(context).setPage(page);
    });
  }
}
