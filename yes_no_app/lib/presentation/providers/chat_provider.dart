import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final scrollController = ScrollController();
  final getYesNOAnswer = GetYesNOAnswer();
  final isSending = ValueNotifier<bool>(false);

  List<Message> messages = [
    Message(text: 'Hello, I am the bot!', fromWho: FromWho.bot),
    Message(text: 'How can I help you?', fromWho: FromWho.bot),
  ];

  Future<void> sendMessage(String text) async {
    final newMessage = Message(text: text, fromWho: FromWho.user);
    messages.add(newMessage);
    isSending.value = true;
    notifyListeners();

    await getBotAnswer();
    isSending.value = false;
  }

  Future<void> getBotAnswer() async {
    final response = await getYesNOAnswer();
    final botResponse = Message(
      text: response.text.toUpperCase(),
      fromWho: response.fromWho,
      imageUrl: response.imageUrl,
    );
    messages.add(botResponse);
    notifyListeners();
    moveScrollTobOttom();
  }

  void moveScrollTobOttom() {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
