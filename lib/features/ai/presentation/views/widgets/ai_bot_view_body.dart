import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/features/ai/presentation/views/widgets/ChatBubble.dart';
import 'package:se3/features/ai/presentation/views/widgets/LanguageSelector.dart';
import '../../controllers/ai_bot_controller.dart';
import 'ChatInputBar.dart';

class ChatbotViewBody extends StatelessWidget {
  const ChatbotViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AiBotController controller = Get.find<AiBotController>();

    return Column(
      children: [
        const LanguageSelector(),
        const Divider(height: 1),
        Expanded(
          child: Obx(() {
            if (controller.messages.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.selectedLanguage.value == 'ar'
                          ? 'اسأل عن نصائح مالية'
                          : 'Ask for financial tips',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return ChatBubble(
                  message: ChatMessage(
                    text: message.text,
                    isUser: message.isUser,
                    time: message.time,
                  ),
                );
              },
            );
          }),
        ),
        const ChatInputBar(),
      ],
    );
  }
}
