import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_avatar.dart';

class LawyerCardWidget extends StatelessWidget {
  final LawyerModel lawyer;
  final VoidCallback onTap;
  final VoidCallback onBookVisit;

  const LawyerCardWidget({
    super.key,
    required this.lawyer,
    required this.onTap,
    required this.onBookVisit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(6),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Info, Bookmark
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                imageUrl: lawyer.imageUrl,
                name: lawyer.name,
                radius: 26,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            lawyer.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.headingSmall(
                              color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 10,
                                color: AppColors.primaryBlue,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Verified',
                                style: AppTextStyles.caption(
                                  color: AppColors.primaryBlue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${lawyer.specializations.join(', ')} • ${lawyer.experienceYears} yrs exp',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 3),
                        Text(
                          '${lawyer.rating}',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (${lawyer.reviewsCount} reviews)',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '• ${lawyer.location}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border_rounded, size: 20),
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Consultation Pricing Options Grid
          Row(
            children: [
              Expanded(
                child: _buildConsultationOption(
                  label: 'VIDEO',
                  price: '₹499',
                  duration: '15 mins',
                  isDark: isDark,
                  onTap: () => context.push('/video-call'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildConsultationOption(
                  label: 'AUDIO',
                  price: '₹299',
                  duration: '30 mins',
                  isDark: isDark,
                  onTap: () => context.push('/audio-call'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildConsultationOption(
                  label: 'IN-PERSON',
                  price: '₹1,499',
                  duration: 'At Home/Office',
                  isDark: isDark,
                  onTap: onBookVisit,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Footer: Next Availability & Book Consult Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next: ',
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                        ),
                      ),
                      TextSpan(
                        text: 'Today, 10:30 AM',
                        style: AppTextStyles.caption(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onBookVisit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                  foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Book Consult',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationOption({
    required String label,
    required String price,
    required String duration,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF242D45) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? const Color(0xFF2E3B54) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.caption(
                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: AppTextStyles.bodySmall(
                color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              duration,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
