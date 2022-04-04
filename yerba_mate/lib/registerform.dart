import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {

  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}


class _RegisterFormState extends State<RegisterForm> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  var _namecontroller;
  bool _mockcheckbox = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(50),
    alignment: Alignment.center,
    child: Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            TextFormField(
              controller: _passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name"
              )),
              SizedBox(height: 25,),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if(!emailValid){
                return "Please enter a valid email ID";
              }
              return null;
            },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email"
              )),
              SizedBox(height: 25,),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: _passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password"
              )),
              SizedBox(height: 25,),

              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              controller: _namecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password"
              )),

              Row(
              children: [
                Checkbox(value: _mockcheckbox, onChanged: (bool? value) { setState(() {
                  _mockcheckbox = value!; 
                }); }),
                SizedBox(width: 10,),
                Text("Create as mock account")
              ],
            ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                onPressed: () {
                if(_formkey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checking details...'))
                  );
                }
                getLoginCheck(_emailController.text, _passController.text);
              }, child: Text("Submit")
              ),),
        ],
      )
    ),
  );

  Future<http.Response> getLoginCheck(email, pass) async {
      // var url ='localhost:3000/login';

      // Map data = {
      //   'email': email,
      //   'password': pass
      // };
      // //encode Map to JSON
      // var body = json.encode(data);

      print("REACHED HERE");
      // var response = await http.post(Uri.parse(url),
      //     headers: {
      //       "Content-Type": "application/json",
      //       "Access-Control-Allow-Origin": "*",
      //       "Access-Control-Allow-Methods": "GET, HEAD"},
      //     body: body,
      // );

      Map<String, String> useHeaders = { 
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
          };
      var response = await http.get(
        Uri.parse('http://localhost:3000/api/'),
        headers: useHeaders,
      );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
  }
}
