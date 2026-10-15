import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/localization/localization_config.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = context.read<LocaleCubit>().state.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF090C15) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Bar matching reference
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
                        color: isDark ? const Color(0xFF1E2638) : AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? const Color(0xFF2E3B54) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    'Choose Language',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E2638) : AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? const Color(0xFF2E3B54) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.translate_rounded,
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title & Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferred Language',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Statutory summaries, advocate briefs, and high-court citations localized to your tongue.',
                    style: AppTextStyles.caption(
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ).copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2-Column Languages Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.3,
                ),
                itemCount: LocalizationConfig.languages.length,
                itemBuilder: (context, index) {
                  final item = LocalizationConfig.languages[index];
                  final isSelected = _selectedCode == item.code;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCode = item.code;
                      });
                      context.read<LocaleCubit>().setLocale(item.code);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9))
                            : (isDark ? const Color(0xFF131826) : AppColors.white),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? AppColors.white : const Color(0xFF0F172A))
                              : (isDark ? const Color(0xFF263048) : const Color(0xFFE2E8F0)),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Radio Circle Indicator
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? (isDark ? AppColors.white : const Color(0xFF0F172A))
                                    : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                                width: isSelected ? 5 : 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: AppTextStyles.bodyMedium(
                                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.nativeName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption(
                                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Continue CTA
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => context.go('/allow-location'),
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
}
