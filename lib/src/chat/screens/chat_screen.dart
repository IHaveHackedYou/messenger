import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/user.dart';

class ChatScreen extends StatefulWidget {
  ChatUser user;
  ChatScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemBuilder: (context, index) => Container(),
            ),
          ),
          const Spacer(),
          const TextField(
            autofocus: false,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
