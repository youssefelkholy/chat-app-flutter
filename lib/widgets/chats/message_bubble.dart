import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
   MessageBubble(this.message,this.username,this.userImage,this.isMe, {Key key}) : super(key: key);

  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:isMe?MainAxisAlignment.end : MainAxisAlignment.start,
          children:<Widget> [
            Container(
              decoration: BoxDecoration(
                  color: isMe? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: isMe? Radius.circular(0): Radius.circular(10),
                    bottomRight: isMe? Radius.circular(10): Radius.circular(0),
                  )
              ),
              width: 180,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal:10),
              margin: EdgeInsets.symmetric(vertical: 8,horizontal:15),
              child: Column(
                crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:5.0),
                    child: Text(
                      username.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe? Colors.white : Theme.of(context).accentTextTheme.headline6.color,
                      ),
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe? Colors.white : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: isMe? TextAlign.end : TextAlign.start,
                  ),

                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: !isMe? 170 : null,
          right:isMe? 170 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
