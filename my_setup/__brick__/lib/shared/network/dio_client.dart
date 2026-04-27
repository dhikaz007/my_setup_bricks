// mixin Services {
//   static final Dio _dio = _createDio();

//   static final Dio _refreshDio = Dio(_options);

//   static bool _isRefreshing = false;
//   static Completer<void>? _refreshCompleter;

//   static Dio get dio => _dio;

//   static BaseOptions get _options => BaseOptions(
//         baseUrl: Appconfig.baseUrl,
//         connectTimeout: const Duration(seconds: 300),
//         receiveTimeout: const Duration(seconds: 300),
//       );

//   Future<String?> getDeviceIp() async {
//     try {
//       final info = NetworkInfo();
//       String? ip = await info.getWifiIP();
//       return ip;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<void> _setHeaders(RequestOptions options) async {
//     final token = await TokenService().getAccessToken();
//     if (token?.isNotEmpty ?? false) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//   }

//   static Dio _createDio() {
//     final dioInstance = Dio(_options);

//     dioInstance.addSentry(captureFailedRequests: true);

//     dioInstance.interceptors.addAll([
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//       ),
//       if (Appconfig.enableAlice) alice.getDioInterceptor(),
//       QueuedInterceptorsWrapper(
//         onRequest: (options, handler) async {
//           try {
//             await _setHeaders(options);
//             handler.next(options);
//           } catch (e) {
//             debugPrint("Error Request ${e.toString()}");
//             handler.next(options);
//           }
//         },
//         onError: (DioException error, handler) async {
//           final msgException = DioErrNetwork.handleException(error);

//           if (error.response?.statusCode == 401) {
//             if (_isRefreshing) {
//               await _refreshCompleter?.future;

//               error.requestOptions.headers['Authorization'] =
//                   'Bearer ${await TokenService().getAccessToken()}';
//               return handler.resolve(await _dio.fetch(error.requestOptions));
//             }

//             _isRefreshing = true;
//             _refreshCompleter = Completer<void>();

//             try {
//               final refreshToken = await TokenService().getRefreshToken();
//               if (refreshToken == null) {
//                 throw Exception('No refresh token available');
//               }

//               final response = await _refreshDio.post(
//                 'auth/refresh-token-mobile',
//                 data: {'refreshToken': refreshToken},
//               );

//               final newAccessToken = response.data['token'];
//               final newRefreshToken = response.data['refresh_token'];

//               await TokenService().saveAccessToken(newAccessToken);
//               await TokenService().saveRefreshToken(newRefreshToken);

//               final originalRequest = error.requestOptions;
//               originalRequest.headers['Authorization'] =
//                   'Bearer $newAccessToken';

//               final retryResponse = await _dio.fetch(originalRequest);
//               handler.resolve(retryResponse);
//             } catch (e) {
//               await TokenService().deleteAllToken();
//               debugPrint('Refresh token failed. User needs to login again.');
//               Modular.get<ModularNavigationService>()
//                   .navigateToLoginAndClearStack();
//               handler.next(error);
//             } finally {
//               _isRefreshing = false;
//               _refreshCompleter?.complete();
//               _refreshCompleter = null;
//             }
//             return;
//           }

//           await Sentry.captureException(
//             error,
//             stackTrace: error.stackTrace,
//             withScope: (scope) {
//               scope.setContexts('Error Detail', {
//                 'custom_message': msgException.toString(),
//                 'status_code': error.response?.statusCode,
//               });
//             },
//           );

//           handler.reject(
//             DioException(
//               requestOptions: error.requestOptions,
//               error: msgException,
//             ),
//           );
//         },
//       ),
//     ]);

//     return dioInstance;
//   }

//   //* Request Handler Global
//   Future<T> requestHandler<T>(
//     Future<Response> Function() request,
//     FutureOr<T> Function(Response response) mapper,
//   ) async {
//     try {
//       final response = await request();
//       return await mapper(response);
//     } on DioException catch (e) {
//       if (e.error is AppErrNetwork) {
//         throw e.error as AppErrNetwork;
//       }

//       final errorMessage = e.response?.data['messages'] ?? e.toString();
//       throw Exception(errorMessage);
//     } catch (e, stack) {
//       debugPrint("Error at RequestHandler: $e");
//       debugPrint(stack.toString());
//       rethrow;
//     }
//   }
// }
