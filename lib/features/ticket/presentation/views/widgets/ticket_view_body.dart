import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../controllers/ticket_controller.dart';
import 'TicketDetailsScreen.dart';

class TicketViewBody extends StatelessWidget {
  const TicketViewBody({super.key});

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final ticketDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeFormat = DateFormat('HH:mm').format(dateTime);

    if (ticketDate == today) {
      return 'Today • $timeFormat';
    } else if (ticketDate == yesterday) {
      return 'Yesterday • $timeFormat';
    } else {
      return '${DateFormat('dd MMM').format(dateTime)} • $timeFormat';
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "sended":
      case "open":
        return Colors.orange;
      case "in progress":
      case "processing":
        return Colors.blue;
      case "closed":
      case "resolved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _statusText(String status) {
    switch (status.toLowerCase()) {
      case "sended":
        return "Open";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TicketController controller = Get.find<TicketController>();

    return Obx(() {
      if (controller.isLoadingTickets.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.tickets.isEmpty) {
        return Center(
          child: Text(
            'No tickets yet',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.tickets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final ticket = controller.tickets[index];
            final status = ticket.status;

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TicketDetailsScreen.routename,
                  arguments: ticket.id,
                );
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
                            ticket.title,
                            style: AppTextStyles.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(ticket.createdAt),
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _statusText(status),
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
        ),
      );
    });
  }
}
