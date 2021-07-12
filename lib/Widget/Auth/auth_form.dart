import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/Widget/pickers/users_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuth;
  bool loading;

  AuthForm(this.submitAuth, this.loading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _finalFormKey = GlobalKey<FormState>();
  String _userName = '';
  String _email = '';
  String _passWord = '';
  var isLogin = true;
  var _userImage;

  void pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    FocusScope.of(context).unfocus();

    final isValid = _finalFormKey.currentState.validate();

    if (_userImage == null && !isLogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Please Pick an image")));
      return;
    }

    if (isValid) {
      _finalFormKey.currentState.save();
    }
    widget.submitAuth(_email.trim(), _passWord.trim(), _userName.trim(),
        _userImage, isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _finalFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (isLogin == false)
                  UserImagePicker(pickedImage),
                TextFormField(
                  key: ValueKey("email"),
                  onSaved: (value) {
                    _email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@'))
                      return 'please enter a valid Email Address';
                    else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                ),
                if (isLogin == false)
                  TextFormField(
                    key: ValueKey("username"),
                    onSaved: (value) {
                      _userName = value;
                    },
                    decoration: InputDecoration(labelText: "User Name"),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4)
                        return "Enter atleast 4 letter";
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey("passWord"),
                  onSaved: (value) {
                    _passWord = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Please enter atleast 7 character';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "PassWord",
                  ),
                ),
                widget.loading
                    ? RaisedButton(
                        onPressed: null,
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(isLogin ? "Login" : "SignUp"),
                      ),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Create New Account"
                        : "I already have an Acount"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
