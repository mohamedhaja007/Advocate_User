import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../cubit/lawyer_cubit.dart';
import '../widgets/lawyer_card_widget.dart';

class LawyersScreen extends StatefulWidget {
  const LawyersScreen({super.key});

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Property',
    'Family',
    'Consumer',
    'Criminal',
    'Corporate',
    'Employment',
  ];

  @override
  void initState() {
    super.initState();
    context.read<LawyerCubit>().loadLawyers();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Location Header Bar matching design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lawyers',
                        style: AppTextStyles.headingMedium(
                          color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
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

            // Search Bar Component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              child: AppSearchBar(
                hintText: 'Search attorneys or legal issues',
                onChanged: (val) {
                  context.read<LawyerCubit>().loadLawyers(query: val);
                },
                onFilterTap: () {},
              ),
            ),
            const SizedBox(height: 8),

            // Horizontal Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return AppChip(
                    label: cat,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat;
                      });
                      context.read<LawyerCubit>().loadLawyers(
                            category: cat == 'All' ? null : cat,
                          );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Lawyers List View
            Expanded(
              child: BlocBuilder<LawyerCubit, LawyerState>(
                builder: (context, state) {
                  if (state is LawyerLoading) {
                    return const AppLoader(message: 'Searching nearby lawyers...');
                  } else if (state is LawyerError) {
                    return AppErrorView(
                      message: state.message,
                      onRetry: () => context.read<LawyerCubit>().loadLawyers(),
                    );
                  } else if (state is LawyersLoaded) {
                    if (state.lawyers.isEmpty) {
                      return const AppEmptyView(
                        title: 'No Lawyers Found',
                        message: 'Try clearing filters or changing search query.',
                        icon: Icons.search_off_rounded,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: state.lawyers.length,
                      itemBuilder: (context, index) {
                        final lawyer = state.lawyers[index];
                        return LawyerCardWidget(
                          lawyer: lawyer,
                          onTap: () =>
                              context.push('/lawyer-profile', extra: lawyer.id),
                          onBookVisit: () =>
                              context.push('/slot-selection', extra: lawyer),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
