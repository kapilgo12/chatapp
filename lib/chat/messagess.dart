import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/chat/messge_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futuresnapShot) {
          if (futuresnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatSnapshot = snapShot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemCount: snapShot.data.documents.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                      chatSnapshot[index]['text'] ?? "",
                      chatSnapshot[index]['usedId'],

                      chatSnapshot[index]['userImage'],
                      chatSnapshot[index]['usedId'] == futuresnapShot.data.uid),
                );
              });
        });
  }
}

