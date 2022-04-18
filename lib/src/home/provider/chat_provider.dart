import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  //List of all chats in which the user is part of
  List<Chat> _chats = List<Chat>.empty(growable: true);

  void setList(List<Chat> _userChat) {
    _chats = _userChat;
    notifyListeners();
  }

  void clearList() {
    _chats = List<Chat>.empty(growable: true);
    notifyListeners();
  }

  void addChat(Chat _chatToAdd) {
    _chats.add(_chatToAdd);
    notifyListeners();
  }

  void removeChat(int _index) {
    _chats.removeAt(_index);

    //updating indexes of chats after the removed one
    for (var i = _index; i < _chats.length - _index; i++) {
      _chats[i].index = i;
    }
  }

  void changeChat(Chat _chatToChange, int _index) {
    _chats[_index] = _chatToChange;
    notifyListeners();
  }

  void reorderChats(int _oldIndex, int _newIndex) {
    final _temporaryStorage = _chats[_newIndex];

    _chats[_newIndex] = _chats[_oldIndex];
    _chats[_oldIndex] = _temporaryStorage;
    notifyListeners();
  }
}
