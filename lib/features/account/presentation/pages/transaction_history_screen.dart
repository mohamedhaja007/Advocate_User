import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _selectedFilter = 'All Records';

  final List<String> _filters = ['All Records', 'Paid', 'Pending', 'Refunded'];

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
                    'Transaction',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Financial Dossier Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Financial Dossier',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark ? const Color(0xFF2E3B54) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 14, color: AppColors.primaryBlue),
                        const SizedBox(width: 4),
                        Text(
                          '2026–27',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
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
            ),
            const SizedBox(height: 8),

            // Horizontal Filter Chips Strip
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final f = _filters[index];
                  final isSelected = _selectedFilter == f;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = f;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A))
                            : (isDark ? AppColors.darkCard : AppColors.white),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                        ),
                      ),
                      child: Text(
                        f,
                        style: AppTextStyles.caption(
                          color: isSelected
                              ? AppColors.white
                              : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Month Summary Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'September 2026',
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '3 Transactions',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Net ₹7,000',
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Transactions List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildTransactionCard(
                    title: 'Video Consultation',
                    lawyerName: 'Elena Marlowe',
                    lawyerSub: 'Senior Family Lawyer • 12 years exp',
                    callTimeBadge: 'Call Time: 16 mins',
                    dateText: '15 Sep 2026',
                    timeText: '10:30 – 10:45AM',
                    txnId: 'TXN554433221',
                    priceText: '₹499',
                    statusText: 'Paid',
                    statusColor: const Color(0xFF10B981),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionCard(
                    title: 'Doorstep Consultation',
                    lawyerName: 'Berna',
                    lawyerSub: 'Corporate Advocate • Supreme Court',
                    callTimeBadge: 'Completed',
                    dateText: '10 Sep 2026',
                    timeText: '02:00 – 02:45PM',
                    txnId: 'TXN554433220',
                    priceText: '₹1,499',
                    statusText: 'Paid',
                    statusColor: const Color(0xFF10B981),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionCard(
                    title: 'Retainer Booking',
                    lawyerName: 'Adv. Elena Marlowe',
                    lawyerSub: 'Senior Family Lawyer',
                    callTimeBadge: 'Retainer Deposit',
                    dateText: '02 Sep 2026',
                    timeText: '11:00 AM',
                    txnId: 'TXN554433219',
                    priceText: '₹5,000',
                    statusText: 'Paid',
                    statusColor: const Color(0xFF10B981),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    required String title,
    required String lawyerName,
    required String lawyerSub,
    required String callTimeBadge,
    required String dateText,
    required String timeText,
    required String txnId,
    required String priceText,
    required String statusText,
    required Color statusColor,
    required bool isDark,
  }) {
    return Container(
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
          // Header Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.videocam_outlined, size: 16, color: AppColors.primaryBlue),
                  const SizedBox(width: 6),
                  Text(
                    title,
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 10, color: statusColor),
                    const SizedBox(width: 3),
                    Text(
                      statusText,
                      style: AppTextStyles.caption(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Lawyer Details
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Png/Man.png',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 42,
                    height: 42,
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
                            callTimeBadge,
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
          const SizedBox(height: 12),

          // Date & Time Row
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
          const SizedBox(height: 12),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
          const SizedBox(height: 10),

          // Reference TXN & Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    txnId,
                    style: AppTextStyles.caption(
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: txnId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transaction ID copied to clipboard'),
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
              Text(
                priceText,
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
