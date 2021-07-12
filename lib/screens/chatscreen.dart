import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/chat/messagess.dart';
import 'package:untitled/chat/newmessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Chat'),
          actions: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('LogOut')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemSelected) {
                if (itemSelected == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[Expanded(child: Messages()), NewMessage()],
          ),
        ));
  }
}
