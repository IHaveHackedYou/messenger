import 'package:customfirebase/src/models/message.dart';

// single Chat object
// example a chat between you and your friend
class Chat {
  // ids of all participating users
  List<String> _userIds;
  List<String> get userIds => _userIds;
  // all messages that got send
  List<Message> _sentMessages;
  List<Message> get sentMessages => _sentMessages;
  //index to sort the chats
  int _index;
  int get index => _index;
  set index(value) => _index = value;

  Chat(this._userIds, this._sentMessages, this._index);
}
