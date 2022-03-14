import 'package:flutter/material.dart';
import 'package:messenger/src/home/widgets/chat_entry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO making text not hardcoded, @ihavehackedyou
        title: Text(
          "HomeScreen",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ), //* Is important for contrast
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.menu_rounded))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: const [
            Divider(thickness: 2),

            //*Here temporarily only two entries 
            //TODO add list
            ChatEntry(
              name: "Peter",
              lastMessage: "BlaBlaBla",
              lastMessageDate: "today",
            ),
            ChatEntry(),
          ],
        ),
      ),
    );
  }
}
