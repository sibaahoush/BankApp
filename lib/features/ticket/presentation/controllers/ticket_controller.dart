import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/ticket.dart';
import '../../../../core/models/ticket_reply.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/backend_endpoints.dart';

class TicketController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<Ticket> tickets = <Ticket>[].obs;
  final RxBool isLoadingTickets = false.obs;
  final RxBool isCreatingTicket = false.obs;

  final Rx<Ticket?> selectedTicket = Rx<Ticket?>(null);
  final RxList<TicketReply> ticketReplies = <TicketReply>[].obs;
  final RxBool isLoadingTicketDetails = false.obs;
  final RxBool isSendingReply = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTickets();
  }

  // Load all tickets
  Future<void> loadTickets() async {
    try {
      isLoadingTickets.value = true;

      final response = await _apiService.get(
        endpoint: BackendEndPoint.tickets,
      );

      if (response.statusCode == 200 && response.data is List) {
        tickets.value = (response.data as List)
            .map((json) => Ticket.fromJson(json as Map<String, dynamic>))
            .toList();

        // Sort by created date, most recent first
        tickets.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } catch (e) {
      print('Error loading tickets: $e');
      Get.snackbar(
        'Error',
        'Failed to load tickets',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingTickets.value = false;
    }
  }

  // Create new ticket
  Future<void> createTicket({
    required String title,
    required String message,
  }) async {
    try {
      isCreatingTicket.value = true;

      final data = {
        'title': title,
        'message': message,
      };

      final response = await _apiService.post(
        endpoint: BackendEndPoint.createTicket,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // Close the screen

        Get.snackbar(
          'Success',
          'Ticket created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload tickets
        await loadTickets();
      }
    } catch (e) {
      print('Error creating ticket: $e');
      Get.snackbar(
        'Error',
        'Failed to create ticket',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isCreatingTicket.value = false;
    }
  }

  // Get ticket details with replies
  Future<void> loadTicketDetails(int ticketId) async {
    try {
      isLoadingTicketDetails.value = true;

      final response = await _apiService.get(
        endpoint: '${BackendEndPoint.getTicket}/$ticketId',
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final ticketData = response.data['ticket'] as Map<String, dynamic>;

        selectedTicket.value = Ticket.fromJson(ticketData);

        // Load replies
        if (ticketData['children'] != null && ticketData['children'] is List) {
          ticketReplies.value = (ticketData['children'] as List)
              .map((json) => TicketReply.fromJson(json as Map<String, dynamic>))
              .toList();

          // Sort by created date
          ticketReplies.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
      }
    } catch (e) {
      print('Error loading ticket details: $e');
      Get.snackbar(
        'Error',
        'Failed to load ticket details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingTicketDetails.value = false;
    }
  }

  // Send reply to ticket
  Future<void> sendReply({
    required int ticketId,
    required String message,
  }) async {
    try {
      isSendingReply.value = true;

      final data = {
        'message': message,
        'title': 'reply',
      };

      final response = await _apiService.post(
        endpoint: '${BackendEndPoint.replyToTicket}/$ticketId/reply',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Reload ticket details to get updated replies
        await loadTicketDetails(ticketId);

        Get.snackbar(
          'Success',
          'Reply sent successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error sending reply: $e');
      Get.snackbar(
        'Error',
        'Failed to send reply',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isSendingReply.value = false;
    }
  }

  // Refresh tickets
  Future<void> refresh() async {
    await loadTickets();
  }
}
