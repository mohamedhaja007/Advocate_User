import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppButtonType { primary, outlined, text, icon }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double? width;
  final bool useGradient;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height = 52,
    this.width,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content = isLoading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == AppButtonType.outlined
                    ? AppColors.primaryBlue
                    : AppColors.white,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: _getTextColor(isDark)),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: AppTextStyles.buttonText(
                  color: _getTextColor(isDark),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

    switch (type) {
      case AppButtonType.primary:
        final buttonColor = backgroundColor ?? AppColors.primaryBlue;
        final isGradient = useGradient && backgroundColor == null;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isGradient
                ? const LinearGradient(
                    colors: [
                      AppColors.brandGradientStart,
                      AppColors.brandGradientEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isGradient ? null : buttonColor,
            boxShadow: onPressed == null
                ? []
                : [
                    BoxShadow(
                      color: (isGradient
                              ? AppColors.primaryBlue
                              : buttonColor)
                          .withAlpha(60),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: textColor ?? AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: content,
          ),
        );

      case AppButtonType.outlined:
        final borderColor = backgroundColor ?? AppColors.primaryBlue;
        return SizedBox(
          width: width ?? double.infinity,
          height: height,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: textColor ?? AppColors.primaryBlue,
              side: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: content,
          ),
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: content,
        );

      case AppButtonType.icon:
        return SizedBox(
          width: width ?? 48,
          height: height,
          child: IconButton(
            onPressed: isLoading ? null : onPressed,
            icon: Icon(icon, color: _getTextColor(isDark)),
          ),
        );
    }
  }

  Color _getTextColor(bool isDark) {
    if (textColor != null) return textColor!;
    switch (type) {
      case AppButtonType.primary:
        return AppColors.white;
      case AppButtonType.outlined:
        return AppColors.primaryBlue;
      case AppButtonType.text:
      case AppButtonType.icon:
        return isDark ? AppColors.white : AppColors.lightTextPrimary;
    }
  }
}

