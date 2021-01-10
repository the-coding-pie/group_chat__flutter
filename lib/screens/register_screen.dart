import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/constants.dart';
import 'package:group_chat/widgets/button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        backgroundColor: Colors.blue,
        title: Text(
          "Register",
        ),
      ),
      body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.blue,
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        borderSide: BorderSide(color: Colors.blue, width: 2.0),),
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
        borderSide: BorderSide(color: Colors.blue, width: 2.0),),
                      )),
                  SizedBox(
                    height: kBoxHeight + 5.0,
                  ),
                  Button(
                    text: "Register",
                    textColor: Colors.white,
                    backgroundColor: Colors.blue,
                   height: 50.0,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        //if valid
                        setState(() {
                          _saving = true;
                        });
                        //signin
                        AuthResult result =
                            await _auth.createUserWithEmailAndPassword(
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

