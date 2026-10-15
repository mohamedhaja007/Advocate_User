import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/localization/app_localizations.dart';

class ConsultationTypeScreen extends StatefulWidget {
  final LawyerModel lawyer;

  const ConsultationTypeScreen({
    super.key,
    required this.lawyer,
  });

  @override
  State<ConsultationTypeScreen> createState() => _ConsultationTypeScreenState();
}

class _ConsultationTypeScreenState extends State<ConsultationTypeScreen> {
  ConsultationType _selectedType = ConsultationType.video;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('select_booking_type'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('how_to_consult'),
                style: AppTextStyles.headingMedium(
                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 20),

              // Option 1: Video Consultation
              _buildTypeCard(
                type: ConsultationType.video,
                title: context.tr('video_consultation'),
                subtitle: '15 mins video call',
                fee: '₹${widget.lawyer.videoFee.toInt()}',
                icon: Icons.videocam_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 14),

              // Option 2: Phone Consultation
              _buildTypeCard(
                type: ConsultationType.phone,
                title: context.tr('phone_consultation'),
                subtitle: '30 mins direct call',
                fee: '₹${widget.lawyer.phoneFee.toInt()}',
                icon: Icons.phone_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 14),

              // Option 3: Doorstep Consultation
              _buildTypeCard(
                type: ConsultationType.doorstep,
                title: context.tr('doorstep_consultation'),
                subtitle: 'Within 5 km radius',
                fee: '₹${widget.lawyer.doorstepFee.toInt()}',
                icon: Icons.home_work_rounded,
                isDark: isDark,
              ),

              const Spacer(),
              AppButton(
                text: context.tr('continue_text'),
                onPressed: () {
                  context.push(
                    '/slot-selection',
                    extra: {
                      'lawyer': widget.lawyer,
                      'type': _selectedType,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard({
    required ConsultationType type,
    required String title,
    required String subtitle,
    required String fee,
    required IconData icon,
    required bool isDark,
  }) {
    final isSelected = _selectedType == type;

    return AppCard(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      color: isDark
          ? (isSelected ? AppColors.primaryBlue.withAlpha(40) : AppColors.darkCard)
          : (isSelected ? AppColors.lightBlue : AppColors.lightCard),
      border: BorderSide(
        color: isSelected
            ? AppColors.primaryBlue
            : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
        width: isSelected ? 1.5 : 1,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryBlue
                  : (isDark ? AppColors.darkSurface : AppColors.lightBackground),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.primaryNavy,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headingSmall(
                    color: isDark ? AppColors.white : AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            fee,
            style: AppTextStyles.headingSmall(
              color: isSelected ? AppColors.primaryBlue : (isDark ? AppColors.white : AppColors.primaryNavy),
            ),
          ),
        ],
      ),
    );
  }
}
