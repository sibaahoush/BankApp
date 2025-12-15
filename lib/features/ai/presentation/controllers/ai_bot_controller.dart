import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/backend_endpoints.dart';

class AiBotMessage {
  final String text;
  final bool isUser;
  final String time;

  AiBotMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class AiBotController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<AiBotMessage> messages = <AiBotMessage>[].obs;
  final RxBool isLoadingResponse = false.obs;
  final RxString selectedLanguage = 'ar'.obs;

  // Send query to AI and get recommendation
  Future<void> sendQuery(String query) async {
    if (query.trim().isEmpty) return;

    try {
      // Add user message to chat
      final timeFormat = DateFormat('HH:mm').format(DateTime.now());
      messages.add(AiBotMessage(
        text: query,
        isUser: true,
        time: timeFormat,
      ));

      isLoadingResponse.value = true;

      final data = {
        'query': query,
        'lang': selectedLanguage.value,
      };

      final response = await _apiService.post(
        endpoint: BackendEndPoint.aiRecommend,
        data: data,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final answer = response.data['answer'] as String?;
        if (answer != null) {
          // Add AI response to chat
          final responseTime = DateFormat('HH:mm').format(DateTime.now());
          messages.add(AiBotMessage(
            text: answer,
            isUser: false,
            time: responseTime,
          ));
        }
      } else {
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      print('Error getting AI recommendation: $e');
      Get.snackbar(
        'Error',
        'Failed to get AI recommendation',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingResponse.value = false;
    }
  }

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }

  void clearChat() {
    messages.clear();
  }
}
