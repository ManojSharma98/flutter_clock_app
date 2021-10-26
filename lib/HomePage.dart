import 'package:clockappflutter/clock_view.dart';
import 'package:clockappflutter/color/appcolor.dart';
import 'package:clockappflutter/data.dart';
import 'package:clockappflutter/enums.dart';
import 'package:clockappflutter/menu_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'ClockPage.dart';
import 'color/AlarmPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) => buildMenuMethod(currentMenuInfo)).toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context,MenuInfo value, Widget child){
                if(value.menuType==MenuType.clock) return ClockPage();
                else if(value.menuType==MenuType.alarm) return AlarmPage();
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuMethod(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context,MenuInfo value,Widget child){
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
          ),
            color: currentMenuInfo.menuType==value.menuType?menuBackgroundColor:Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {
              var menuInfo=Provider.of<MenuInfo>(context,listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource!,
                  scale: 1.5,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title!,
                  style: TextStyle(
                      fontFamily: 'avenir', color: Colors.white, fontSize: 14),
                ),
              ],
            ));
      },
    );
  }
}
