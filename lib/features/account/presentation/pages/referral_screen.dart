import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/localization/app_localizations.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('refer_earn'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Icon(
                Icons.card_giftcard_rounded,
                size: 80,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: 16),
              Text(
                'Refer Friends & Earn ₹200',
                style: AppTextStyles.brandTitle(
                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your referral code with friends. When they book their first consultation, you both get ₹200 wallet cash.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                ),
              ),
              const SizedBox(height: 28),

              // Code Box
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AVVOCAT200',
                      style: AppTextStyles.headingLarge(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Referral code copied!')),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 18),
                      label: Text(context.tr('copy_code')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          Text('12', style: AppTextStyles.headingLarge(color: isDark ? AppColors.white : AppColors.primaryNavy)),
                          const SizedBox(height: 4),
                          Text(context.tr('total_referrals'), style: AppTextStyles.caption(color: AppColors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          Text('₹1,600', style: AppTextStyles.headingLarge(color: AppColors.successGreen)),
                          const SizedBox(height: 4),
                          Text(context.tr('total_earned'), style: AppTextStyles.caption(color: AppColors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              AppButton(
                text: context.tr('share_code'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
