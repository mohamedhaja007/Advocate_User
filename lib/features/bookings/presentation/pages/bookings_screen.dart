import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/booking_cubit.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().loadUserBookings();
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Booking',
                        style: AppTextStyles.headingMedium(
                          color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () async {
                          final selectedLoc = await context.push<String>('/choose-location');
                          if (selectedLoc != null && mounted) {
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Chennai',
                              style: AppTextStyles.caption(
                                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
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
                      Icons.notifications_none_rounded,
                      color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Segmented Tab Selector Pills matching design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabPill('Upcoming', 2, 0, isDark),
                    ),
                    Expanded(
                      child: _buildTabPill('Completed', 1, 1, isDark),
                    ),
                    Expanded(
                      child: _buildTabPill('Cancelled', 1, 2, isDark),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tab View Body Content
            Expanded(
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const AppLoader(message: 'Loading bookings...');
                  } else if (state is BookingError) {
                    return AppErrorView(
                      message: state.message,
                      onRetry: () => context.read<BookingCubit>().loadUserBookings(),
                    );
                  }

                  if (_selectedTabIndex == 0) {
                    return _buildUpcomingTab(isDark);
                  } else if (_selectedTabIndex == 1) {
                    return _buildCompletedTab(isDark);
                  } else {
                    return _buildCancelledTab(isDark);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Segmented Pill Tab Helper
  Widget _buildTabPill(String label, int count, int index, bool isDark) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF2E3B54) : AppColors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected && !isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.caption(
                color: isSelected
                    ? (isDark ? AppColors.white : const Color(0xFF0F172A))
                    : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColors.primaryBlue : const Color(0xFF0F172A))
                    : (isDark ? const Color(0xFF2A364F) : const Color(0xFFE2E8F0)),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: AppTextStyles.caption(
                  color: isSelected ? AppColors.white : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 1: UPCOMING BOOKINGS VIEW
  Widget _buildUpcomingTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Card 1: Video Consultation
          _buildUpcomingCard(
            typeLabel: 'Video Consultation',
            icon: Icons.videocam_outlined,
            lawyerName: 'Elena Marlowe',
            lawyerSub: 'Senior Family Lawyer • 12 years exp',
            durationBadge: '15 mins',
            statusBadge: 'Confirmed',
            countdownText: 'Starts in 45 mins',
            priceText: '₹499 (incl. taxes)',
            dateText: 'Today, 16 Sep 2026',
            timeText: '10:30 - 10:45AM',
            caseId: '#1265-8262',
            isDark: isDark,
            onJoinCall: () => context.push('/video-call'),
          ),
          const SizedBox(height: 16),

          // Card 2: Doorstep Consultation (Rescheduled by Lawyer)
          _buildRescheduledDoorstepCard(isDark),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // TAB 2: COMPLETED BOOKINGS VIEW
  Widget _buildCompletedTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
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
                // Top Badge Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.videocam_outlined, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 6),
                        Text(
                          'Video Consultation',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF064E3B) : const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_rounded, size: 10, color: Color(0xFF059669)),
                          const SizedBox(width: 3),
                          Text(
                            'Completed',
                            style: AppTextStyles.caption(
                              color: const Color(0xFF059669),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Lawyer Info
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
                              Text(
                                'Elena Marlowe',
                                style: AppTextStyles.bodyMedium(
                                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Call Time: 16 mins',
                                  style: AppTextStyles.caption(
                                    color: AppColors.primaryBlue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Senior Family Lawyer • 12 years exp',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Price & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Finished',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '₹499 ',
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '(incl. taxes)',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Date & Time
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, size: 14, color: AppColors.primaryBlue),
                    const SizedBox(width: 4),
                    Text(
                      '15 Sep 2026',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_rounded, size: 14, color: AppColors.primaryBlue),
                    const SizedBox(width: 4),
                    Text(
                      '10:30 – 10:45AM',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Case ID & Star Rating + Book Again
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Good  ',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                          ),
                        ),
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const Icon(Icons.star_border_rounded, size: 14, color: Color(0xFFCBD5E1)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/slot-selection');
                      },
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
                        children: [
                          Text(
                            'Book again',
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
          ),
        ],
      ),
    );
  }

  // TAB 3: CANCELLED BOOKINGS VIEW
  Widget _buildCancelledTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
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
                // Header Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.videocam_outlined, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 6),
                        Text(
                          'Video Consultation',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF451A1A) : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cancel_rounded, size: 10, color: Color(0xFFEF4444)),
                          const SizedBox(width: 3),
                          Text(
                            'Canceled',
                            style: AppTextStyles.caption(
                              color: const Color(0xFFEF4444),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Lawyer Info
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
                          Text(
                            'Elena Marlowe',
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Senior Family Lawyer • 12 years exp',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Date & Time (Strikethrough)
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, size: 14, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 4),
                    Text(
                      '15 Sep 2026',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                      ).copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 4),
                    Text(
                      '10:30 – 10:45AM',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                      ).copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Canceled on 15 Sep 2026',
                  style: AppTextStyles.caption(
                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Refund Processing Status Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2638) : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? const Color(0xFF2A364F) : const Color(0xFFDBEAFE),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sync_rounded, size: 16, color: AppColors.primaryBlue),
                              const SizedBox(width: 6),
                              Text(
                                'Processing',
                                style: AppTextStyles.bodySmall(
                                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '₹499',
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'The amount will be refunded within 2 days from the cancellation date.',
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Upcoming Video Card Widget
  Widget _buildUpcomingCard({
    required String typeLabel,
    required IconData icon,
    required String lawyerName,
    required String lawyerSub,
    required String durationBadge,
    required String statusBadge,
    required String countdownText,
    required String priceText,
    required String dateText,
    required String timeText,
    required String caseId,
    required bool isDark,
    required VoidCallback onJoinCall,
  }) {
    return Container(
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
          // Header Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: AppColors.primaryBlue),
                  const SizedBox(width: 6),
                  Text(
                    typeLabel,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF064E3B) : const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 10, color: Color(0xFF059669)),
                    const SizedBox(width: 3),
                    Text(
                      statusBadge,
                      style: AppTextStyles.caption(
                        color: const Color(0xFF059669),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Lawyer Info
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
                        Text(
                          lawyerName,
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            durationBadge,
                            style: AppTextStyles.caption(
                              color: AppColors.primaryBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lawyerSub,
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Countdown Badge & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    countdownText,
                    style: AppTextStyles.caption(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$priceText ',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, size: 14, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(
                dateText,
                style: AppTextStyles.caption(
                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time_rounded, size: 14, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(
                timeText,
                style: AppTextStyles.caption(
                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Primary Join Call Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onJoinCall,
              icon: const Icon(Icons.videocam_outlined, size: 20),
              label: const Text('Join Video Consultation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: AppTextStyles.bodyMedium(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Secondary Action Buttons Row
          Row(
            children: [
              Expanded(
                child: _buildSecondaryActionButton('Reschedule', Icons.calendar_today_outlined, isDark, () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSecondaryActionButton('Message', Icons.chat_bubble_outline_rounded, isDark, () {
                  context.push('/advocate-chat', extra: {
                    'lawyerName': lawyerName,
                  });
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSecondaryActionButton('Cancel', Icons.cancel_outlined, isDark, () {}, isRed: true),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Case ID Footer
          Row(
            children: [
              Text(
                'Case id $caseId',
                style: AppTextStyles.caption(
                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: caseId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Case ID copied to clipboard'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Icon(
                  Icons.copy_rounded,
                  size: 12,
                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Rescheduled Doorstep Card Widget
  Widget _buildRescheduledDoorstepCard(bool isDark) {
    return Container(
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
          // Header Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.home_outlined, size: 16, color: AppColors.primaryBlue),
                  const SizedBox(width: 6),
                  Text(
                    'Doorstep Consultation',
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Lawyer Rescheduled',
                  style: AppTextStyles.caption(
                    color: AppColors.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Lawyer Info
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
                        Text(
                          'Elena Marlowe',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '45 mins',
                            style: AppTextStyles.caption(
                              color: AppColors.primaryBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Senior Family Lawyer',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Reschedule Notice Alert Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E2638) : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF2A364F) : const Color(0xFFDBEAFE),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Slot shifted from 16 Sep 10:00 AM to 17 Sep 04:00 PM due to Madras High Court Division Bench listing conflict.',
                    style: AppTextStyles.caption(
                      color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E40AF),
                      fontSize: 11,
                    ).copyWith(height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Price & Countdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Starts in Tomorrow',
                    style: AppTextStyles.caption(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '₹1499 (incl. taxes)',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Doorstep Location Address Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flat 4B, Emerald Heights, Gandhi Nagar 1st Cross, Adyar, Chennai - 600020',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                      ).copyWith(height: 1.3),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Get Direction >',
                        style: AppTextStyles.caption(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Primary Accept New Slot Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Accept New Slot',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Secondary Action Buttons Row
          Row(
            children: [
              Expanded(
                child: _buildSecondaryActionButton('Pick up another time', Icons.calendar_today_outlined, isDark, () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSecondaryActionButton('Message', Icons.chat_bubble_outline_rounded, isDark, () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSecondaryActionButton('Cancel', Icons.cancel_outlined, isDark, () {}, isRed: true),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Case ID Footer
          Text(
            'Case id #1265-8263',
            style: AppTextStyles.caption(
              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Action Button Helper
  Widget _buildSecondaryActionButton(
    String label,
    IconData icon,
    bool isDark,
    VoidCallback onTap, {
    bool isRed = false,
  }) {
    final bgColor = isRed
        ? (isDark ? const Color(0xFF451A1A) : const Color(0xFFFEE2E2))
        : (isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9));

    final textColor = isRed
        ? const Color(0xFFEF4444)
        : (isDark ? AppColors.white : const Color(0xFF334155));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
