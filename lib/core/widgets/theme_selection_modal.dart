import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/theme_cubit.dart';

void showThemeSelectionModal(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final currentTheme = context.read<ThemeCubit>().state;
  ThemeMode selectedMode = currentTheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (modalContext, setModalState) {
          return Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF221F20) : const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Row with Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
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
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Top Divider line below title
                Divider(
                  color: isDark ? const Color(0xFF332D30) : const Color(0xFFE2E8F0),
                  thickness: 1,
                  height: 1,
                ),

                // Option 1: Dark
                _buildModalOptionRow(
                  label: 'Dark',
                  mode: ThemeMode.dark,
                  selectedMode: selectedMode,
                  isDark: isDark,
                  onTap: () {
                    setModalState(() => selectedMode = ThemeMode.dark);
                  },
                ),

                Divider(
                  color: isDark ? const Color(0xFF332D30) : const Color(0xFFE2E8F0),
                  thickness: 1,
                  height: 1,
                ),

                // Option 2: Light
                _buildModalOptionRow(
                  label: 'Light',
                  mode: ThemeMode.light,
                  selectedMode: selectedMode,
                  isDark: isDark,
                  onTap: () {
                    setModalState(() => selectedMode = ThemeMode.light);
                  },
                ),

                Divider(
                  color: isDark ? const Color(0xFF332D30) : const Color(0xFFE2E8F0),
                  thickness: 1,
                  height: 1,
                ),

                // Option 3: Device Theme
                _buildModalOptionRow(
                  label: 'Device Theme',
                  mode: ThemeMode.system,
                  selectedMode: selectedMode,
                  isDark: isDark,
                  onTap: () {
                    setModalState(() => selectedMode = ThemeMode.system);
                  },
                ),

                Divider(
                  color: isDark ? const Color(0xFF332D30) : const Color(0xFFE2E8F0),
                  thickness: 1,
                  height: 1,
                ),

                const SizedBox(height: 24),

                // Apply Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ThemeCubit>().setTheme(selectedMode);
                      Navigator.pop(ctx);
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
                      'Apply',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildModalOptionRow({
  required String label,
  required ThemeMode mode,
  required ThemeMode selectedMode,
  required bool isDark,
  required VoidCallback onTap,
}) {
  final isSelected = selectedMode == mode;

  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: isDark ? AppColors.white : const Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF2563EB)
                    : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    ),
  );
}
