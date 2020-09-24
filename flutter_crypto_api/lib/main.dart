import 'package:flutter/material.dart';
import 'package:flutter_weather_api/UI/broadcast_page.dart';
import 'package:flutter_weather_api/UI/web_socket.dart';
import 'UI/web_socket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    WebSocket ws = WebSocket();

    return MaterialApp(
        title: 'Crypto Currency Tracker',
        theme: ThemeData(
            textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            )
          ),
          primaryColor: Color(0xffBB86FC),
          backgroundColor: Color(0xff121212),
          accentColor: Color(0xff03DAC6),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BroadCastPage(
          ws
        ));
  }
}
