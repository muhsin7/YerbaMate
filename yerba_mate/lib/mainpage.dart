import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'sharedservice.dart';
import 'usercard.dart';

class HomePage extends StatefulWidget {
  static const String route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Yerba Mate"),
      ),
      body: Center(
          child: Column(
        children: [Text("nothing to see here")],
      )),
    );
  }

  // getFrontPageBody() async {
  //   bool _logged = await SharedService.isLoggedIn();
  //   if(_logged){
  //         //
  //   }
  //   else {
  //       return TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), child: Text("hello"),);
  //   }
  // }
}
