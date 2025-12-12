import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import 'TicketDetailsScreen.dart';

class TicketViewBody extends StatelessWidget {
  const TicketViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // بيانات وهمية للعرض فقط
    final tickets = [
      {
        "id": "#1245",
        "title": "Card not working",
        "status": "Open",
        "date": "Today • 10:30",
      },
      {
        "id": "#1244",
        "title": "Issue with transfer",
        "status": "In progress",
        "date": "Yesterday • 16:20",
      },
      {
        "id": "#1239",
        "title": "Update phone number",
        "status": "Closed",
        "date": "02 Dec • 09:10",
      },
    ];

    Color _statusColor(String status) {
      switch (status) {
        case "Open":
          return Colors.orange;
        case "In progress":
          return Colors.blue;
        case "Closed":
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: tickets.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final t = tickets[index];
          final status = t["status"] as String;

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pushNamed(context, TicketDetailsScreen.routename);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: _statusColor(status).withOpacity(0.1),
                    child: Icon(
                      Icons.confirmation_num_rounded,
                      size: 18,
                      color: _statusColor(status),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t["title"] as String,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          t["date"] as String,
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(status).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      status,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _statusColor(status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      
    );
  }
}
