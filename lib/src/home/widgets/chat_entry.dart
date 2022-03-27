import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/theme_data.dart';

class ChatEntry extends StatelessWidget {
  final String userName;
  final String lastMessage, lastMessageDate;
  const ChatEntry(
      {required this.userName,
      required this.lastMessage,
      required this.lastMessageDate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("object");
        //Navigator.of(context).pushNamed("/homePage/chat", arguments: user);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeDataConstants.borderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.person_pin), //*Profile Image
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName, //* Chat Name
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(lastMessage), //* Last Chat-Message
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(lastMessageDate), //* Last Chat-Message Date
              ),
            ],
          ),
        ),
      ),
    );
  }
}
