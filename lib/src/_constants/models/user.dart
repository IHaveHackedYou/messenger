import 'dart:ui';

class ChatUser {
  final String name;
  final Image? profileImage;

  List<Map<String, String>>? chat = List.empty();

  ChatUser({required this.name, this.profileImage, this.chat});
}
