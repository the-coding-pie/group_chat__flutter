import 'package:flutter/material.dart';
import 'package:group_chat/constants.dart';
import 'package:group_chat/widgets/button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRed,
      
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
      //animation
      SizedBox(
        width: 250.0,
        child: TypewriterAnimatedTextKit(
          speed: Duration(milliseconds: 500),
          isRepeatingAnimation: true,
          totalRepeatCount: 100,
      textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart ,
          text: ['Group Chat'],
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 45.0,
          ),
      
        
        ),
      ),
      SizedBox(height: kBoxHeight + 5,),
            //login button
          Button(
            backgroundColor: Colors.white,
            text: "Login",
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            textColor: Colors.black
          ),
            //register button
          SizedBox(height: kBoxHeight,),
            Button(
            backgroundColor: Colors.blue,
            text: "Register",
            onPressed: () {
               Navigator.pushNamed(context, '/register');
            },
            textColor: Colors.white
          ),
            ],
          ),
        ),
    );
  }
}

