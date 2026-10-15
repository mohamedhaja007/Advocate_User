import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../../../../core/localization/app_localizations.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('membership_plans'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Free Plan Card
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic Plan',
                      style: AppTextStyles.headingMedium(
                        color: isDark ? AppColors.white : AppColors.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('₹0 / Free Forever', style: AppTextStyles.caption(color: AppColors.grey)),
                    const SizedBox(height: 12),
                    const Text('• 5 AI questions per month'),
                    const Text('• 1 Document scan per month'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Premium Plan Card
              AppCard(
                color: isDark ? AppColors.primaryBlue.withAlpha(30) : AppColors.lightBlue,
                border: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Premium Pro Plan',
                          style: AppTextStyles.headingMedium(
                            color: isDark ? AppColors.white : AppColors.primaryNavy,
                          ),
                        ),
                        AppStatusBadge(
                          statusText: context.tr('current_plan'),
                          type: AppStatusType.success,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('₹499 / Month', style: AppTextStyles.headingSmall(color: AppColors.primaryBlue)),
                    const SizedBox(height: 12),
                    const Text('• Unlimited AI Legal Questions'),
                    const Text('• 20 Document Scans & Risk Analysis'),
                    const Text('• 15% Discount on Lawyer Consultations'),
                    const SizedBox(height: 16),
                    AppButton(
                      text: context.tr('upgrade_plan'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
