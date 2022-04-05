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
  final _interestsController = TextEditingController();
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
                        border: OutlineInputBorder(), labelText: "Name")),
                SizedBox(
                  height: 25,
                ),

                // EMAIL FORM
                TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Please enter a valid email ID";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email")),
                SizedBox(
                  height: 25,
                ),

                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
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
                              labelText: "Password")),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _confirmpassController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != _passController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Confirm Password")),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                    controller: _interestsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input at least 1 interest';
                      } else if (value.split(",").length > 3) {
                        return 'Maximum interests: 3, Inputted interests: ${value.split(",").length}';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:
                            "What are your interests? (write at most 3 interests separated by commas (',')")),

                // MOCK CHECKBOX
                Row(
                  children: [
                    Checkbox(
                        value: _mockcheckbox,
                        onChanged: (bool? value) {
                          setState(() {
                            _mockcheckbox = value!;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Create as mock account")
                  ],
                ),

                // SUBMIT BUTTON
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Checking details...')));
                        }

                        getRegisterCheck(
                            _emailController.text,
                            _passController.text,
                            _namecontroller.text,
                            _mockcheckbox.toString(),
                            _interestsController.text
                                .split(",")
                                .map((e) => e.trim())
                                .toList());
                      },
                      child: Text("Submit")),
                ),
              ],
            )),
      );

  Future<http.Response> getRegisterCheck(
      email, pass, name, mock, interests) async {
    Map<String, String> useHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    };

    var response = await http.post(Uri.parse('/api/register'),
        body: jsonEncode(
          {
            "email": email,
            "name": name,
            "password": pass,
            "mock": mock,
            "profileData": {"interests": interests}
          },
        ),
        headers: useHeaders);

    return response;
  }
}
