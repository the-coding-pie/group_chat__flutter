import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/constants.dart';
import 'package:group_chat/widgets/button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  TextEditingController _textController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _saving = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Login",
        ),
      ),
      body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: kRed,
          ),
          inAsyncCall: _saving,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email Please...";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),

                  //password
                  TextFormField(
                    controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password Please...";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: "Password",
                      )),
                  SizedBox(
                    height: kBoxHeight + 5.0,
                  ),
                  Button(
                    text: "Login",
                    textColor: Colors.white,
                    backgroundColor: kRed,
                   height: 50.0,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        //if valid
                        setState(() {
                          _saving = true;
                        });
                        //signin
                        AuthResult result =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        if (result.user != null) {
                          //take them to chat_screen
                          setState(() {
                            _saving = false;
                          });
                          Navigator.pushReplacementNamed(context, '/chat_screen');
                        } else {
                          _textController.clear();
                          _passwordController.clear();
                        }
                      }
                    },
                  
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

