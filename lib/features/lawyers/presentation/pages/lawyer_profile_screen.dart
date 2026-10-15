import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/lawyer_cubit.dart';

class LawyerProfileScreen extends StatefulWidget {
  final String lawyerId;

  const LawyerProfileScreen({
    super.key,
    required this.lawyerId,
  });

  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  int _selectedBookingTypeIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<LawyerCubit>().loadLawyerDetails(widget.lawyerId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: BlocBuilder<LawyerCubit, LawyerState>(
          builder: (context, state) {
            if (state is LawyerLoading) {
              return const AppLoader(message: 'Loading advocate profile...');
            } else if (state is LawyerError) {
              return AppErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<LawyerCubit>().loadLawyerDetails(widget.lawyerId),
              );
            } else if (state is LawyerDetailsLoaded) {
              final lawyer = state.lawyer;

              return Column(
                children: [
                  // Top Navigation Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
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
                              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: _isFavorite
                                  ? Colors.redAccent
                                  : (isDark ? AppColors.white : AppColors.lightTextPrimary),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Details Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Large Avatar
                          AppAvatar(
                            imageUrl: lawyer.imageUrl,
                            name: lawyer.name,
                            radius: 46,
                          ),
                          const SizedBox(height: 12),

                          // Name & Verified Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                lawyer.name,
                                style: AppTextStyles.headingMedium(
                                  color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                                  fontSize: 20,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      size: 11,
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
                          const SizedBox(height: 4),

                          // Designation & Subtitle
                          Text(
                            'Advocate on Record • High Court / ${lawyer.location}',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySmall(
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primaryBlue),
                              const SizedBox(width: 4),
                              Text(
                                lawyer.location,
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '• 🌐 Tamil, English',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // 3 Stats Box Row
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatItem(
                                  title: '⭐ ${lawyer.rating}',
                                  subtitle: '${lawyer.reviewsCount} reviews',
                                  isDark: isDark,
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                ),
                                _buildStatItem(
                                  title: '${lawyer.experienceYears} years',
                                  subtitle: 'Experience',
                                  isDark: isDark,
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                ),
                                _buildStatItem(
                                  title: '160+',
                                  subtitle: 'Cases',
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // STANDARD WEEKLY HOURS Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
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
                                        const Icon(Icons.access_time_rounded, size: 16, color: AppColors.primaryBlue),
                                        const SizedBox(width: 6),
                                        Text(
                                          'STANDARD WEEKLY HOURS',
                                          style: AppTextStyles.caption(
                                            color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFF242D45) : const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'IST (UTC+5:30)',
                                        style: AppTextStyles.caption(
                                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                _buildHoursRow('Monday - Friday', '09:00 AM - 08:30 PM', isDark),
                                const SizedBox(height: 6),
                                _buildHoursRow('Saturday', '10:00 AM - 02:00 PM', isDark),
                                const SizedBox(height: 6),
                                _buildHoursRow('Sunday', 'Emergency Video Only', isDark, isHighlight: true),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Select Booking Type Section
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Booking Type',
                              style: AppTextStyles.headingSmall(
                                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          _buildBookingTypeOption(
                            index: 0,
                            icon: Icons.videocam_outlined,
                            title: 'Video Consultation',
                            description: 'High-definition encrypted call via Nyaya Secure Meet',
                            price: '₹499 / 15 mins',
                            isDark: isDark,
                          ),
                          const SizedBox(height: 10),
                          _buildBookingTypeOption(
                            index: 1,
                            icon: Icons.phone_outlined,
                            title: 'Phone Consultation',
                            description: 'Direct private audio-call to your registered mobile number',
                            price: '₹299 / 30 mins',
                            isDark: isDark,
                          ),
                          const SizedBox(height: 10),
                          _buildBookingTypeOption(
                            index: 2,
                            icon: Icons.home_outlined,
                            title: 'Doorstep Consultation',
                            description: 'Advocate Chambers, Supreme Court Bar Compound',
                            price: '₹1,499',
                            isDark: isDark,
                          ),
                          const SizedBox(height: 20),

                          // About Section & License Tag
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lawyer.about.isNotEmpty
                                      ? lawyer.about
                                      : 'Lorem ipsum is simply dummy text of the printing and typesetting industry simply dummy text of the printing and typesetting industry.',
                                  style: AppTextStyles.bodySmall(
                                    color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Bar License #${lawyer.barCouncilId}',
                                    style: AppTextStyles.caption(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: lawyer.specializations.map((spec) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFF242D45) : const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        spec,
                                        style: AppTextStyles.caption(
                                          color: isDark ? AppColors.white : const Color(0xFF334155),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Button
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
                          context.push('/slot-selection', extra: lawyer);
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
                          'Book Slot Now',
                          style: AppTextStyles.bodyMedium(
                            color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.bodyMedium(
            color: isDark ? AppColors.white : const Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: AppTextStyles.caption(
            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildHoursRow(String days, String hours, bool isDark, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          days,
          style: AppTextStyles.caption(
            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
          ),
        ),
        Text(
          hours,
          style: AppTextStyles.caption(
            color: isHighlight
                ? AppColors.primaryBlue
                : (isDark ? AppColors.white : const Color(0xFF0F172A)),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingTypeOption({
    required int index,
    required IconData icon,
    required String title,
    required String description,
    required String price,
    required bool isDark,
  }) {
    final isSelected = _selectedBookingTypeIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBookingTypeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF242D45) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isDark ? AppColors.white : const Color(0xFF0F172A), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.caption(
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : (isDark ? const Color(0xFF64748B) : const Color(0xFFCBD5E1)),
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
