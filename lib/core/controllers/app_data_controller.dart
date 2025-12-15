import 'package:get/get.dart';
import 'package:se3/core/models/account_status.dart';
import 'package:se3/core/models/account_type.dart';
import 'package:se3/core/models/role.dart';
import 'package:se3/core/services/api_service.dart';
import 'package:se3/core/utils/backend_endpoints.dart';

class AppDataController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<AccountType> accountTypes = <AccountType>[].obs;
  final RxList<AccountStatus> accountStatuses = <AccountStatus>[].obs;
  final RxList<Role> roles = <Role>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isLoaded = false.obs;

  Future<void> loadAllData() async {
    if (isLoaded.value) return; // Prevent duplicate loading

    try {
      isLoading.value = true;

      // Load all data in parallel for better performance
      await Future.wait([
        _loadAccountTypes(),
        _loadAccountStatuses(),
        _loadRoles(),
      ]);

      isLoaded.value = true;
    } catch (e) {
      print('Error loading app data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadAccountTypes() async {
    try {
      final response = await _apiService.get(
        endpoint: BackendEndPoint.accountTypes,
      );

      if (response.statusCode == 200 && response.data is List) {
        accountTypes.value = (response.data as List)
            .map((json) => AccountType.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading account types: $e');
    }
  }

  Future<void> _loadAccountStatuses() async {
    try {
      final response = await _apiService.get(
        endpoint: BackendEndPoint.accountStatuses,
      );

      if (response.statusCode == 200 && response.data is List) {
        accountStatuses.value = (response.data as List)
            .map((json) => AccountStatus.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading account statuses: $e');
    }
  }

  Future<void> _loadRoles() async {
    try {
      final response = await _apiService.get(
        endpoint: BackendEndPoint.roles,
      );

      if (response.statusCode == 200 && response.data is List) {
        roles.value = (response.data as List)
            .map((json) => Role.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

  // Helper methods to get items by id or name
  AccountType? getTypeById(int id) {
    try {
      return accountTypes.firstWhere((type) => type.id == id);
    } catch (e) {
      return null;
    }
  }

  AccountType? getTypeByName(String name) {
    try {
      return accountTypes
          .firstWhere((type) => type.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  AccountStatus? getStatusById(int id) {
    try {
      return accountStatuses.firstWhere((status) => status.id == id);
    } catch (e) {
      return null;
    }
  }

  AccountStatus? getStatusByName(String name) {
    try {
      return accountStatuses.firstWhere(
          (status) => status.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  Role? getRoleById(int id) {
    try {
      return roles.firstWhere((role) => role.id == id);
    } catch (e) {
      return null;
    }
  }

  Role? getRoleByName(String name) {
    try {
      return roles
          .firstWhere((role) => role.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }
}
