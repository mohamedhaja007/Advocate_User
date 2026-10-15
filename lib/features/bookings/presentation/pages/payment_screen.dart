import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/booking_cubit.dart';

class PaymentScreen extends StatefulWidget {
  final LawyerModel lawyer;
  final ConsultationType type;
  final String date;
  final String time;
  final double fee;

  const PaymentScreen({
    super.key,
    required this.lawyer,
    required this.type,
    required this.date,
    required this.time,
    required this.fee,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Gpay';

  void _onPayNow(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
    context.read<BookingCubit>().confirmAndPayBooking(
          lawyer: widget.lawyer,
          type: widget.type,
          date: widget.date,
          time: widget.time,
          fee: widget.fee,
          paymentMethod: method,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingConfirmedState) {
          context.go(
            '/booking-confirmation',
            extra: {
              'booking': state.booking,
              'payment': state.payment,
            },
          );
        } else if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
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
                      'Payment',
                      style: AppTextStyles.headingMedium(
                        color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Options List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: UPI Apps
                      Text(
                        'UPI apps',
                        style: AppTextStyles.headingSmall(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildPaymentRow(
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: const Color(0xFF4285F4),
                              title: 'Gpay',
                              isDark: isDark,
                              onTap: () => _onPayNow('Gpay'),
                            ),
                            Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                            _buildPaymentRow(
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: const Color(0xFF5F259F),
                              title: 'Phonepay',
                              isDark: isDark,
                              onTap: () => _onPayNow('Phonepe'),
                            ),
                            Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                            _buildPaymentRow(
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: const Color(0xFF00B9F1),
                              title: 'Paytm',
                              isDark: isDark,
                              onTap: () => _onPayNow('Paytm'),
                            ),
                            Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                            _buildPaymentRow(
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: const Color(0xFFE40000),
                              title: 'Airtel payments bank',
                              isDark: isDark,
                              onTap: () => _onPayNow('Airtel Payments'),
                            ),
                            Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                            _buildPaymentRow(
                              icon: Icons.add_rounded,
                              iconColor: isDark ? AppColors.white : const Color(0xFF64748B),
                              title: 'Add new UPI',
                              isDark: isDark,
                              onTap: () => _onPayNow('Custom UPI'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section 2: Cards & Bank
                      Text(
                        'Cards & Bank',
                        style: AppTextStyles.headingSmall(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildPaymentRow(
                              icon: Icons.credit_card_rounded,
                              iconColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                              title: 'Credit / Debit Card',
                              subtitle: 'Visa, MasterCard, RuPay, Amex',
                              isDark: isDark,
                              onTap: () => _onPayNow('Card'),
                            ),
                            Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                            _buildPaymentRow(
                              icon: Icons.account_balance_rounded,
                              iconColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                              title: 'Net Banking',
                              subtitle: 'All major Indian banks supported',
                              isDark: isDark,
                              onTap: () => _onPayNow('Net Banking'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedPaymentMethod == title;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: isSelected
            ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF).withAlpha(100))
            : Colors.transparent,
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.chevron_right_rounded,
              size: 20,
              color: isSelected
                  ? AppColors.primaryBlue
                  : (isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
            ),
          ],
        ),
      ),
    );
  }
}
