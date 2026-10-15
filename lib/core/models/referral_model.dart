class ReferralModel {
  final String referralCode;
  final double rewardAmount;
  final int totalReferrals;
  final int successfulReferrals;
  final double totalRewardsEarned;

  ReferralModel({
    required this.referralCode,
    required this.rewardAmount,
    required this.totalReferrals,
    required this.successfulReferrals,
    required this.totalRewardsEarned,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      referralCode: json['referral_code'] ?? 'AVVOCAT200',
      rewardAmount: (json['reward_amount'] ?? 200.0).toDouble(),
      totalReferrals: json['total_referrals'] ?? 0,
      successfulReferrals: json['successful_referrals'] ?? 0,
      totalRewardsEarned: (json['total_rewards_earned'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'referral_code': referralCode,
        'reward_amount': rewardAmount,
        'total_referrals': totalReferrals,
        'successful_referrals': successfulReferrals,
        'total_rewards_earned': totalRewardsEarned,
      };
}
