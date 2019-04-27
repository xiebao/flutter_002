import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../router/application.dart';
import '../config/constants.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    getHotGoodsFuture().then((val) {
      List<Map> newList = (val['data'] as List).cast();
      hotGoodsList.addAll(newList);
      // getHomePageFuture().then((val) {
      //   print(val);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getHomePageFuture(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              data = data['data'];
              List<Map> swiperDataList = (data['slides'] as List).cast();
              List<Map> navDataList = (data['category'] as List).cast();
              String bannerImage = data['advertesPicture']['PICTURE_ADDRESS'];
              String leaderPhone = data['shopInfo']['leaderPhone'];
              String leaderImage = data['shopInfo']['leaderImage'];
              List<Map> recommendList = (data['recommend'] as List).cast();

              String floor1Title =
                  data['floor1Pic']['PICTURE_ADDRESS']; //楼层1标题图片
              String floor2Title =
                  data['floor2Pic']['PICTURE_ADDRESS']; //楼层2标题图片

              List<Map> floor1List = (data['floor1'] as List).cast(); //楼层1商品列表
              List<Map> floor2List = (data['floor2'] as List).cast(); //楼层2商品列表

              return EasyRefresh(
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                    TopNavigator(navDataList: navDataList), // 分类导航栏
                    AdBanner(bannerImage: bannerImage), //广告图片
                    LeaderPhone(phone: leaderPhone, image: leaderImage), //联系店长
                    Recommend(recommendList: recommendList), //商品推荐
                    FloorGoods(
                        titleImg: floor1Title, dataList: floor1List), //楼层1
                    FloorGoods(
                        titleImg: floor2Title, dataList: floor2List), //楼层2
                    HotGoods(hotGoodsList: hotGoodsList), //热门商品
                  ],
                ),
                loadMore: () async {
                  await getHotGoodsFuture(page: page).then((val) {
                    List<Map> newList = (val['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newList);
                      page += 1;
                    });
                  });
                },
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载....',
                ),
              );
            } else {
              return Center(child: Text('加载中.....'));
            }
          }),
    );
  }
}

//轮播组件
class SwiperDiy extends StatelessWidget {
  final List<Map> swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill,
            ),
            onTap: () {
              Application.router.navigateTo(
                  context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
          );
        },
      ),
    );
  }
}

//  导航组件
class TopNavigator extends StatelessWidget {
  final List<Map> navDataList;

  TopNavigator({this.navDataList});

  Widget _gridViewItemUI(context, item) {
    return InkWell(
      onTap: () {
        print("导航组件");
        // Application.router.navigateTo(context, "/detail?id=${item['goodsId']}");
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navDataList.length > 10) {
      navDataList.removeRange(10, navDataList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(280),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navDataList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 广告banner
class AdBanner extends StatelessWidget {
  final String bannerImage;

  AdBanner({Key key, this.bannerImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(bannerImage),
    );
  }
}

//店长组件
class LeaderPhone extends StatelessWidget {
  final String image; //店长图片
  final String phone; //店长电话

  LeaderPhone({this.image, this.phone});

  void _launchURL() async {
    String url = "tel: $phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'count not lanch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(image),
      ),
    );
  }
}

//推荐组件
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: ScreenUtil().setHeight(356),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _list(),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      child: Text('商品推荐', style: TextStyle(color: Colors.pinkAccent)),
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  Widget _list() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _listImte(context, index);
        },
      ),
    );
  }

  Widget _listImte(BuildContext context, int index) {
    var recommendData = recommendList[index];
    return InkWell(
      onTap: () {
        print("点击了推荐商品");
        Application.router
            .navigateTo(context, "/detail?id=${recommendData['goodsId']}");
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1, color: Constants.BorderColor),
            top: BorderSide(width: 1, color: Constants.BorderColor),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              recommendData['image'],
            ),
            Text(
              "￥${recommendData['mallPrice']}",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "￥${recommendData['price']}",
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//楼层商品
class FloorGoods extends StatelessWidget {
  final String titleImg;
  final List dataList;

  FloorGoods({this.titleImg, this.dataList});

  Widget _title() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Image.network(this.titleImg),
    );
  }

  Widget _firstFloor(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(context, dataList[0]),
          Column(
            children: <Widget>[
              _goodsItem(context, dataList[1]),
              _goodsItem(context, dataList[2]),
            ],
          )
        ],
      ),
    );
  }

  Widget _secondFloor(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(context, dataList[3]),
          _goodsItem(context, dataList[4]),
        ],
      ),
    );
  }

  Widget _goodsItem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        child: Image.network(goods['image']),
        onTap: () {
          // print('点击了楼层商品');
          Application.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _title(),
          _firstFloor(context),
          _secondFloor(context),
        ],
      ),
    );
  }
}

class HotGoods extends StatefulWidget {
  final List<Map> hotGoodsList;

  HotGoods({Key key, this.hotGoodsList}) : super(key: key);

  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  //火爆标题
  Widget _hotTitile() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.only(top: 2, bottom: 2),
      child: Text(
        "火爆专区",
        style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _hotGoods(BuildContext context, Map item) {
    Widget _priceWidget = Container(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text("￥${item['mallPrice']}"),
          Container(width: ScreenUtil().setWidth(70)),
          Text(
            "￥${item['price']}",
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        print("点击了热门商品");
        Application.router.navigateTo(context, "/detail?id=${item['goodsId']}");
      },
      child: Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(372),
        child: Column(
          children: <Widget>[
            Image.network(
              "${item['image']}",
              width: ScreenUtil().setWidth(375),
            ),
            Text(
              "${item['name']}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil().setSp(26),
              ),
            ),
            _priceWidget, //价格组件
          ],
        ),
      ),
    );
  }

  Widget _wrapList() {
    if (widget.hotGoodsList.length > 0) {
      return Container(
        child: Wrap(
          spacing: 3,
          children: widget.hotGoodsList
              .map((item) => _hotGoods(context, item))
              .toList(),
        ),
      );
    } else {
      return Text(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitile(),
          _wrapList(),
        ],
      ),
    );
  }
}
