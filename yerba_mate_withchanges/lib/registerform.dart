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
  final _confirmpassController = TextEditingController();
  final _namecontroller = TextEditingController();
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
          // NAME FORM
            TextFormField(
              controller: _namecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name"
              )),
              SizedBox(height: 25,),

          // EMAIL FORM
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

          // PASSWORD FORM
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: _passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password"
              )),
              SizedBox(height: 25,),

            // CONFIRM PASS FORM
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              controller: _confirmpassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  else if(value != _passController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password"
              )),


              // MOCK CHECKBOX
              Row(
              children: [
                Checkbox(value: _mockcheckbox, onChanged: (bool? value) { setState(() {
                  _mockcheckbox = value!; 
                }); }),
                SizedBox(width: 10,),
                Text("Create as mock account")
              ],
            ),


            // SUBMIT BUTTON
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                onPressed: () {
                if(_formkey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checking details...'))
                  );
                }
                getRegisterCheck(_emailController.text, _passController.text, _namecontroller.text, _mockcheckbox.toString());
              }, child: Text("Submit")
              ),),
        ],
      )
    ),
  );

    Future<http.Response> getRegisterCheck(email, pass, name, mock) async {
        Map<String, String> useHeaders = { 
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                  };

        var response = await http.post(
          Uri.parse('/api/register'),
          body: jsonEncode(
            {
            "email": email,
            "name": name,
            "password": pass,
            "mock": mock
          },
          ),
          headers: useHeaders
        );

        return response;
    }
}
