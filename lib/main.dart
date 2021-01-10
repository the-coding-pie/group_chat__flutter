import 'package:flutter/material.dart';
import 'package:group_chat/constants.dart';
import 'package:group_chat/screens/chat_screen.dart';
import 'package:group_chat/screens/home.dart';
import 'package:group_chat/screens/login_screen.dart';
import 'package:group_chat/screens/register_screen.dart';

void main() => runApp(GroupChat());

class GroupChat extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kRed,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/chat_screen': (context) => ChatScreen()
      },
    );
  }
}
