import '../../../core/models/user_model.dart';
import '../../../core/models/membership_model.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/models/referral_model.dart';
import '../../../core/models/support_ticket_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

abstract class AccountRepository {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(UserModel user);
  Future<List<MembershipModel>> getMembershipPlans();
  Future<List<NotificationModel>> getNotifications();
  Future<ReferralModel> getReferralInfo();
  Future<List<SupportTicketModel>> getSupportTickets();
  Future<SupportTicketModel> createSupportTicket(String subject, String description);
}

class AccountRepositoryImpl implements AccountRepository {
  final ApiClient apiClient;

  AccountRepositoryImpl({required this.apiClient});

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get(ApiEndpoints.userProfile);
      if (response != null) {
        return UserModel.fromJson(response);
      }
    } catch (_) {}

    return UserModel(
      id: 'usr_101',
      firstName: 'Karthik',
      lastName: 'R',
      email: 'karthikr@gmail.com',
      phone: '+91 98765 43210',
      profileImage: 'https://i.pravatar.cc/150?img=11',
      preferredLanguage: 'en',
    );
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final response = await apiClient.put(ApiEndpoints.userProfile, data: user.toJson());
      if (response != null) {
        return UserModel.fromJson(response);
      }
    } catch (_) {}
    return user;
  }

  @override
  Future<List<MembershipModel>> getMembershipPlans() async {
    try {
      final response = await apiClient.get(ApiEndpoints.membershipPlans);
      if (response is List) {
        return response.map((e) => MembershipModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return [
      MembershipModel(
        id: 'm1',
        planName: 'Basic',
        price: 0,
        duration: 'Free Forever',
        aiQuestionLimit: 5,
        documentLimit: 1,
        lawyerDiscountPercentage: 0,
        isCurrentPlan: false,
      ),
      MembershipModel(
        id: 'm2',
        planName: 'Premium',
        price: 499,
        duration: '1 Month',
        aiQuestionLimit: 100,
        documentLimit: 20,
        lawyerDiscountPercentage: 15,
        isCurrentPlan: true,
      ),
    ];
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await apiClient.get(ApiEndpoints.notifications);
      if (response is List) {
        return response.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return [
      NotificationModel(
        id: 'n1',
        title: 'Booking Confirmed',
        message: 'Your consultation with Adv. R. Meenakshi has been confirmed for 12 May, 10:00 AM.',
        timestamp: '2 hours ago',
        isRead: false,
      ),
      NotificationModel(
        id: 'n2',
        title: 'Payment Successful',
        message: 'Received ₹1500 for booking ID AV-9812.',
        timestamp: '1 day ago',
        isRead: true,
      ),
    ];
  }

  @override
  Future<ReferralModel> getReferralInfo() async {
    try {
      final response = await apiClient.get(ApiEndpoints.referralInfo);
      if (response != null) {
        return ReferralModel.fromJson(response);
      }
    } catch (_) {}

    return ReferralModel(
      referralCode: 'AVVOCAT200',
      rewardAmount: 200,
      totalReferrals: 12,
      successfulReferrals: 8,
      totalRewardsEarned: 1600,
    );
  }

  @override
  Future<List<SupportTicketModel>> getSupportTickets() async {
    try {
      final response = await apiClient.get(ApiEndpoints.supportTickets);
      if (response is List) {
        return response.map((e) => SupportTicketModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return [
      SupportTicketModel(
        id: 't1',
        ticketNumber: 'TKT-8841',
        subject: 'Payment failed for booking',
        description: 'Amount deducted from bank account but booking status is pending.',
        status: 'Open',
        createdAt: '14 May 2024',
      )
    ];
  }

  @override
  Future<SupportTicketModel> createSupportTicket(
      String subject, String description) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.supportTickets,
        data: {'subject': subject, 'description': description},
      );
      if (response != null) {
        return SupportTicketModel.fromJson(response);
      }
    } catch (_) {}

    return SupportTicketModel(
      id: 't2',
      ticketNumber: 'TKT-8842',
      subject: subject,
      description: description,
      status: 'Open',
      createdAt: 'Just now',
    );
  }
}
