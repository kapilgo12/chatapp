import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {

  String msg;
  String userId;
  bool isMe;
  String userImage;


  MessageBubble(this.msg,this.userId,this.userImage,this.isMe);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: isMe? MainAxisAlignment.end:MainAxisAlignment.start,
          children: [Container(
              decoration: BoxDecoration(
                color:isMe ? Colors.purple:Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: isMe? Radius.circular(0):Radius.circular(10),
                    bottomLeft: isMe ?Radius.circular(10):Radius.circular(0)
                ),


              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child:FutureBuilder(
                future:Firestore.instance.collection('users').document(userId).get() ,builder: (ctx,snapShot){
                if(snapShot.connectionState==ConnectionState.waiting){
                  return Text("Loading...");
                }
                return  Column(
                  children: <Widget>[

                    Container(
                      child: Text(snapShot.data['username'],style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold
                      ),),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.black)
                      ),
                    ),
                    Container(
                      child: Text(msg,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),

                    )
                  ],
                );
              },
              )



          )],
        ) ,
        Positioned(
          top: -10,
          left:isMe?null: 120,
          right: isMe?120 :null,
          child: CircleAvatar(backgroundImage:userImage==null?null: NetworkImage(userImage),),
        )
      ],
      overflow: Overflow.visible,
    );

  }
}

