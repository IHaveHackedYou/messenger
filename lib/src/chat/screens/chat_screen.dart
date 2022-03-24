import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  CustomUser user;
  ChatScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.user.displayName ?? "Null"),
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
