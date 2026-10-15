import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';
import '../../../core/storage/secure_storage_service.dart';

abstract class AuthRepository {
  Future<bool> sendOtp(String mobileNumber);
  Future<UserModel> verifyOtp(String mobileNumber, String otp);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl({
    required this.apiClient,
    required this.secureStorage,
  });

  @override
  Future<bool> sendOtp(String mobileNumber) async {
    try {
      await apiClient.post(ApiEndpoints.sendOtp, data: {'mobile': mobileNumber});
      return true;
    } catch (_) {
      // Mock fallback for UI testing when backend is not live
      return true;
    }
  }

  @override
  Future<UserModel> verifyOtp(String mobileNumber, String otp) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.verifyOtp,
        data: {'mobile': mobileNumber, 'otp': otp},
      );
      if (response != null && response['token'] != null) {
        await secureStorage.saveAccessToken(response['token']);
        return UserModel.fromJson(response['user']);
      }
    } catch (_) {}

    // Clean mock user for visual development & testing
    final mockUser = UserModel(
      id: 'usr_101',
      firstName: 'Karthik',
      lastName: 'R',
      email: 'karthikr@gmail.com',
      phone: mobileNumber,
      profileImage: 'https://i.pravatar.cc/150?img=11',
    );
    await secureStorage.saveAccessToken('mock_access_token_123');
    await secureStorage.saveUserId(mockUser.id);
    return mockUser;
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post(ApiEndpoints.logout);
    } catch (_) {}
    await secureStorage.clearAll();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final token = await secureStorage.getAccessToken();
    if (token == null) return null;
    return UserModel(
      id: 'usr_101',
      firstName: 'Karthik',
      lastName: 'R',
      email: 'karthikr@gmail.com',
      phone: '+91 98765 43210',
    );
  }
}
