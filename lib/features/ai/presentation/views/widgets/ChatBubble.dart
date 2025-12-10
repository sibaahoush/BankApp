import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';


class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.lightprimary,
              child: Icon(Icons.smart_toy, size: 16, color: AppColors.primary),
            ),
          if (!isUser) const SizedBox(width: 6),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : AppColors.cardLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft:
                      isUser ? const Radius.circular(14) : const Radius.circular(2),
                  bottomRight:
                      isUser ? const Radius.circular(2) : const Radius.circular(14),
                ),
                border: isUser
                    ? null
                    : Border.all(
                        color: AppColors.border.withOpacity(0.2),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isUser ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.time,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isUser
                            ? Colors.white70
                            : AppColors.textGrey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 6),
          if (isUser)
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Icon(Icons.person, size: 16, color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}
