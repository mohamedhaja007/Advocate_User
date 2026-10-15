class AvailabilitySlotModel {
  final String id;
  final String time;
  final bool isAvailable;
  final bool isSelected;

  AvailabilitySlotModel({
    required this.id,
    required this.time,
    this.isAvailable = true,
    this.isSelected = false,
  });

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlotModel(
      id: json['id'] ?? '',
      time: json['time'] ?? '',
      isAvailable: json['is_available'] ?? json['isAvailable'] ?? true,
      isSelected: json['is_selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time,
        'is_available': isAvailable,
        'is_selected': isSelected,
      };
}

class LawyerModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final String location;
  final double distanceKm;
  final bool isOnline;
  final bool isVerified;
  final String barCouncilId;
  final List<String> specializations;
  final List<String> languages;
  final String about;
  final double videoFee;
  final double phoneFee;
  final double doorstepFee;
  final bool isSaved;

  LawyerModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.location,
    required this.distanceKm,
    this.isOnline = false,
    this.isVerified = true,
    this.barCouncilId = 'BCI/12345/2015',
    required this.specializations,
    required this.languages,
    required this.about,
    required this.videoFee,
    required this.phoneFee,
    required this.doorstepFee,
    this.isSaved = false,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviews_count'] ?? json['reviewsCount'] ?? 0,
      experienceYears: json['experience_years'] ?? json['experienceYears'] ?? 0,
      location: json['location'] ?? '',
      distanceKm: (json['distance_km'] ?? json['distanceKm'] ?? 0.0).toDouble(),
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
      isVerified: json['is_verified'] ?? json['isVerified'] ?? true,
      barCouncilId: json['bar_council_id'] ?? 'BCI/12345/2015',
      specializations: List<String>.from(json['specializations'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      about: json['about'] ?? '',
      videoFee: (json['video_fee'] ?? json['videoFee'] ?? 1500.0).toDouble(),
      phoneFee: (json['phone_fee'] ?? json['phoneFee'] ?? 1000.0).toDouble(),
      doorstepFee: (json['doorstep_fee'] ?? json['doorstepFee'] ?? 2500.0).toDouble(),
      isSaved: json['is_saved'] ?? json['isSaved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'reviews_count': reviewsCount,
      'experience_years': experienceYears,
      'location': location,
      'distance_km': distanceKm,
      'is_online': isOnline,
      'is_verified': isVerified,
      'bar_council_id': barCouncilId,
      'specializations': specializations,
      'languages': languages,
      'about': about,
      'video_fee': videoFee,
      'phone_fee': phoneFee,
      'doorstep_fee': doorstepFee,
      'is_saved': isSaved,
    };
  }
}
