import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {


  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _controller=TextEditingController();
  void _sendMessage() async{
    var user= await FirebaseAuth.instance.currentUser();
    var userData=await Firestore.instance.collection('users').document(user.uid).get();
    FocusScope.of(context).unfocus();
    print("Hii");
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt':Timestamp.now(),
      'usedId':user.uid,
      'userImage':userData.data['image_url']
    });

    _controller.clear();
  }
  var _enteredMessage='';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField(
            controller: _controller,
            onChanged: (value){
              setState(() {
                _enteredMessage=value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Send Message'
            ),

          )),
          IconButton(icon: Icon(Icons.send), onPressed:_enteredMessage.trim().isEmpty ? null: _sendMessage)
        ],
      ),
    );
  }
}
