import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/services/api_service.dart';
import 'package:se3/core/services/local_storage_service.dart';
import 'package:se3/core/utils/backend_endpoints.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString verificationEmail = ''.obs;
  final RxInt userId = 0.obs;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.post(
        endpoint: BackendEndPoint.signIn,
        data: {
          'identifier': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['token'] != null) {
          await LocalStorageService.setItem(
            LocalStorageKeys.token,
            data['token'],
          );
        }

        if (data['user'] != null) {
          await LocalStorageService.setItem(
            LocalStorageKeys.user,
            jsonEncode(data['user']),
          );
        }

        Get.offAllNamed('main');
        Get.snackbar(
          'Success',
          'Logged in successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.post(
        endpoint: BackendEndPoint.signUp,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Store user_id and email for verification
        if (data['user_id'] != null) {
          userId.value = data['user_id'];
        }
        verificationEmail.value = email;

        Get.toNamed('vrfCode');
        Get.snackbar(
          'Success',
          data['message'] ?? 'Registration successful! Please verify your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyCode({required String code}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.post(
        endpoint: BackendEndPoint.verifyOtp,
        data: {
          'user_id': userId.value,
          'otp': code,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['token'] != null) {
          await LocalStorageService.setItem(
            LocalStorageKeys.token,
            data['token'],
          );
        }

        if (data['user'] != null) {
          await LocalStorageService.setItem(
            LocalStorageKeys.user,
            jsonEncode(data['user']),
          );
        }

        Get.offAllNamed('main');
        Get.snackbar(
          'Success',
          data['message'] ?? 'Email verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendVerificationCode() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.post(
        endpoint: BackendEndPoint.resendOtp,
        data: {
          'user_id': userId.value,
        },
      );

      Get.snackbar(
        'Success',
        response.data['message'] ?? 'Verification code sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = _extractErrorMessage(e);
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      // Clear local storage
      await LocalStorageService.removeItem(LocalStorageKeys.token);
      await LocalStorageService.removeItem(LocalStorageKeys.user);

      // Navigate to sign in
      Get.offAllNamed('signin');

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
