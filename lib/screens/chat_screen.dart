import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  FirebaseUser _user;
  String message;
  TextEditingController _controller = TextEditingController();

  void getUser() async {
    //null or current user
    _user = await _auth.currentUser();
  }

  void getMessages() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for(var document in snapshot.documents) {
        //gets each document --> that is in a Map format
        print(document.data);

      }
    }
  }

  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECE5DD),
      appBar: AppBar(      
        leading: Container(
          
        ),
        backgroundColor: Colors.red,
        title: Text(
          "GroupChat",
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 30.0,
            onPressed: () async {
              _auth.signOut();
              Navigator.pop(context);
              
            },
            icon: Icon(
            Icons.exit_to_app,
            semanticLabel: "Logout",
            color: Colors.white,
              ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                //here snapshot.data = collections
               if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                 backgroundColor: Colors.red,
               ),
                  );
               }
               var documents = snapshot.data.documents.reversed;
               List<Message> messages = [];

               for (var document in documents) {
                 var sender = document.data['sender'].length > 5 ? document.data['sender'].substring(0, 5) + '...' : document.data['sender'];
                 var message = document.data['message'];
                 
                 var isMe = document.data['sender'] == _user.email ? true : false;

                 var messageBubble = Message(sender: sender, message: message, isMe: isMe);
                 messages.add(messageBubble);
               }
                 return ListView(
                   reverse: true,
                   children: messages
                 );
            
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    
                    padding: EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        message = value;
                      },
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type a Message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.all(1.0),
                  child: IconButton(
                    onPressed: () async{

                     if (_controller.text != "") {
                        //clear the message
                      _controller.clear();
                       //send the message
                      await _firestore.collection('messages').add({'sender': _user.email, 'message': message, 'time': Timestamp.now()});
                      
                     }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  Message({this.sender, this.message, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 130,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            boxShadow: isMe ? <BoxShadow>[
              BoxShadow(
                blurRadius: 12.0,
                color: Colors.black.withOpacity(.5),
                offset: Offset(5.0, 5.0)
              ),
            ]: <BoxShadow>[
              BoxShadow(
                blurRadius: 12.0,
                color: Colors.black.withOpacity(.5),
                offset: Offset(-5.0, 5.0)
              ),
            ],
            color: isMe ? Colors.red : Colors.white,
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0) 
            ) : BorderRadius.only(
              topRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0) 
            ),
          ),
          child: isMe ? Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             
              Text(
                sender,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(height: 3.0,),
              Text(
                message,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            
            ],
          ),
        ),
      ],
    );
  }
}
