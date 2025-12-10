import 'package:flutter/material.dart';
import 'package:se3/features/ai/presentation/views/widgets/ChatBubble.dart';
import 'package:se3/features/ai/presentation/views/widgets/LanguageSelector.dart';

import 'ChatInputBar.dart';


class ChatbotViewBody extends StatelessWidget {
  const ChatbotViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // رسائل وهمية فقط للتصميم
    final messages = [
      ChatMessage(
        text: "كيف أقدر أرفع مستوى إدخاري الشهري؟",
        isUser: true,
        time: "12:30",
      ),
      ChatMessage(
        text:
            "يمكنك البدء بتحديد ميزانية شهرية، وتخصيص مبلغ ثابت للادخار قبل أي مصروف آخر.",
        isUser: false,
        time: "12:30",
      ),
      ChatMessage(
        text: "اعطني مثال لخطة بسيطة.",
        isUser: true,
        time: "12:31",
      ),
      ChatMessage(
        text:
            "مثال: ادخار 20% من الراتب، 50% للمصاريف الأساسية، و30% للكماليات والترفيه.",
        isUser: false,
        time: "12:31",
      ),
    ];

    return  Column(
        children: [
          const LanguageSelector(),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          const ChatInputBar(),
        ],
      
    );
  }
  
}
