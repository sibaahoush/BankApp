import 'package:dio/dio.dart';
import 'package:se3/core/services/local_storage_service.dart';
import '../utils/backend_endpoints.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: BackendEndPoint.url,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorageService.getItem(LocalStorageKeys.token);

          final isAuthCall = options.path.contains(BackendEndPoint.signIn) ||
              options.path.contains(BackendEndPoint.signUp) ||
              options.path.contains(BackendEndPoint.verifyOtp) ||
              options.path.contains(BackendEndPoint.resendOtp);

          if (!isAuthCall && token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Accept'] = 'application/json';
          handler.next(options);
        },
        onError: (DioException err, handler) async {
          if (err.response?.statusCode == 401) {
            await LocalStorageService.removeItem(LocalStorageKeys.token);
            await LocalStorageService.removeItem(LocalStorageKeys.user);
          }
          handler.next(err);
        },
      ),
    );
  }

  Future<Response> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final formData = FormData.fromMap(data);
    return await dio.post(endpoint, data: data);
  }

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(endpoint, data: data);
  }

  Future<Response> delete({
    required String endpoint,
  }) async {
    return await dio.delete(endpoint);
  }
}
