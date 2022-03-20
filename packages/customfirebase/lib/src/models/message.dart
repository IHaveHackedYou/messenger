// single Message object
class Message {
  // plain text of the message
  String _message;
  // id of the user that has sent the message
  String _userUid;
  // time when the message got sent
  String _sentTime;

  String get message => _message;
  String get userUid => _userUid;
  String get sentTime => _sentTime;

  Message(this._message, this._userUid, this._sentTime);
}
