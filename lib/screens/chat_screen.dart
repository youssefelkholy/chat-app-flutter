import 'package:chat_app1/widgets/chats/messages.dart';
import 'package:chat_app1/widgets/chats/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override

  void initState(){
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg){ 
        print(msg);
        return;
      },
      onLaunch: (msg){
        print(msg);
        return;
      },
      onResume: (msg){
        print(msg);
        return;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'messenger'.toUpperCase(),
          style:TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          )),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Logout'.toUpperCase(),style: TextStyle(color: Colors.white),),
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: const [
            Expanded(
                child:Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
