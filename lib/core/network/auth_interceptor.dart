import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';
import 'api_endpoints.dart';
import '../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;
  final Dio dio;

  AuthInterceptor({
    required this.secureStorageService,
    required this.dio,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await secureStorageService.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final response = await dio.post(
            '${ApiConstants.baseUrl}${ApiEndpoints.refreshToken}',
            data: {'refresh_token': refreshToken},
          );
          if (response.statusCode == 200 && response.data != null) {
            final newAccessToken = response.data['access_token'];
            final newRefreshToken = response.data['refresh_token'];
            if (newAccessToken != null) {
              await secureStorageService.saveAccessToken(newAccessToken);
              if (newRefreshToken != null) {
                await secureStorageService.saveRefreshToken(newRefreshToken);
              }
              final requestOptions = err.requestOptions;
              requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
              final clonedResponse = await dio.fetch(requestOptions);
              return handler.resolve(clonedResponse);
            }
          }
        } catch (_) {
          await secureStorageService.clearAll();
        }
      } else {
        await secureStorageService.clearAll();
      }
    }
    return handler.next(err);
  }
}
