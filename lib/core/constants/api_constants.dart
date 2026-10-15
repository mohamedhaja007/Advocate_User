class ApiConstants {
  static const String baseUrl = 'https://api.avvocat.ai/api/v1';

  // Timeouts
  static const int connectTimeout = 15000; // ms
  static const int receiveTimeout = 15000; // ms

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
}
