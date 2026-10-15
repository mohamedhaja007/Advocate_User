import 'package:go_router/go_router.dart';
import '../../core/models/lawyer_model.dart';
import '../../core/models/booking_model.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/get_started_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/otp_verification_screen.dart';
import '../../features/auth/presentation/pages/location_permission_screen.dart';
import '../../features/auth/presentation/pages/language_selection_screen.dart';
import '../../features/home/presentation/pages/main_navigation_shell.dart';
import '../../features/ai_assistant/presentation/pages/ai_assistant_screen.dart';
import '../../features/ai_assistant/presentation/pages/voice_assistant_screen.dart';
import '../../features/documents/presentation/pages/notice_scanner_screen.dart';
import '../../features/documents/presentation/pages/document_upload_screen.dart';
import '../../features/documents/presentation/pages/saved_documents_screen.dart';
import '../../features/documents/presentation/pages/document_analysis_screen.dart';
import '../../features/lawyers/presentation/pages/lawyer_profile_screen.dart';
import '../../features/lawyers/presentation/pages/saved_lawyers_screen.dart';
import '../../features/bookings/presentation/pages/consultation_type_screen.dart';
import '../../features/bookings/presentation/pages/slot_selection_screen.dart';
import '../../features/bookings/presentation/pages/booking_summary_screen.dart';
import '../../features/bookings/presentation/pages/payment_screen.dart';
import '../../features/bookings/presentation/pages/booking_confirmation_screen.dart';
import '../../features/bookings/presentation/pages/video_call_screen.dart';
import '../../features/bookings/presentation/pages/audio_call_screen.dart';
import '../../features/account/presentation/pages/profile_screen.dart';
import '../../features/account/presentation/pages/addresses_screen.dart';
import '../../features/account/presentation/pages/notifications_screen.dart';
import '../../features/account/presentation/pages/membership_screen.dart';
import '../../features/account/presentation/pages/referral_screen.dart';
import '../../features/account/presentation/pages/support_screen.dart';
import '../../features/account/presentation/pages/settings_screen.dart';
import '../../features/account/presentation/pages/transaction_history_screen.dart';
import '../../features/auth/presentation/pages/location_selection_screen.dart';
import '../../features/bookings/presentation/pages/advocate_chat_screen.dart';

// Robust parameter extraction helpers to ensure hot reload & app navigation never throw casting exceptions
LawyerModel _extractLawyer(Object? extra) {
  if (extra is LawyerModel) return extra;
  if (extra is Map) {
    final l = extra['lawyer'];
    if (l is LawyerModel) return l;
  }
  return LawyerModel(
    id: 'lawyer_1',
    name: 'Adv. Elena Marlowe',
    imageUrl: 'assets/images/Png/Man.png',
    rating: 4.8,
    reviewsCount: 120,
    experienceYears: 12,
    location: 'Chennai',
    distanceKm: 2.5,
    specializations: ['Family Lawyer', 'Corporate Law'],
    languages: ['Tamil', 'English'],
    about: 'Senior Advocate with 12+ years experience in family court and dispute resolution.',
    videoFee: 499,
    phoneFee: 299,
    doorstepFee: 1499,
  );
}

String _extractLawyerId(Object? extra) {
  if (extra is String) return extra;
  if (extra is LawyerModel) return extra.id;
  if (extra is Map && extra['id'] is String) return extra['id'] as String;
  return 'lawyer_1';
}

ConsultationType _extractConsultationType(Object? extra) {
  if (extra is ConsultationType) return extra;
  if (extra is Map && extra['type'] is ConsultationType) {
    return extra['type'] as ConsultationType;
  }
  return ConsultationType.video;
}

String _extractString(Object? extra, String key, String defaultValue) {
  if (extra is Map && extra[key] is String) {
    return extra[key] as String;
  }
  return defaultValue;
}

double _extractDouble(Object? extra, String key, double defaultValue) {
  if (extra is Map && extra[key] is num) {
    return (extra[key] as num).toDouble();
  }
  return defaultValue;
}

BookingModel _extractBookingModel(Object? extra, LawyerModel lawyer) {
  if (extra is BookingModel) return extra;
  if (extra is Map && extra['booking'] is BookingModel) {
    return extra['booking'] as BookingModel;
  }
  return BookingModel(
    id: 'b1',
    bookingNumber: 'BK-12658262',
    lawyer: lawyer,
    category: 'Family Lawyer',
    date: '16 Sep 2026',
    time: '10:30 AM',
    type: ConsultationType.video,
    status: BookingStatus.confirmed,
    amount: 499.0,
    createdAt: '2026-10-05',
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final mobile = _extractString(state.extra, 'mobile', '9876543210');
        return OtpVerificationScreen(mobileNumber: mobile);
      },
    ),
    GoRoute(
      path: '/allow-location',
      builder: (context, state) => const LocationPermissionScreen(),
    ),
    GoRoute(
      path: '/choose-language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationShell(initialIndex: 0),
    ),
    GoRoute(
      path: '/lawyers',
      builder: (context, state) => const MainNavigationShell(initialIndex: 1),
    ),
    GoRoute(
      path: '/bookings',
      builder: (context, state) => const MainNavigationShell(initialIndex: 2),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const MainNavigationShell(initialIndex: 3),
    ),
    GoRoute(
      path: '/ai-assistant',
      builder: (context, state) => const AiAssistantScreen(),
    ),
    GoRoute(
      path: '/voice-assistant',
      builder: (context, state) => const VoiceAssistantScreen(),
    ),
    GoRoute(
      path: '/notice-scanner',
      builder: (context, state) => const NoticeScannerScreen(),
    ),
    GoRoute(
      path: '/document-upload',
      builder: (context, state) => const DocumentUploadScreen(),
    ),
    GoRoute(
      path: '/saved-documents',
      builder: (context, state) => const SavedDocumentsScreen(),
    ),
    GoRoute(
      path: '/document-analysis',
      builder: (context, state) {
        final docId = _extractString(state.extra, 'docId', 'doc_1');
        return DocumentAnalysisScreen(documentId: docId);
      },
    ),
    GoRoute(
      path: '/lawyer-profile',
      builder: (context, state) {
        final lawyerId = _extractLawyerId(state.extra);
        return LawyerProfileScreen(lawyerId: lawyerId);
      },
    ),
    GoRoute(
      path: '/saved-lawyers',
      builder: (context, state) => const SavedLawyersScreen(),
    ),
    GoRoute(
      path: '/consultation-type',
      builder: (context, state) {
        final lawyer = _extractLawyer(state.extra);
        return ConsultationTypeScreen(lawyer: lawyer);
      },
    ),
    GoRoute(
      path: '/slot-selection',
      builder: (context, state) {
        final lawyer = _extractLawyer(state.extra);
        final type = _extractConsultationType(state.extra);
        return SlotSelectionScreen(
          lawyer: lawyer,
          type: type,
        );
      },
    ),
    GoRoute(
      path: '/booking-summary',
      builder: (context, state) {
        final lawyer = _extractLawyer(state.extra);
        final type = _extractConsultationType(state.extra);
        final date = _extractString(state.extra, 'date', 'Today, 16 Sep 2026');
        final time = _extractString(state.extra, 'time', '10:30 AM');
        return BookingSummaryScreen(
          lawyer: lawyer,
          type: type,
          date: date,
          time: time,
        );
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final lawyer = _extractLawyer(state.extra);
        final type = _extractConsultationType(state.extra);
        final date = _extractString(state.extra, 'date', 'Today, 16 Sep 2026');
        final time = _extractString(state.extra, 'time', '10:30 AM');
        final fee = _extractDouble(state.extra, 'fee', 499.0);
        return PaymentScreen(
          lawyer: lawyer,
          type: type,
          date: date,
          time: time,
          fee: fee,
        );
      },
    ),
    GoRoute(
      path: '/booking-confirmation',
      builder: (context, state) {
        final lawyer = _extractLawyer(state.extra);
        final booking = _extractBookingModel(state.extra, lawyer);
        return BookingConfirmationScreen(
          booking: booking,
        );
      },
    ),
    GoRoute(
      path: '/video-call',
      builder: (context, state) => const VideoCallScreen(),
    ),
    GoRoute(
      path: '/audio-call',
      builder: (context, state) => const AudioCallScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const AddressesScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/membership',
      builder: (context, state) => const MembershipScreen(),
    ),
    GoRoute(
      path: '/referral',
      builder: (context, state) => const ReferralScreen(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => const TransactionHistoryScreen(),
    ),
    GoRoute(
      path: '/choose-location',
      builder: (context, state) => const LocationSelectionScreen(),
    ),
    GoRoute(
      path: '/advocate-chat',
      builder: (context, state) {
        final advocateName = _extractString(state.extra, 'lawyerName', 'Elena Marlowe');
        final advocateImage = _extractString(state.extra, 'lawyerImage', 'assets/images/Png/Man.png');
        return AdvocateChatScreen(
          advocateName: advocateName,
          advocateImage: advocateImage,
        );
      },
    ),
  ],
);
