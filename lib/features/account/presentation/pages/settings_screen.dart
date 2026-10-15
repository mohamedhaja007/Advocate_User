import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/theme_selection_modal.dart';
import '../../../../core/localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('settings'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AppCard(
                onTap: () => showThemeSelectionModal(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Theme',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : AppColors.primaryNavy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              AppCard(
                onTap: () => context.push('/choose-language'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.language_rounded,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          context.tr('preferred_language'),
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : AppColors.primaryNavy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grey,
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
