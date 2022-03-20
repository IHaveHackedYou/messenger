import 'package:customfirebase/src/models/message.dart';

// single Chat object
// example a chat between you and your friend
class Chat{
  // ids of all participating users
  List<String> _userIds;
  // all messages that got send
  List<Message> _sentMessages;

  List<String> get userIds => _userIds;
  List<Message> get sentMessages => _sentMessages;

  Chat(this._userIds, this._sentMessages);
}