import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SlotSelectionScreen extends StatefulWidget {
  final LawyerModel lawyer;
  final ConsultationType type;

  const SlotSelectionScreen({
    super.key,
    required this.lawyer,
    required this.type,
  });

  @override
  State<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen> {
  int _selectedDateIndex = 0;
  String _selectedTimeSlot = '10:30 AM';

  final List<Map<String, String>> _dates = [
    {'day': 'Mon', 'date': '21'},
    {'day': 'Tue', 'date': '22'},
    {'day': 'Wed', 'date': '23'},
    {'day': 'Thu', 'date': '24'},
    {'day': 'Fri', 'date': '25'},
    {'day': 'Sat', 'date': '26'},
  ];

  final List<Map<String, dynamic>> _morningSlots = [
    {'time': '09:30 AM', 'sub': '15 mins video', 'status': 'Booked'},
    {'time': '10:30 AM', 'sub': '10:45 AM', 'status': 'Selected'},
    {'time': '11:15 AM', 'sub': '11:30 AM', 'status': 'Available'},
    {'time': '11:45 AM', 'sub': '12:00 PM', 'status': 'Available'},
  ];

  final List<Map<String, dynamic>> _afternoonSlots = [
    {'time': '02:00 PM', 'sub': '02:15 PM', 'status': 'Unavailable'},
    {'time': '03:30 PM', 'sub': '03:45 PM', 'status': 'Available'},
    {'time': '04:15 PM', 'sub': '04:30 PM', 'status': 'Available'},
  ];

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
                    'Select Date and Time',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lawyer Consultation Summary Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/Png/Man.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) => Container(
                                    width: 40,
                                    height: 40,
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
                                    Text(
                                      '${widget.lawyer.name} • Senior Family Lawyer',
                                      style: AppTextStyles.caption(
                                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: Text(
                                  'Change',
                                  style: AppTextStyles.caption(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.shield_outlined, size: 14, color: AppColors.primaryBlue),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Standard Retainer Slot',
                                    style: AppTextStyles.caption(
                                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Calendar Month Header
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 6),
                        Text(
                          'September 2026',
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Horizontal Date Selector Strip
                    SizedBox(
                      height: 64,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _dates.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final item = _dates[index];
                          final isSelected = _selectedDateIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDateIndex = index;
                              });
                            },
                            child: Container(
                              width: 52,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF0F213A)
                                    : (isDark ? AppColors.darkCard : AppColors.white),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['day']!,
                                    style: AppTextStyles.caption(
                                      color: isSelected
                                          ? AppColors.white.withAlpha(200)
                                          : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['date']!,
                                    style: AppTextStyles.bodyMedium(
                                      color: isSelected
                                          ? AppColors.white
                                          : (isDark ? AppColors.white : const Color(0xFF0F172A)),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Morning Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('🌅 ', style: TextStyle(fontSize: 14)),
                            Text(
                              'Morning',
                              style: AppTextStyles.bodyMedium(
                                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '9:00 AM – 12:00 PM',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _morningSlots.length,
                      itemBuilder: (context, index) {
                        return _buildSlotCard(_morningSlots[index], isDark);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Afternoon Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('☀️ ', style: TextStyle(fontSize: 14)),
                            Text(
                              'Afternoon',
                              style: AppTextStyles.bodyMedium(
                                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '12:00 PM – 5:00 PM',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _afternoonSlots.length,
                      itemBuilder: (context, index) {
                        return _buildSlotCard(_afternoonSlots[index], isDark);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Button
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
                      '/booking-summary',
                      extra: {
                        'lawyer': widget.lawyer,
                        'type': widget.type,
                        'date': 'Today, 16 Sep 2026',
                        'time': _selectedTimeSlot,
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
                    'Continue',
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

  Widget _buildSlotCard(Map<String, dynamic> slot, bool isDark) {
    final timeStr = slot['time'] as String;
    final subStr = slot['sub'] as String;
    final statusStr = slot['status'] as String;

    final isSelected = _selectedTimeSlot == timeStr;
    final isBooked = statusStr == 'Booked' || statusStr == 'Unavailable';

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() {
                _selectedTimeSlot = timeStr;
              });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isBooked
              ? (isDark ? const Color(0xFF1E2638).withAlpha(100) : const Color(0xFFF1F5F9))
              : (isSelected
                  ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF))
                  : (isDark ? AppColors.darkCard : AppColors.white)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeStr,
                  style: AppTextStyles.bodySmall(
                    color: isBooked
                        ? (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8))
                        : (isDark ? AppColors.white : const Color(0xFF0F172A)),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (statusStr == 'Available')
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subStr,
                  style: AppTextStyles.caption(
                    color: isBooked
                        ? (isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1))
                        : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                    fontSize: 10,
                  ),
                ),
                Text(
                  statusStr,
                  style: AppTextStyles.caption(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : (isBooked
                            ? (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8))
                            : const Color(0xFF10B981)),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
