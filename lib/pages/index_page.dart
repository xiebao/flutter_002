import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/index.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1134)..init(context);

    return Provide<IndexProvide>(builder: (countext, child, indexProvide) {
      int currentIndex = indexProvide.currentIndex;
      return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomTabs,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => indexProvide.changeIndex(index),
        ),
      );
    });
  }
}
