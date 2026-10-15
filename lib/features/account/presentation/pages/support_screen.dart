import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../../../../core/localization/app_localizations.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('help_support'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('create_ticket'),
                style: AppTextStyles.headingSmall(
                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: context.tr('ticket_subject'),
                hintText: 'e.g. Issue with booking payment',
                controller: _subjectController,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: context.tr('ticket_description'),
                hintText: 'Describe your issue in detail...',
                controller: _descController,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: context.tr('submit_ticket'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Support ticket created successfully!')),
                  );
                  _subjectController.clear();
                  _descController.clear();
                },
              ),
              const SizedBox(height: 28),
              Text(
                context.tr('support_tickets'),
                style: AppTextStyles.headingSmall(
                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 12),
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TKT-8841',
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : AppColors.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Payment failed for booking',
                          style: AppTextStyles.bodySmall(color: AppColors.grey),
                        ),
                      ],
                    ),
                    AppStatusBadge(statusText: 'Open', type: AppStatusType.info),
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
