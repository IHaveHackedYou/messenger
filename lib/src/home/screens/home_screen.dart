import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/home/widgets/chat_entry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Provider stuff
    List<CustomUser> users = [CustomUser, CustomUser(name: "Peter")];
    CustomUser myself = CustomUser(name: "Ich");

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
          children: [
            const Divider(thickness: 2),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ChatEntry(
                    user: users[index],
                    lastMessage: "",
                    lastMessageDate: "keine Ahnung",
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
