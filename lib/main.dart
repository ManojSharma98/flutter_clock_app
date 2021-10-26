import 'package:clockappflutter/enums.dart';
import 'package:clockappflutter/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  var initialzationSettingsIOS= IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (int? id,String? title,String? body,String? payload) async{});

  var initializationSettings=InitializationSettings(
      android: initializationSettingsAndroid,iOS: initialzationSettingsIOS
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async{
    if(payload!=null){
      debugPrint('notification payload: '+payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
          create: (context)=>MenuInfo(MenuType.clock),
          child: HomePage()),
    );
  }
}

