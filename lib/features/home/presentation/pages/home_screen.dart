import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/home_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const AppLoader(message: 'Loading home details...');
            } else if (state is HomeErrorState) {
              return AppErrorView(
                message: state.message,
                onRetry: () => context.read<HomeCubit>().loadHomeData(),
              );
            } else if (state is HomeLoadedState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar (Location Selector & Notification Bell)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/choose-location'),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primaryBlue,
                                size: 22,
                              ),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        state.location.split(',').first,
                                        style: AppTextStyles.headingSmall(
                                          color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  if (isDark)
                                    Text(
                                      'Tamil Nadu',
                                      style: AppTextStyles.caption(
                                        color: AppColors.darkTextSecondary,
                                        fontSize: 11,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/notifications'),
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
                                        color: Colors.black.withAlpha(10),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Search Attorneys Bar & Floating AI Icon Button
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.push('/lawyers'),
                            child: Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkSurface : AppColors.white,
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: isDark ? AppColors.darkBorder : AppColors.primaryBlue.withAlpha(180),
                                  width: isDark ? 1 : 1.5,
                                ),
                                boxShadow: isDark
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: AppColors.primaryBlue.withAlpha(15),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        )
                                      ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Search attorneys or legal issues',
                                      style: AppTextStyles.bodyMedium(
                                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => context.push('/ai-assistant'),
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit_note_rounded,
                              color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Hero Banner ("Find Your Right Lawyer") with Man.png & Rectangle 2.png
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF001242).withAlpha(80),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Background Gradient Asset (Rectangle 2.png)
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/Png/Rectangle 2.png',
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF020B2C), Color(0xFF001B6B)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Man Image Standing on Left (Man.png)
                            Positioned(
                              left: -10,
                              bottom: 0,
                              top: 0,
                              width: 150,
                              child: Image.asset(
                                'assets/images/Png/Man.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                            // Text & Action Content on Right
                            Positioned(
                              left: 135,
                              top: 20,
                              right: 16,
                              bottom: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Find Your Right Lawyer',
                                        style: AppTextStyles.headingMedium(
                                          color: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.bodySmall(
                                          color: AppColors.white.withAlpha(220),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => context.push('/lawyers'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.white,
                                          foregroundColor: const Color(0xFF020B2C),
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          'Find a lawyer',
                                          style: AppTextStyles.bodySmall(
                                            color: const Color(0xFF020B2C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Slider Line Indicator
                                      Row(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Container(
                                            width: 8,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              color: AppColors.white.withAlpha(100),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Container(
                                            width: 8,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              color: AppColors.white.withAlpha(100),
                                              borderRadius: BorderRadius.circular(2),
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
                    ),
                    const SizedBox(height: 24),

                    // "Choose your issue" Header & Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose your issue',
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/lawyers'),
                          child: Text(
                            'See all',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // 2 x 3 Grid of Issues Cards
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        final issues = [
                          {'title': 'Family &\nDivorce', 'icon': Icons.family_restroom_rounded},
                          {'title': 'Criminal\nDefense', 'icon': Icons.balance_rounded},
                          {'title': 'Property &\nReal Estate', 'icon': Icons.home_work_rounded},
                          {'title': 'Corporate\nLaw', 'icon': Icons.business_center_rounded},
                          {'title': 'Employment\nLaw', 'icon': Icons.work_rounded},
                          {'title': 'Civil &\nTax Law', 'icon': Icons.gavel_rounded},
                        ];
                        final issue = issues[index];

                        return GestureDetector(
                          onTap: () => context.push('/lawyers'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              ),
                              boxShadow: isDark
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(6),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  issue['icon'] as IconData,
                                  color: isDark ? AppColors.white : const Color(0xFF1E293B),
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  issue['title'] as String,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.caption(
                                    color: isDark ? AppColors.white : const Color(0xFF1E293B),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // "Recent Messages" Row if in Dark Mode
                    if (isDark) ...[
                      Text(
                        'Recent Messages',
                        style: AppTextStyles.headingSmall(
                          color: AppColors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Image.asset(
                                  'assets/images/Png/Man.png',
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Container(
                              width: 52,
                              height: 52,
                              color: AppColors.darkCard,
                              child: const Icon(
                                Icons.person_rounded,
                                color: AppColors.darkTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],

                    // "Recommend for you" Header & Lawyer List
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommend for you',
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/lawyers'),
                          child: Text(
                            'See all',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Recommended Lawyer Cards matching reference design
                    _buildRecommendedLawyerCard(
                      context: context,
                      isDark: isDark,
                      id: 'lawyer_1',
                      name: 'Elena Marlowe',
                      specialization: 'Family Lawyer',
                      expYears: 12,
                      rating: 4.2,
                      reviews: 120,
                      location: 'Chennai • 2.5 KM',
                      imagePath: 'assets/images/Png/Man.png',
                    ),
                    const SizedBox(height: 12),
                    _buildRecommendedLawyerCard(
                      context: context,
                      isDark: isDark,
                      id: 'lawyer_2',
                      name: 'Berna',
                      specialization: 'Criminal Lawyer',
                      expYears: 8,
                      rating: 4.2,
                      reviews: 120,
                      location: 'Chennai • 2.5 KM',
                      imagePath: 'assets/images/Png/Man.png',
                    ),
                    const SizedBox(height: 12),
                    _buildRecommendedLawyerCard(
                      context: context,
                      isDark: isDark,
                      id: 'lawyer_3',
                      name: 'Elena Marlowe',
                      specialization: 'Family Lawyer',
                      expYears: 12,
                      rating: 4.2,
                      reviews: 120,
                      location: 'Chennai • 2.5 KM',
                      imagePath: 'assets/images/Png/Man.png',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildRecommendedLawyerCard({
    required BuildContext context,
    required bool isDark,
    required String id,
    required String name,
    required String specialization,
    required int expYears,
    required double rating,
    required int reviews,
    required String location,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () => context.push('/lawyer-profile', extra: id),
      child: Container(
        padding: const EdgeInsets.all(12),
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
                    color: Colors.black.withAlpha(8),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Lawyer Avatar Container
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (ctx, err, stack) {
                    return Container(
                      color: AppColors.primaryBlue.withAlpha(30),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 40,
                        color: AppColors.primaryBlue,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Lawyer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: AppTextStyles.headingSmall(
                            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Bookmark Action Button
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Icon(
                          Icons.bookmark_border_rounded,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$specialization • $expYears yrs exp',
                    style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.warningAmber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$rating',
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($reviews reviews)',
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        location,
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


