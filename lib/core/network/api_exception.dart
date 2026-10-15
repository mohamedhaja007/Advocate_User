import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: dioException.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final responseData = dioException.response?.data;
        String errorMessage = 'Server error occurred.';
        if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        } else if (statusCode == 401) {
          errorMessage = 'Unauthorized access. Please login again.';
        } else if (statusCode == 404) {
          errorMessage = 'Requested resource not found.';
        }
        return ApiException(
          message: errorMessage,
          statusCode: statusCode,
          data: responseData,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled.');
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection available.');
      default:
        return ApiException(message: 'An unexpected error occurred.');
    }
  }

  @override
  String toString() => message;
}
