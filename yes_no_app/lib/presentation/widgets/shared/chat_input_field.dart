import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';

class ChatInputField extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  const ChatInputField({super.key, required this.onValueChanged});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool get hasText => controller.text.trim().isNotEmpty;

  void sendMessage(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    if (!hasText || chatProvider.isSending.value) return;

    widget.onValueChanged(controller.text.trim());
    controller.clear();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextFormField(
                onTapUpOutside: (event) {
                  focusNode.unfocus();
                },
                controller: controller,
                focusNode: focusNode,
                minLines: 1,
                maxLines: 4,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: "Message",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 00),
                child: chatProvider.isSending.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        key: const ValueKey("send"),
                        icon: Icon(
                          Icons.send,
                          color: hasText ? Colors.blue : Colors.grey,
                        ),
                        onPressed: hasText ? () => sendMessage(context) : null,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
