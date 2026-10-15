import 'lawyer_model.dart';

enum ConsultationType { video, phone, doorstep }
enum BookingStatus { confirmed, pending, completed, cancelled }

class BookingModel {
  final String id;
  final String bookingNumber;
  final LawyerModel lawyer;
  final String category;
  final String date;
  final String time;
  final ConsultationType type;
  final BookingStatus status;
  final double amount;
  final double platformFee;
  final double discount;
  final String createdAt;

  BookingModel({
    required this.id,
    required this.bookingNumber,
    required this.lawyer,
    required this.category,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    required this.amount,
    this.platformFee = 50.0,
    this.discount = 0.0,
    required this.createdAt,
  });

  double get totalAmount => amount + platformFee - discount;

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      bookingNumber: json['booking_number'] ?? json['bookingNumber'] ?? '',
      lawyer: LawyerModel.fromJson(json['lawyer'] ?? {}),
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      type: ConsultationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ConsultationType.video,
      ),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.confirmed,
      ),
      amount: (json['amount'] ?? 0.0).toDouble(),
      platformFee: (json['platform_fee'] ?? 50.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_number': bookingNumber,
      'lawyer': lawyer.toJson(),
      'category': category,
      'date': date,
      'time': time,
      'type': type.name,
      'status': status.name,
      'amount': amount,
      'platform_fee': platformFee,
      'discount': discount,
      'created_at': createdAt,
    };
  }
}

class PaymentModel {
  final String paymentId;
  final String bookingId;
  final String paymentMethod;
  final String status;
  final double amount;
  final String timestamp;

  PaymentModel({
    required this.paymentId,
    required this.bookingId,
    required this.paymentMethod,
    required this.status,
    required this.amount,
    required this.timestamp,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['payment_id'] ?? '',
      bookingId: json['booking_id'] ?? '',
      paymentMethod: json['payment_method'] ?? 'UPI',
      status: json['status'] ?? 'SUCCESS',
      amount: (json['amount'] ?? 0.0).toDouble(),
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'payment_id': paymentId,
        'booking_id': bookingId,
        'payment_method': paymentMethod,
        'status': status,
        'amount': amount,
        'timestamp': timestamp,
      };
}
