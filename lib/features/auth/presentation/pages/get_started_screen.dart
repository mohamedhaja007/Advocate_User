import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_styles.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  // Background color of the screen (matches the dark statue image).
  static const Color _bg = Color(0xFF0B0B0C);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _bg,
        body: Stack(
          children: [
            // ====================================================
            // 1. STATUE IMAGE (sized by width so it is never cropped)
            // ====================================================
            Positioned(
              // Positive = moves statue DOWN, negative = moves it UP.
              top: size.height * 0.03,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Png/Law_Statue.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                errorBuilder: (ctx, err, stack) => SizedBox(
                  height: size.height * 0.5,
                  child: const Center(
                    child: Icon(
                      Icons.balance_rounded,
                      size: 100,
                      color: Colors.white24,
                    ),
                  ),
                ),
              ),
            ),

            // ====================================================
            // 2. FADE GRADIENT (statue fades into the background)
            // ====================================================
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.50, 0.66, 0.76, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      _bg.withOpacity(0.55),
                      _bg.withOpacity(0.95),
                      _bg,
                    ],
                  ),
                ),
              ),
            ),

            // ====================================================
            // 3. BOTTOM TEXT + BUTTON
            // ====================================================
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      children: [
                        const Text(
                          'Privileged Legal Counsel & AI\nJurisprudence',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Instant statutory insights, verified Supreme Court & High Court advocates, and escrow-backed legal retainers at your fingertips.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall(
                            color: const Color(0xFF94A3B8),
                          ).copyWith(height: 1.5, fontSize: 12.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Full-width bottom button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.go('/home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Get Start',
                          style: AppTextStyles.bodyMedium(
                            color: const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
