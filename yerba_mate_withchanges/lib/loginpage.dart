import 'loginform.dart';
import 'registerform.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/login";


  @override
  State<StatefulWidget> createState() => _LoginPageState();

  }

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: Text("Login/Register"),
        bottom: TabBar(
          tabs: [
            Padding(padding: EdgeInsets.all(20), child: Text("Login"),),
            Padding(padding: EdgeInsets.all(20), child: Text("Register"),)
          ],
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: TabBarView(
            children: [
              Column( children: [ LoginForm() ], ),
              Column( children: [ RegisterForm() ],)
              ],
               )
            )
          )
    ));
  }
}
