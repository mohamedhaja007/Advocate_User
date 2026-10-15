import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppStatusType { success, pending, cancelled, info }

class AppStatusBadge extends StatelessWidget {
  final String statusText;
  final AppStatusType type;

  const AppStatusBadge({
    super.key,
    required this.statusText,
    this.type = AppStatusType.info,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case AppStatusType.success:
        bg = AppColors.successGreen.withAlpha(25);
        fg = AppColors.successGreen;
        break;
      case AppStatusType.pending:
        bg = const Color(0xFFF59E0B).withAlpha(25);
        fg = const Color(0xFFD97706);
        break;
      case AppStatusType.cancelled:
        bg = AppColors.alertRed.withAlpha(25);
        fg = AppColors.alertRed;
        break;
      case AppStatusType.info:
        bg = AppColors.primaryBlue.withAlpha(25);
        fg = AppColors.primaryBlue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: AppTextStyles.caption(
          color: fg,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
