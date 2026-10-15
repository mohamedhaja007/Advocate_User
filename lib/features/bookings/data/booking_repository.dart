import '../../../core/models/booking_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/lawyer_model.dart';

abstract class BookingRepository {
  Future<BookingModel> createBooking({
    required LawyerModel lawyer,
    required ConsultationType type,
    required String date,
    required String time,
    required double fee,
  });
  Future<List<BookingModel>> getUserBookings();
  Future<bool> cancelBooking(String bookingId);
}

class BookingRepositoryImpl implements BookingRepository {
  final ApiClient apiClient;

  BookingRepositoryImpl({required this.apiClient});

  @override
  Future<BookingModel> createBooking({
    required LawyerModel lawyer,
    required ConsultationType type,
    required String date,
    required String time,
    required double fee,
  }) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.createBooking,
        data: {
          'lawyer_id': lawyer.id,
          'type': type.name,
          'date': date,
          'time': time,
          'fee': fee,
        },
      );
      if (response != null) {
        return BookingModel.fromJson(response);
      }
    } catch (_) {}

    return BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bookingNumber: 'AV-2024-${(1000 + DateTime.now().millisecond)}',
      lawyer: lawyer,
      category: lawyer.specializations.isNotEmpty ? lawyer.specializations.first : 'Legal',
      date: date,
      time: time,
      type: type,
      status: BookingStatus.confirmed,
      amount: fee,
      createdAt: 'Just now',
    );
  }

  @override
  Future<List<BookingModel>> getUserBookings() async {
    try {
      final response = await apiClient.get(ApiEndpoints.userBookings);
      if (response is List) {
        return response.map((json) => BookingModel.fromJson(json)).toList();
      }
    } catch (_) {}

    final mockLawyer1 = LawyerModel(
      id: 'l1',
      name: 'Adv. R. Meenakshi',
      imageUrl: 'https://i.pravatar.cc/150?img=47',
      rating: 4.9,
      reviewsCount: 1200,
      experienceYears: 8,
      location: 'Chennai',
      distanceKm: 2.3,
      specializations: ['Family & Divorce'],
      languages: ['English', 'Tamil'],
      about: '',
      videoFee: 1500,
      phoneFee: 1000,
      doorstepFee: 2500,
    );

    final mockLawyer2 = LawyerModel(
      id: 'l2',
      name: 'Adv. Priya Menon',
      imageUrl: 'https://i.pravatar.cc/150?img=32',
      rating: 4.8,
      reviewsCount: 857,
      experienceYears: 10,
      location: 'Chennai',
      distanceKm: 3.1,
      specializations: ['Corporate Law'],
      languages: ['English'],
      about: '',
      videoFee: 1800,
      phoneFee: 1200,
      doorstepFee: 3000,
    );

    return [
      BookingModel(
        id: 'b1',
        bookingNumber: 'AV-9812',
        lawyer: mockLawyer1,
        category: 'Family & Divorce',
        date: '12 May 2024',
        time: '10:00 AM',
        type: ConsultationType.video,
        status: BookingStatus.confirmed,
        amount: 1500,
        createdAt: '10 May 2024',
      ),
      BookingModel(
        id: 'b2',
        bookingNumber: 'AV-9813',
        lawyer: mockLawyer2,
        category: 'Corporate Law',
        date: '14 May 2024',
        time: '02:30 PM',
        type: ConsultationType.doorstep,
        status: BookingStatus.confirmed,
        amount: 3000,
        createdAt: '11 May 2024',
      ),
      BookingModel(
        id: 'b3',
        bookingNumber: 'AV-9814',
        lawyer: mockLawyer1,
        category: 'Property Law',
        date: '18 May 2024',
        time: '04:00 PM',
        type: ConsultationType.phone,
        status: BookingStatus.cancelled,
        amount: 1000,
        createdAt: '09 May 2024',
      ),
    ];
  }

  @override
  Future<bool> cancelBooking(String bookingId) async {
    try {
      await apiClient.post('${ApiEndpoints.cancelBooking}/$bookingId');
      return true;
    } catch (_) {
      return true;
    }
  }
}
