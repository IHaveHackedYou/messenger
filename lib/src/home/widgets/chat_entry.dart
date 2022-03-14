import 'package:flutter/material.dart';

class ChatEntry extends StatelessWidget {
  final String name, lastMessage, lastMessageDate;
  const ChatEntry(
      {this.name = "loading...",
      this.lastMessage = "loading...",
      this.lastMessageDate = "loading...",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Card(
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
                    name, //* Chat Name
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
