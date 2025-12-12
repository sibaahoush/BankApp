import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TicketDetailsScreen extends StatelessWidget {

  const TicketDetailsScreen({super.key});
  static const routename = "Ticketdetails";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // رسائل وهمية (user / support)
    final messages = [
      {
        "from": "user",
        "text": "Hi, my card is not working in ATMs.",
        "time": "10:20",
      },
      {
        "from": "support",
        "text": "Hello Molham, can you please send the last 4 digits of card?",
        "time": "10:25",
      },
      {
        "from": "user",
        "text": "**** 1234",
        "time": "10:26",
      },
    ];

    final replyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket #1245"),
      ),
      body: Column(
        children: [
          // معلومات عن التذكرة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Card not working",
                  style: AppTextStyles.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Status: In progress",
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  "Created: Today • 10:20",
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // الرسائل
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                final isUser = m["from"] == "user";

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Theme.of(context).colorScheme.primary
                            : theme.cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(isUser ? 12 : 2),
                          bottomRight: Radius.circular(isUser ? 2 : 12),
                        ),
                        border: isUser
                            ? null
                            : Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m["text"] as String,
                            style: AppTextStyles.bodySmall.copyWith(
                              color:
                                  isUser ? Colors.white : const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              m["time"] as String,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isUser
                                    ? Colors.white70
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // حقل الرد
          Container(
            padding:
                const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: theme.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: replyController,
                      maxLines: 3,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: "Write a reply...",
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      // TODO: POST supported reply
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
