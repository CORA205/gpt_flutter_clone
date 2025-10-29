import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget{
  final String message;
  final bool isUser;
  const MessageWidget({super.key, required this.message, required this.isUser});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: isUser ? Colors.white24 : Colors.teal[500],
                borderRadius: isUser ? BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) ) : BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )  ,
              ),
              child: isUser ? Text(message, style: TextStyle(color: Colors.white)) : MarkdownBody(data: message)

            )
          )
        ]
      )
    );
  }
}