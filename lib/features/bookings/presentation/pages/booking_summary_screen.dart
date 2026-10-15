import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class BookingSummaryScreen extends StatelessWidget {
  final LawyerModel lawyer;
  final ConsultationType type;
  final String date;
  final String time;

  const BookingSummaryScreen({
    super.key,
    required this.lawyer,
    required this.type,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withAlpha(8),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Summary',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Main Summary Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.white,
                        borderRadius: BorderRadius.circular(20),
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
                          // Lawyer Info Header Row
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/Png/Man.png',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) => Container(
                                    width: 44,
                                    height: 44,
                                    color: AppColors.primaryBlue.withAlpha(30),
                                    child: const Icon(Icons.person, color: AppColors.primaryBlue),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.videocam_outlined, size: 14, color: AppColors.primaryBlue),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Video Consultation',
                                          style: AppTextStyles.bodyMedium(
                                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text(
                                          '15 mins',
                                          style: AppTextStyles.caption(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          lawyer.name,
                                          style: AppTextStyles.caption(
                                            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Senior Family Lawyer',
                                      style: AppTextStyles.caption(
                                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_rounded, size: 10, color: Color(0xFF10B981)),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Verified',
                                      style: AppTextStyles.caption(
                                        color: const Color(0xFF10B981),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                          const SizedBox(height: 16),

                          // Date & Time Row
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined, size: 15, color: AppColors.primaryBlue),
                              const SizedBox(width: 6),
                              Text(
                                'Today, 16 Sep 2026',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.access_time_rounded, size: 15, color: AppColors.primaryBlue),
                              const SizedBox(width: 6),
                              Text(
                                '10:30 - 10:45AM',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Fee Lines
                          _buildFeeRow('Consultation Base Fee (15m)', '₹499.00', isDark),
                          const SizedBox(height: 10),
                          _buildFeeRow('Platform & Escrow Fee', 'FREE', isDark, isHighlightGreen: true),
                          const SizedBox(height: 10),
                          _buildFeeRow('GST (Included)', '₹0.00', isDark),
                          const SizedBox(height: 14),
                          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                          const SizedBox(height: 14),
                          _buildFeeRow('Total Payable', '₹499', isDark, isTotal: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Discount Coupon Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer_outlined, size: 18, color: Color(0xFF64748B)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Apply Shield discount',
                              style: AppTextStyles.bodySmall(
                                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                              foregroundColor: AppColors.primaryBlue,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: AppTextStyles.caption(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Selected Payment Option Card
                    GestureDetector(
                      onTap: () {
                        context.push(
                          '/payment',
                          extra: {
                            'lawyer': lawyer,
                            'type': type,
                            'date': date,
                            'time': time,
                            'fee': 499.0,
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text('🔹 ', style: TextStyle(fontSize: 16)),
                            Text(
                              'Gpay',
                              style: AppTextStyles.bodyMedium(
                                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 20,
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Pay Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/payment',
                      extra: {
                        'lawyer': lawyer,
                        'type': type,
                        'date': date,
                        'time': time,
                        'fee': 499.0,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                    foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Pay ₹499',
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeRow(
    String label,
    String value,
    bool isDark, {
    bool isHighlightGreen = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall(
            color: isTotal
                ? (isDark ? AppColors.white : const Color(0xFF0F172A))
                : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium(
            color: isHighlightGreen
                ? const Color(0xFF10B981)
                : (isDark ? AppColors.white : const Color(0xFF0F172A)),
            fontWeight: isTotal || isHighlightGreen ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
