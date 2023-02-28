enum ChatMessageType{
  user,
  bot
}

class ChatMessages{
  ChatMessages({required this.text, required this.type});
  String? text;
  ChatMessageType? type;



}