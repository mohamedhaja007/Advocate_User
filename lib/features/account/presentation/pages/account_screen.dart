import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/theme_selection_modal.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/account_cubit.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double _walletBalance = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().loadAccountData();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            final userName = state is AccountLoaded ? state.user.fullName : 'Aarav Sharma';
            final userPhone = state is AccountLoaded ? state.user.phone : '+91 98234 56789';
            final userEmail = state is AccountLoaded ? state.user.email : 'aarav.sharma@startup.io';

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Title Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: AppTextStyles.headingMedium(
                            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Info Card
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
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                'assets/images/Png/Man.png',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  width: 48,
                                  height: 48,
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
                                      Flexible(
                                        child: Text(
                                          userName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.headingSmall(
                                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        size: 16,
                                        color: AppColors.primaryBlue,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Startup Founder & Tech Entrepreneur',
                                    style: AppTextStyles.caption(
                                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => context.push('/profile'),
                              icon: const Icon(Icons.edit_outlined, size: 12),
                              label: const Text('Edit Profile'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                side: BorderSide(
                                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textStyle: AppTextStyles.caption(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Info Details Sub-Container
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF242D45) : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.phone_android_outlined, size: 14, color: AppColors.primaryBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    userPhone,
                                    style: AppTextStyles.caption(
                                      color: isDark ? AppColors.white : const Color(0xFF334155),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 14, color: AppColors.primaryBlue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      userEmail,
                                      style: AppTextStyles.caption(
                                        color: isDark ? AppColors.white : const Color(0xFF334155),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primaryBlue),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Chennai, India',
                                        style: AppTextStyles.caption(
                                          color: isDark ? AppColors.white : const Color(0xFF334155),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Wallet Card
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
                        const Icon(Icons.account_balance_wallet_outlined, size: 20, color: AppColors.primaryBlue),
                        const SizedBox(width: 10),
                        Text(
                          '₹ ${_walletBalance.toInt()} Wallet',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => _showAddMoneyBottomSheet(context, isDark),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                            foregroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add Money',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 1: LEGAL & CASE MANAGEMENT
                  _buildSectionTitle('LEGAL & CASE MANAGEMENT', isDark),
                  const SizedBox(height: 8),
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
                        _buildMenuRow(
                          icon: Icons.people_outline_rounded,
                          title: 'Saved Advocates & Retainers',
                          isDark: isDark,
                          onTap: () => context.push('/saved-lawyers'),
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.assignment_outlined,
                          title: 'Case History & Sessions',
                          isDark: isDark,
                          onTap: () => context.push('/bookings'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 2: PAYMENT & SECURITY
                  _buildSectionTitle('PAYMENT & SECURITY', isDark),
                  const SizedBox(height: 8),
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
                        _buildMenuRow(
                          icon: Icons.credit_card_rounded,
                          title: 'Saved Payment Methods',
                          isDark: isDark,
                          onTap: () {},
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.receipt_long_outlined,
                          title: 'Transaction History',
                          isDark: isDark,
                          onTap: () => context.push('/transactions'),
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.translate_rounded,
                          title: 'Preferred Language',
                          isDark: isDark,
                          onTap: () => context.push('/choose-language'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 3: MANAGE / PREFERENCES
                  _buildSectionTitle('MANAGE', isDark),
                  const SizedBox(height: 8),
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
                        _buildMenuRow(
                          icon: Icons.palette_outlined,
                          title: 'Theme',
                          isDark: isDark,
                          onTap: () => showThemeSelectionModal(context),
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notification',
                          isDark: isDark,
                          onTap: () => context.push('/notifications'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 4: SUPPORT & COMPLIANCE
                  _buildSectionTitle('SUPPORT & COMPLIANCE', isDark),
                  const SizedBox(height: 8),
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
                        _buildMenuRow(
                          icon: Icons.headset_mic_outlined,
                          title: '24×7 Priority Concierge',
                          badge: 'Online',
                          badgeColor: const Color(0xFF10B981),
                          isDark: isDark,
                          onTap: () => context.push('/support'),
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.gavel_outlined,
                          title: 'Bar Council Ethics & Privilege',
                          trailingIcon: Icons.open_in_new_rounded,
                          isDark: isDark,
                          onTap: () {},
                        ),
                        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
                        _buildMenuRow(
                          icon: Icons.card_giftcard_rounded,
                          title: 'Refer Founder & Earn ₹500',
                          trailingIcon: Icons.arrow_forward_rounded,
                          isDark: isDark,
                          onTap: () => context.push('/referral'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().logout();
                      context.go('/get-started');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF3F1D1D) : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFEF4444)),
                          const SizedBox(width: 8),
                          Text(
                            'Log Out of Account',
                            style: AppTextStyles.bodyMedium(
                              color: const Color(0xFFEF4444),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Footer Notes
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline_rounded, size: 12, color: Color(0xFF94A3B8)),
                            const SizedBox(width: 4),
                            Text(
                              'Protected by Bar Council Ethics & AES-256 Vault',
                              style: AppTextStyles.caption(
                                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AvvocatAI Mobile v2.4.1 (Build 184)',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: AppTextStyles.caption(
        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
        fontWeight: FontWeight.bold,
      ).copyWith(letterSpacing: 0.5),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String title,
    String? badge,
    Color? badgeColor,
    IconData? trailingIcon,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(icon, size: 20, color: isDark ? AppColors.white : const Color(0xFF0F172A)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: (badgeColor ?? AppColors.primaryBlue).withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: AppTextStyles.caption(
                    color: badgeColor ?? AppColors.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              trailingIcon ?? Icons.chevron_right_rounded,
              size: 18,
              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }



  // Add Money Bottom Sheet Modal
  void _showAddMoneyBottomSheet(BuildContext context, bool isDark) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Money',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Icon(
                      Icons.close_rounded,
                      color: isDark ? AppColors.white : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Amount Input Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF242D45) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.bodyMedium(
                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter the Amount',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Quick Amount Preset Chips
              Row(
                children: ['₹200', '₹500', '₹1000', '₹1500'].map((amt) {
                  return GestureDetector(
                    onTap: () {
                      controller.text = amt.replaceAll('₹', '');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? const Color(0xFF2A364F) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        amt,
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Notice text
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.primaryBlue),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Wallet amount cannot be Transferred or Withdrawn',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Add Money Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final amt = double.tryParse(controller.text) ?? 0.0;
                    if (amt > 0) {
                      setState(() {
                        _walletBalance += amt;
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added ₹${amt.toInt()} to Wallet')),
                      );
                    }
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
                    'Add Money',
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
