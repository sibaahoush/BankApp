import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../controllers/ticket_controller.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});
  static const routename = "Ticketdetails";

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final TicketController _controller = Get.find<TicketController>();
  final TextEditingController _replyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? _ticketId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ticketId == null) {
      _ticketId = ModalRoute.of(context)?.settings.arguments as int?;
      if (_ticketId != null) {
        _controller.loadTicketDetails(_ticketId!);
      }
    }
  }

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeFormat = DateFormat('HH:mm').format(dateTime);

    if (messageDate == today) {
      return 'Today • $timeFormat';
    } else if (messageDate == yesterday) {
      return 'Yesterday • $timeFormat';
    } else {
      return '${DateFormat('dd MMM').format(dateTime)} • $timeFormat';
    }
  }

  Future<void> _sendReply() async {
    final message = _replyController.text.trim();
    if (message.isEmpty || _ticketId == null) return;

    await _controller.sendReply(ticketId: _ticketId!, message: message);
    _replyController.clear();

    // Scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final ticket = _controller.selectedTicket.value;
          return Text(ticket != null ? "Ticket #${ticket.id}" : "Ticket");
        }),
      ),
      body: Obx(() {
        if (_controller.isLoadingTicketDetails.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final ticket = _controller.selectedTicket.value;
        if (ticket == null) {
          return const Center(child: Text('Ticket not found'));
        }

        return Column(
          children: [
            // Ticket information
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
                    ticket.title,
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Status: ${ticket.status}",
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Created: ${_formatDate(ticket.createdAt)}",
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Initial ticket message
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: 1 + _controller.ticketReplies.length,
                itemBuilder: (context, index) {
                  // First message is the ticket itself
                  if (index == 0) {
                    return _ChatBubble(
                      message: ticket.message,
                      time: _formatTime(ticket.createdAt),
                      isUser: true,
                    );
                  }

                  // Subsequent messages are replies
                  final reply = _controller.ticketReplies[index - 1];
                  final isUser = reply.senderType.toLowerCase() == 'user';

                  return _ChatBubble(
                    message: reply.message,
                    time: _formatTime(reply.createdAt),
                    isUser: isUser,
                    senderName: isUser ? null : reply.senderName,
                  );
                },
              ),
            ),

            // Reply input field
            Container(
              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
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
                        controller: _replyController,
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: "Write a reply...",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(() {
                      return IconButton(
                        onPressed: _controller.isSendingReply.value
                            ? null
                            : _sendReply,
                        icon: _controller.isSendingReply.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send_rounded),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUser;
  final String? senderName;

  const _ChatBubble({
    required this.message,
    required this.time,
    required this.isUser,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 260),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              if (senderName != null) ...[
                Text(
                  senderName!,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isUser ? Colors.white : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isUser ? Colors.white70 : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
