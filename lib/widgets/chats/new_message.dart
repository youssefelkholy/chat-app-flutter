import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData =await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _enteredMessage,
      'createdAt':Timestamp.now(),
      'username' : userData['username'],
      'userId' : user.uid,
      'userImage' : userData['image_url'],
    });
    _controller.clear();
    setState(() {
      _enteredMessage = "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,0,6),
                child: TextField(
                  style:const TextStyle(color: Colors.white),
                  cursorColor: Theme.of(context).primaryColor,
                  autocorrect: true,
                  enableSuggestions: true,
                  textCapitalization: TextCapitalization.sentences,
                  controller: _controller,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    hintText: 'Send A Message....'.toUpperCase(),
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.5
                    ),
                  ) ,
                  onChanged: (val){
                    setState(() {
                      _enteredMessage = val;
                    });
                  },
                ),
              ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Colors.white,
            icon:const Icon(Icons.send),
            onPressed:_enteredMessage.trim().isEmpty?null : _sendMessage,
          )
        ],
      ),
    );
  }
}
