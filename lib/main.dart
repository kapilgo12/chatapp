import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/authScreen.dart';
import 'package:untitled/screens/chatscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Chat App',
    home:StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx,userSnapShot)
  {
    if(userSnapShot.hasData){
      return ChatScreen();
    }
    return AuthScreen();
  })





    )
  );
}

