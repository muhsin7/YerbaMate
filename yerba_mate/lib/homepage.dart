import 'package:flutter/material.dart';
import 'package:yerba_mate/profiles.dart';
import 'package:yerba_mate/usercard.dart';
import 'loginpage.dart';
import 'sharedservice.dart';
import 'usermodel.dart';

class HomePage extends StatefulWidget {
  static const String route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<User> users = hardcodedUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Yerba Mate"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
              icon: Icon(Icons.person)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            users.isEmpty
                ? Center(
                    child: Align(
                    child: Text("No users left to see"),
                    alignment: Alignment.center,
                  ))
                : Stack(
                    children: users.map(buildUser).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildUser(User user) {
    makeButton(Color col, IconData icn) => RawMaterialButton(
          padding: EdgeInsets.all(15),
          onPressed: () {
            setState(() => users.remove(user));
            // print("test");
          },
          child: Icon(
            icn,
            size: 30,
            color: col,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          hoverColor: Colors.green.withOpacity(0.7),
        );

    return Column(children: [
      UserCard(user: user),
      Container(
          padding: EdgeInsets.all(15),
          child: Center(
              child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeButton(Colors.blue, Icons.favorite),
                      makeButton(Colors.red, Icons.close),
                    ],
                  )))),
    ]);
  }
}
