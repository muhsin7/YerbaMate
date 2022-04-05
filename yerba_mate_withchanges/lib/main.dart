import 'package:flutter/material.dart';
import 'package:yerba_mate/actionbuttons.dart';
import 'package:yerba_mate/sharedservice.dart';
import 'usercard.dart';
import 'loginpage.dart';
import 'homepage.dart';

Widget _homepage = LoginPage();

void main() async {
  bool _result = await SharedService.isLoggedIn();
    if (_result) {
      _homepage = const HomePage();
    }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        HomePage.route: (context) => _homepage,
        LoginPage.route: (context) => LoginPage()
      },
      debugShowCheckedModeBanner: false,
      title: 'Yerba Mate',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
    );
  }
}

