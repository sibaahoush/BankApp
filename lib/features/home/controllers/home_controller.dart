import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:se3/core/models/account.dart';
import 'package:se3/core/services/api_service.dart';
import 'package:se3/core/services/local_storage_service.dart';
import 'package:se3/core/utils/backend_endpoints.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<Account> accounts = <Account>[].obs;
  final RxBool isLoading = false.obs;
  final RxString userName = ''.obs;
  final RxDouble totalBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    loadAccounts();
  }

  Future<void> _loadUserData() async {
    try {
      final userJson = await LocalStorageService.getItem(LocalStorageKeys.user);
      if (userJson != null && userJson.isNotEmpty) {
        final userData = jsonDecode(userJson);
        userName.value = userData['name'] ?? 'User';
      }
    } catch (e) {
      print('Error loading user data: $e');
      userName.value = 'User';
    }
  }

  Future<void> loadAccounts() async {
    try {
      isLoading.value = true;

      final response = await _apiService.get(
        endpoint: BackendEndPoint.accounts,
      );

      if (response.statusCode == 200 && response.data is List) {
        accounts.value = (response.data as List)
            .map((json) {
              try {
                return Account.fromJson(json as Map<String, dynamic>);
              } catch (e) {
                print('Error parsing account: $e');
                print('Account data: $json');
                rethrow;
              }
            })
            .toList();

        _calculateTotalBalance();
      }
    } catch (e, stackTrace) {
      print('Error loading accounts: $e');
      print('Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateTotalBalance() {
    double total = 0.0;

    for (var account in accounts) {
      total += account.balance;
    }

    totalBalance.value = total;
  }

  // Helper method to get accounts grouped by type
  List<Account> getAccountsByType(String typeName) {
    return accounts
        .where((account) =>
            account.type.toLowerCase() == typeName.toLowerCase())
        .toList();
  }

  // Helper method to get accounts by status
  List<Account> getAccountsByStatus(String statusName) {
    return accounts
        .where((account) =>
            account.status.toLowerCase() == statusName.toLowerCase())
        .toList();
  }

  // Refresh data
  Future<void> refresh() async {
    await loadAccounts();
  }

  String _extractErrorMessage(dynamic error) {
    if (error is DioException) {
      // Handle network/connection errors
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'Connection timeout. Please try again.';
      }

      if (error.type == DioExceptionType.connectionError) {
        return 'No internet connection. Please check your network.';
      }

      // Handle server response errors
      if (error.response != null && error.response?.data != null) {
        final responseData = error.response!.data;

        // Handle different error response formats
        if (responseData is Map<String, dynamic>) {
          // Check for 'message' field (common in Laravel)
          if (responseData['message'] != null) {
            return responseData['message'].toString();
          }

          // Check for 'error' field
          if (responseData['error'] != null) {
            return responseData['error'].toString();
          }

          // Check for validation errors (Laravel format)
          if (responseData['errors'] != null && responseData['errors'] is Map) {
            final errors = responseData['errors'] as Map<String, dynamic>;
            // Get the first error message
            if (errors.isNotEmpty) {
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return firstError.first.toString();
              }
              return firstError.toString();
            }
          }
        }

        // If responseData is a string
        if (responseData is String && responseData.isNotEmpty) {
          return responseData;
        }
      }

      return 'Something went wrong. Please try again.';
    }

    return error.toString();
  }
}
