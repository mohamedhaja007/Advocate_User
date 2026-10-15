import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppDivider extends StatelessWidget {
  final double height;
  final double thickness;

  const AppDivider({
    super.key,
    this.height = 16,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Divider(
      height: height,
      thickness: thickness,
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );
  }
}
