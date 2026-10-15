import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/localization/app_localizations.dart';

class NoticeScannerScreen extends StatelessWidget {
  const NoticeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('notice_scanner_title'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    context.tr('upload_notice_desc'),
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_rounded,
                          size: 48,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Scan or Capture Notice',
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : AppColors.primaryNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppButton(
                text: context.tr('start_analysis'),
                onPressed: () {
                  context.push('/document-analysis', extra: 'notice_1');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
