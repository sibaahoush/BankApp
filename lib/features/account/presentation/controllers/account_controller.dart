import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/models/account.dart';
import 'package:se3/core/models/transaction.dart';
import 'package:se3/core/services/api_service.dart';
import 'package:se3/core/services/local_storage_service.dart';
import 'package:se3/core/utils/backend_endpoints.dart';
import 'package:se3/core/controllers/app_data_controller.dart';

class AccountController extends GetxController {
  final ApiService _apiService = ApiService();
  final AppDataController _appDataController = Get.find<AppDataController>();

  final RxList<Account> accounts = <Account>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final Rx<Account?> selectedAccount = Rx<Account?>(null);
  final RxBool isLoadingDetails = false.obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxBool isLoadingTransactions = false.obs;
  final RxBool isProcessingWithdraw = false.obs;
  final RxBool isProcessingPayment = false.obs;
  final RxBool isCreatingTransaction = false.obs;
  final RxBool isCreatingScheduledTransaction = false.obs;
  final RxString transactionFilter = 'all'.obs; // 'all', 'deposit', 'withdraw'

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    try {
      isLoading.value = true;

      final response = await _apiService.get(
        endpoint: BackendEndPoint.accounts,
      );

      if (response.statusCode == 200 && response.data is List) {
        accounts.value = (response.data as List)
            .map((json) => Account.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error loading accounts: $e');
      Get.snackbar(
        'Error',
        'Failed to load accounts',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createAccount({
    required int typeId,
    required double balance,
    int? accountRelatedId,
  }) async {
    try {
      isCreating.value = true;

      // Get customer_id from stored user data
      final userJson = await LocalStorageService.getItem(LocalStorageKeys.user);
      if (userJson == null || userJson.isEmpty) {
        throw Exception('User data not found');
      }

      final userData = jsonDecode(userJson);
      final customerId = userData['id'];

      if (customerId == null) {
        throw Exception('Customer ID not found');
      }

      final data = {
        'customer_id': customerId.toString(),
        'type_id': typeId.toString(),
        'balance': balance.toString(),
      };

      // Add account_related_id if provided (for sub-accounts)
      if (accountRelatedId != null) {
        data['account_related_id'] = accountRelatedId.toString();
      }

      final response = await _apiService.post(
        endpoint: BackendEndPoint.createAccount,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // Close the bottom sheet

        Get.snackbar(
          'Success',
          'Account created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload accounts list
        await loadAccounts();

        // Reload account details if we're viewing one
        if (selectedAccount.value != null && accountRelatedId != null) {
          await getAccountTree(accountRelatedId);
        }
      }
    } catch (e) {
      print('Error creating account: $e');
      Get.snackbar(
        'Error',
        'Failed to create account: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isCreating.value = false;
    }
  }

  // Get accounts by type
  List<Account> getAccountsByType(String typeName) {
    return accounts
        .where((account) =>
            account.type.toLowerCase() == typeName.toLowerCase())
        .toList();
  }

  // Get accounts by status
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

  // Get account tree (with sub-accounts)
  Future<void> getAccountTree(int accountId) async {
    try {
      isLoadingDetails.value = true;

      final response = await _apiService.get(
        endpoint: '${BackendEndPoint.getAccountTree}/$accountId/tree',
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        selectedAccount.value = Account.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error loading account details: $e');
      Get.snackbar(
        'Error',
        'Failed to load account details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoadingDetails.value = false;
    }
  }

  // Close account
  Future<void> closeAccount(int accountId) async {
    try {
      final response = await _apiService.get(
        endpoint: '${BackendEndPoint.closeAccount}/$accountId/close',
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Account closed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload accounts list
        await loadAccounts();

        // Go back to accounts list
        Get.back();
      }
    } catch (e) {
      print('Error closing account: $e');
      var message = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        '${message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }

  // Fetch all transactions
  Future<void> loadAllTransactions() async {
    try {
      isLoadingTransactions.value = true;

      final response = await _apiService.get(
        endpoint: BackendEndPoint.transactions,
      );

      if (response.statusCode == 200 && response.data is List) {
        transactions.value = (response.data as List)
            .map((json) => Transaction.fromJson(json as Map<String, dynamic>))
            .toList();

        // Sort by date, most recent first
        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } catch (e) {
      print('Error loading transactions: $e');
      Get.snackbar(
        'Error',
        'Failed to load transactions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingTransactions.value = false;
    }
  }

  // Fetch all transactions and filter by account ID
  Future<void> loadTransactionsForAccount(int accountId) async {
    try {
      isLoadingTransactions.value = true;

      final response = await _apiService.get(
        endpoint: BackendEndPoint.transactions,
      );

      if (response.statusCode == 200 && response.data is List) {
        final allTransactions = (response.data as List)
            .map((json) => Transaction.fromJson(json as Map<String, dynamic>))
            .toList();

        // Filter transactions for this specific account
        transactions.value = allTransactions
            .where((transaction) => transaction.accountId == accountId)
            .toList();

        // Sort by date, most recent first
        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } catch (e) {
      print('Error loading transactions: $e');
      Get.snackbar(
        'Error',
        'Failed to load transactions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingTransactions.value = false;
    }
  }

  // Get transactions for a specific account (synchronous)
  List<Transaction> getTransactionsForAccount(int accountId) {
    return transactions
        .where((transaction) => transaction.accountId == accountId)
        .toList();
  }

  // Get filtered transactions based on current filter
  List<Transaction> get filteredTransactions {
    if (transactionFilter.value == 'all') {
      return transactions;
    } else if (transactionFilter.value == 'deposit') {
      return transactions.where((t) => t.isDeposit).toList();
    } else if (transactionFilter.value == 'withdraw') {
      return transactions.where((t) => t.isWithdraw).toList();
    }
    return transactions;
  }

  // Set transaction filter
  void setTransactionFilter(String filter) {
    transactionFilter.value = filter;
  }

  // Process payment
  Future<void> processPayment({
    required double amount,
    required String driver, // 'stripe' or 'braintree'
    required String stripeToken,
    required String accountId,
  }) async {
    try {
      isProcessingPayment.value = true;

      final data = {
        'amount': amount.toString(),
        'driver': driver,
        'stripeToken': stripeToken,
        'nonce': stripeToken, // Send same value as nonce for braintree
        'account_id': accountId,
      };

      final response = await _apiService.post(
        endpoint: BackendEndPoint.processPayment,
        data: data,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final result = response.data as Map<String, dynamic>;

        if (result['success'] == true) {
          Get.back(); // Close the bottom sheet

          Get.snackbar(
            'Success',
            result['message'] ?? 'Payment processed successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Reload accounts and transactions
          await loadAccounts();
          await loadAllTransactions();
        } else {
          Get.snackbar(
            'Error',
            result['message'] ?? 'Payment failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
        }
      }
    } catch (e) {
      print('Error processing payment: $e');
      var message = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isProcessingPayment.value = false;
    }
  }

  // Create new transaction
  Future<void> createTransaction({
    required String accountId,
    required double amount,
    required String type, // 'deposit' or 'withdraw'
  }) async {
    try {
      isCreatingTransaction.value = true;

      final data = {
        'account_id': accountId,
        'amount': amount.toString(),
        'type': type,
      };

      final response = await _apiService.post(
        endpoint: BackendEndPoint.createTransaction,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // Close the screen

        Get.snackbar(
          'Success',
          'Transaction created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload accounts and transactions
        await loadAccounts();
        await loadAllTransactions();
      }
    } catch (e) {
      print('Error creating transaction: $e');
      var message = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isCreatingTransaction.value = false;
    }
  }

  // Create scheduled transaction
  Future<void> createScheduledTransaction({
    required String accountId,
    required double amount,
    required String type, // 'invoice', etc.
    required String frequency, // 'monthly', 'weekly', etc.
    required String nextRun, // DateTime string
    String? accountRelatedId,
  }) async {
    try {
      isCreatingScheduledTransaction.value = true;

      final data = {
        'account_id': accountId,
        'amount': amount.toString(),
        'type': type,
        'frequency': frequency,
        'next_run': nextRun,
      };

      if (accountRelatedId != null && accountRelatedId.isNotEmpty) {
        data['account_related_id'] = accountRelatedId;
      }

      final response = await _apiService.post(
        endpoint: BackendEndPoint.createScheduledTransaction,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // Close the screen

        Get.snackbar(
          'Success',
          'Scheduled transaction created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload accounts
        await loadAccounts();
      }
    } catch (e) {
      print('Error creating scheduled transaction: $e');
      var message = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isCreatingScheduledTransaction.value = false;
    }
  }

  // Process withdrawal
  Future<void> processWithdraw({
    required double amount,
    required String driver, // 'stripe' or 'braintree'
    required String nonce,
    String? transactionId, // Optional for refunds
  }) async {
    try {
      isProcessingWithdraw.value = true;

      final data = {
        'amount': amount.toString(),
        'driver': driver,
        'nonce': nonce,
      };

      // Add transaction_id if provided
      if (transactionId != null && transactionId.isNotEmpty) {
        data['transaction_id'] = transactionId;
      }

      final response = await _apiService.post(
        endpoint: BackendEndPoint.processWithdraw,
        data: data,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final result = response.data as Map<String, dynamic>;

        if (result['success'] == true) {
          Get.back(); // Close the screen

          Get.snackbar(
            'Success',
            result['message'] ?? 'Withdrawal processed successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Reload accounts and transactions
          await loadAccounts();
          if (selectedAccount.value != null) {
            await getAccountTree(selectedAccount.value!.id);
            await loadTransactionsForAccount(selectedAccount.value!.id);
          }
        } else {
          Get.snackbar(
            'Error',
            result['message'] ?? 'Withdrawal failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
        }
      }
    } catch (e) {
      print('Error processing withdrawal: $e');
      var message = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isProcessingWithdraw.value = false;
    }
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
