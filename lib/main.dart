import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/constants.dart';
import 'package:news_application/cubit/observer.dart';
import 'package:news_application/dio_helper.dart';
import 'package:news_application/route_generator.dart';
import 'package:news_application/screens/article.dart';
import 'package:news_application/screens/home.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        BotToast.showSimpleNotification(
            title: message['notification']['title'],
            subTitleStyle: TextStyle(color: Constants.primaryColor),
            subTitle: message['notification']['body'],
            duration: Duration(seconds: 10),
          onTap: (){
            Navigator.of(context).pushNamed('/article',arguments: '1');
          }
        );


      },
      //print("articleId: " + message['data']['article_id']);
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
         // Navigator.of(context).push(MaterialPageRoute(builder:(context) =>
         //     ArticleScreen('1')
         // ));
        Navigator.of(context).pushNamed('/article',
            arguments: '56'
        );
      },
    );
  }

  // static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  //   if (message.containsKey('data')) {
  //     // Handle data message
  //     final dynamic data = message['data'];
  //   }
  //
  //   if (message.containsKey('notification')) {
  //     // Handle notification message
  //     final dynamic notification = message['notification'];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
          primaryColor: Constants.primaryColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
          textTheme: GoogleFonts.merriweatherSansTextTheme(
            Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
      ),
      home: Builder(
        builder: (context) => HomeScreen(),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}



