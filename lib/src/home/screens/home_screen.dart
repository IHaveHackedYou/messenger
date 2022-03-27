import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/home/widgets/chat_entry.dart';

class HomeScreen extends StatelessWidget {
  final CustomUser myUser;
  const HomeScreen({required this.myUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomUser> users = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomeScreen ${myUser.user.displayName}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ), //* Is important for contrast
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed("/homePage/search"),
              icon: const Icon(Icons.search_rounded))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ChatEntry(
                    userName: "Peter lol",
                    lastMessage: "komme morgen om",
                    lastMessageDate: "25.2.2000",
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
