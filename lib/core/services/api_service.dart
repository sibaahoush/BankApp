
// import 'package:dio/dio.dart';
// import 'package:se3/core/utils/token_storage.dart';
// import '../utils/backend_endpoints.dart';
// import 'database_service.dart';

// class ApiService implements DatabaseService {
//   final Dio dio;

//   ApiService()
//     : dio = Dio(
//         BaseOptions(
//           baseUrl: BackendEndPoint.url,
//           connectTimeout: const Duration(seconds: 30),
//           receiveTimeout: const Duration(seconds: 30),
//         ),
//       ) {
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final accessToken = await TokenStorage().readAccess();
//           final p = options.path;

//           final isAuthCall =
//               p.contains(BackendEndPoint.signIn) ||
//               p.contains(BackendEndPoint.signUp);

//           if (!isAuthCall &&
//               accessToken != null &&
//               accessToken.isNotEmpty &&
//               options.headers['Authorization'] == null) {
//             options.headers['Authorization'] = 'Bearer $accessToken';
//           }

//           handler.next(options);
//         },
//         onError: (DioException err, handler) async {
//           if (err.response?.statusCode == 401 &&
//               !err.requestOptions.path.contains(BackendEndPoint.signIn) &&
//               !err.requestOptions.path.contains(BackendEndPoint.signUp)) {
//             try {
//               final tokenStorage = TokenStorage();
//               final oldToken = await tokenStorage.readAccess();

//               if (oldToken == null) {
//                 return handler.next(err);
//               }
//               AuthRepo authRepo = AuthRepoImp(
//                 databaseService: getIt.get<DatabaseService>(),
//               );
//               final result = await authRepo.refresh();
//               result.fold(
//                 (failure) {
//                   throw Exception(failure);
//                 },
//                 (newToken) async {
//                   final reqOptions = err.requestOptions;
//                   reqOptions.headers['Authorization'] = 'Bearer $newToken';
//                   final cloneResponse = await dio.fetch(reqOptions);
//                   return handler.resolve(cloneResponse);
//                 },
//               );
//             } catch (e) {
//               return handler.next(err);
//             }
//           }
//           handler.next(err);
//         },
//       ),
//     );
//   }

//   @override
//   Future addData({
//     required String endpoint,
//     required Map<String, dynamic> data,
//     String? rowid,
//   }) async {
//     final Response res = await dio.post(endpoint + (rowid ?? ''), data: data);
//     return res.data;
//   }

//   @override
//   Future getData({
//     required String endpoint,
//     String? rowid,
//     Map<String, dynamic>? quary,
//   }) async {
//     final Response res = await dio.get(
//       endpoint + (rowid ?? ''),
//       queryParameters: quary,
//     );
//     return res.data;
//   }

//   @override
//   Future deleteData({required String endpoint, String? rowid}) async {
//     final Response res = await dio.delete(endpoint + (rowid ?? ''));
//     return res.data;
//   }

//   @override
//   Future updateData({
//     required String endpoint,
//     String? rowid,
//     dynamic data,
//   }) async {
//     final Response res = await dio.put(endpoint + (rowid ?? ''), data: data);
//     return res.data;
//   }
// }
