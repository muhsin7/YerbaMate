import 'package:flutter/material.dart';
import 'package:yerba_mate/usercard.dart';
import 'loginpage.dart';
import 'sharedservice.dart';

class HomePage extends StatefulWidget {
  static const String route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Yerba Mate"),
        actions: [
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), icon: Icon(Icons.person)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          
          UserCard(user: "Linus"),
        ],
      )),
    );
  }
}
