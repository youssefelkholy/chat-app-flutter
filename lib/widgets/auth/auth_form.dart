import 'dart:io';

import 'package:chat_app1/widgets/pickers/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final void Function (String email,String password,String username,File image,bool isLogin,BuildContext ctx) submitFn;

  final bool _isLoading;

  AuthForm(this.submitFn,this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  String _email = "";
  String _password = "";
  String _username = "";
  File userImageFile;
  void _pickImage(File _pickedImage){
    userImageFile = _pickedImage;
  }

  void _submit (){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(!_isLogin && userImageFile == null){
      Scaffold.of(context).showSnackBar(SnackBar(
        content:const Text('Please Upload An Image!'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if(isValid)
      {
        _formKey.currentState.save();
        widget.submitFn(_email.trim(),_password.trim(),_username.trim(),userImageFile,_isLogin,context);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin:const EdgeInsets.all(10),
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if(!_isLogin) UserImagePicker(_pickImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.words,
                  key: ValueKey('email'),
                  validator: (val){
                    if(val.isEmpty || !val.contains('@'))
                      {
                        return "Please Enter a Valid Email Address";
                      }
                    return null ;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                if(!_isLogin)
                TextFormField(
                    key: ValueKey('username'),
                    validator: (val){
                      if(val.isEmpty || val.length < 4)
                      {
                        return "Please Enter At Least 4 Characters";
                      }
                      return null ;
                    },
                    onSaved: (val) => _username = val,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                TextFormField(
                    key: ValueKey('password'),
                    validator: (val){
                      if(val.isEmpty || val.length < 7)
                      {
                        return "Password Must Be At Least 7 Characters";
                      }
                      return null ;
                    },
                    onSaved: (val) => _password = val,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                const SizedBox(height: 12),
                if(widget._isLoading)
                  CircularProgressIndicator(),
                if(!widget._isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? "Login" : "Sign Up" ),
                    color: Colors.teal,
                    onPressed: _submit,
                    ),
                const SizedBox(height: 10),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(_isLogin ?
                      "Create New Account" :
                      "I Already Have An Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
