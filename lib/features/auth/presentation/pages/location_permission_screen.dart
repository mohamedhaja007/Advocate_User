import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF090C15) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 24,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Custom Header Bar with Back and Skip >
                      Row(
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
                          GestureDetector(
                            onTap: () => context.go('/get-started'),
                            child: Text(
                              'Skip >',
                              style: AppTextStyles.caption(
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      const SizedBox(height: 16),

                      // Glowing Radar Center Visual (Responsive sizing)
                      SizedBox(
                        width: 240,
                        height: 240,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: LocationRadarPainter(
                                progress: _animationController.value,
                                isDark: isDark,
                              ),
                              child: Center(
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryBlue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryBlue.withAlpha(150),
                                        blurRadius: 28,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.location_on_rounded,
                                    size: 36,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 16),

                      // Text Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              'Allow your location',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headingMedium(
                                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Allow location access to find lawyers near you.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption(
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                              ).copyWith(height: 1.4, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Bottom CTA Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => context.go('/get-started'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                            foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Enable Location',
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? const Color(0xFF0F172A) : AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LocationRadarPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  LocationRadarPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Concentric Radar Rings
    final ringColor = isDark
        ? AppColors.primaryBlue.withAlpha(50)
        : AppColors.primaryBlue.withAlpha(40);

    for (int i = 1; i <= 4; i++) {
      final radius = (size.width / 2) * (i / 4.0);
      final paint = Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(center, radius, paint);
    }

    // Outer Animated Pulsing Glow Ring
    final pulseRadius = (size.width / 2) * progress;
    final pulsePaint = Paint()
      ..color = AppColors.primaryBlue.withAlpha((120 * (1 - progress)).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, pulseRadius, pulsePaint);

    // 6 Surrounding Pins on Outer Rings
    final pinAngles = [0.2, 0.8, 1.4, 2.2, 3.0, 4.2, 5.0];
    final pinDistances = [0.45, 0.7, 0.85, 0.55, 0.8, 0.65, 0.9];

    for (int i = 0; i < pinAngles.length; i++) {
      final angle = pinAngles[i] + (progress * 0.2);
      final dist = (size.width / 2) * pinDistances[i];
      final pinOffset = Offset(
        center.dx + dist * math.cos(angle),
        center.dy + dist * math.sin(angle),
      );

      // Pin Glow
      final glowPaint = Paint()
        ..color = AppColors.primaryBlue.withAlpha(80)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(pinOffset, 8, glowPaint);

      // Pin Dot
      final dotPaint = Paint()..color = AppColors.primaryBlue;
      canvas.drawCircle(pinOffset, 5, dotPaint);

      final innerDot = Paint()..color = Colors.white;
      canvas.drawCircle(pinOffset, 2, innerDot);
    }
  }

  @override
  bool shouldRepaint(covariant LocationRadarPainter oldDelegate) => true;
}
