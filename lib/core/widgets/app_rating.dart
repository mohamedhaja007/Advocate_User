import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppRating extends StatelessWidget {
  final double rating;
  final int? reviewsCount;
  final double iconSize;

  const AppRating({
    super.key,
    required this.rating,
    this.reviewsCount,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.warningAmber,
          size: iconSize,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.bodySmall(
            color: isDark ? AppColors.white : AppColors.lightTextPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (reviewsCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewsCount reviews)',
            style: AppTextStyles.caption(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextMuted,
            ),
          ),
        ],
      ],
    );
  }
}

