class MembershipModel {
  final String id;
  final String planName;
  final double price;
  final String duration;
  final int aiQuestionLimit;
  final int documentLimit;
  final double lawyerDiscountPercentage;
  final bool isCurrentPlan;

  MembershipModel({
    required this.id,
    required this.planName,
    required this.price,
    required this.duration,
    required this.aiQuestionLimit,
    required this.documentLimit,
    required this.lawyerDiscountPercentage,
    this.isCurrentPlan = false,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id'] ?? '',
      planName: json['plan_name'] ?? json['planName'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? '1 Month',
      aiQuestionLimit: json['ai_question_limit'] ?? 10,
      documentLimit: json['document_limit'] ?? 2,
      lawyerDiscountPercentage: (json['lawyer_discount_percentage'] ?? 0.0).toDouble(),
      isCurrentPlan: json['is_current_plan'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'plan_name': planName,
        'price': price,
        'duration': duration,
        'ai_question_limit': aiQuestionLimit,
        'document_limit': documentLimit,
        'lawyer_discount_percentage': lawyerDiscountPercentage,
        'is_current_plan': isCurrentPlan,
      };
}
