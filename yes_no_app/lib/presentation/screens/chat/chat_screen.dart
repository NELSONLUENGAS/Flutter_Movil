import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/bot_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/user_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/chat_input_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/36420510?v=4',
            ),
          ),
        ),
        title: const Text('Chat Screen 😉'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.scrollController,
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messages[index];
                  return (message.fromWho == FromWho.bot
                      ? BotMessageBubble(message: message)
                      : UserMessageBubble(message: message));
                },
              ),
            ),
            ChatInputField(
              onValueChanged: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}
