import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../data/booking_repository.dart';
import '../../../payments/data/payment_repository.dart';

abstract class BookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}
class BookingLoading extends BookingState {}
class UserBookingsLoaded extends BookingState {
  final List<BookingModel> bookings;
  UserBookingsLoaded(this.bookings);
  @override
  List<Object?> get props => [bookings];
}
class BookingConfirmedState extends BookingState {
  final BookingModel booking;
  final PaymentModel payment;

  BookingConfirmedState({required this.booking, required this.payment});

  @override
  List<Object?> get props => [booking, payment];
}
class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
  @override
  List<Object?> get props => [message];
}

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository bookingRepository;
  final PaymentRepository paymentRepository;

  BookingCubit({
    required this.bookingRepository,
    required this.paymentRepository,
  }) : super(BookingInitial());

  Future<void> loadUserBookings() async {
    emit(BookingLoading());
    try {
      final list = await bookingRepository.getUserBookings();
      emit(UserBookingsLoaded(list));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> confirmAndPayBooking({
    required LawyerModel lawyer,
    required ConsultationType type,
    required String date,
    required String time,
    required double fee,
    required String paymentMethod,
  }) async {
    emit(BookingLoading());
    try {
      final booking = await bookingRepository.createBooking(
        lawyer: lawyer,
        type: type,
        date: date,
        time: time,
        fee: fee,
      );
      final payment = await paymentRepository.processPayment(
        bookingId: booking.id,
        paymentMethod: paymentMethod,
        amount: booking.totalAmount,
      );
      emit(BookingConfirmedState(booking: booking, payment: payment));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
