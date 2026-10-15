import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../../../../core/localization/app_localizations.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('manage_address'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Home Address',
                                style: AppTextStyles.headingSmall(
                                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                                ),
                              ),
                              AppStatusBadge(
                                statusText: 'Default',
                                type: AppStatusType.success,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No. 42, 3rd Main Road, Anna Nagar, Chennai, Tamil Nadu - 600040',
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(context.tr('edit')),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  context.tr('delete'),
                                  style: const TextStyle(color: AppColors.alertRed),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                text: context.tr('add_new_address'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
