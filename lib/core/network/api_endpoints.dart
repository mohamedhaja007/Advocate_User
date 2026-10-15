class ApiEndpoints {
  // Auth
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
  static const String userProfile = '/auth/profile';

  // Home & Categories
  static const String homeCategories = '/categories';
  static const String urgentLawyers = '/lawyers/urgent';

  // AI Assistant & Document Analysis
  static const String aiQuery = '/ai/query';
  static const String aiConversations = '/ai/conversations';
  static const String scanNotice = '/ai/scan-notice';
  static const String uploadDocument = '/documents/upload';
  static const String documentAnalysis = '/documents/analysis';
  static const String savedDocuments = '/documents';

  // Lawyers
  static const String lawyers = '/lawyers';
  static const String lawyerDetails = '/lawyers';
  static const String lawyerAvailability = '/lawyers/availability';
  static const String savedLawyers = '/lawyers/saved';

  // Bookings & Consultations
  static const String createBooking = '/bookings';
  static const String userBookings = '/bookings';
  static const String cancelBooking = '/bookings/cancel';
  static const String rescheduleBooking = '/bookings/reschedule';

  // Payments
  static const String createPayment = '/payments/create';
  static const String verifyPayment = '/payments/verify';

  // Account Sub-features
  static const String addresses = '/account/addresses';
  static const String membershipPlans = '/memberships/plans';
  static const String myMembership = '/memberships/me';
  static const String notifications = '/notifications';
  static const String referralInfo = '/referrals/me';
  static const String supportTickets = '/support/tickets';
}
