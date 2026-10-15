import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND OTP
  // ============================================================

  void _onSendOtp() {
    final mobile = _phoneController.text.trim();

    // Keep your existing fallback behavior.
    final phoneToPass = mobile.isEmpty ? '7339571836' : mobile;

    // Only trigger the API here.
    // Navigation happens after OtpSentState in BlocListener.
    context.read<AuthCubit>().sendOtp(phoneToPass);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 411.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // OTP SUCCESS
          if (state is OtpSentState) {
            context.push('/otp-verification', extra: state.mobileNumber);
          }
          // AUTH ERROR
          else if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              // ====================================================
              // 1. GAVEL IMAGE
              // width: 411; height: 730; top: -227px; left: -4px;
              // ====================================================
              Positioned(
                top: -227.0 * scale,
                left: -4.0 * scale,
                width: 411.0 * scale,
                height: 730.0 * scale,
                child: Image.asset(
                  'assets/images/Png/Login_Screen_image.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: size.height * 0.4,
                      color: const Color(0xFF170B0C),
                      child: const Center(
                        child: Icon(
                          Icons.gavel_rounded,
                          size: 80,
                          color: Colors.white24,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ====================================================
              // 2. GLASS LOGIN CONTAINER
              // width: 402; height: 640; top: 234px;
              // border-top-left-radius: 20px; border-top-right-radius: 20px;
              // background: #1B1B1B80; border: 1px solid #424242;
              // and shadow and blur; backdrop-filter: blur(30px);
              // ====================================================
              Positioned(
                top: 234.0 * scale,
                left: (size.width > 402.0 * scale)
                    ? (size.width - 402.0 * scale) / 2
                    : 0,
                right: (size.width > 402.0 * scale)
                    ? (size.width - 402.0 * scale) / 2
                    : 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 30,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x801B1B1B), // #1B1B1B80 (50% opacity)
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: const Color(0xFF424242), // 1px solid #424242
                            width: 1,
                          ),
                        ),
                        child: SafeArea(
                          top: false,
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: (640.0 * scale) - 48,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              // ==========================================
                              // 1. BRAND: AVVOCATAI
                              // ==========================================
                              Center(
                                child: Text(
                                  'AVVOCATAI',
                                  style: AppTextStyles.brandHeadline(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  ).copyWith(
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // ==========================================
                              // 2. SUBTITLE: Welcome back !
                              // ==========================================
                              const Center(
                                child: Text(
                                  'Welcome back !',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),

                              // ==========================================
                              // 3. MOBILE NUMBER LABEL
                              // ==========================================
                              const Text(
                                'Mobile Number',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // ==========================================
                              // 4. MOBILE NUMBER INPUT CONTAINER
                              // ==========================================
                              Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF232023),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF383336),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // COUNTRY CODE
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          const Text(
                                            '+91',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 18,
                                            color: Color(0xFF8E888A),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // VERTICAL DIVIDER
                                    Container(
                                      width: 1,
                                      height: 24,
                                      color: const Color(0xFF383336),
                                    ),

                                    const SizedBox(width: 10),

                                    // PHONE ICON
                                    const Icon(
                                      Icons.phone_outlined,
                                      size: 18,
                                      color: Color(0xFF8E888A),
                                    ),

                                    const SizedBox(width: 10),

                                    // PHONE TEXT FIELD
                                    Expanded(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          textSelectionTheme:
                                              const TextSelectionThemeData(
                                            selectionColor: Colors.transparent,
                                            selectionHandleColor:
                                                Colors.transparent,
                                            cursorColor: Colors.white,
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _phoneController,
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.done,
                                          enableInteractiveSelection: false,
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: const InputDecoration(
                                            hintText: 'Enter the mobile number',
                                            hintStyle: TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(vertical: 14),
                                            isDense: true,
                                            filled: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // ==========================================
                              // 5. GET OTP BUTTON
                              // ==========================================
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : _onSendOtp,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF0F172A,
                                        ),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF0F172A),
                                              ),
                                            )
                                          : const Text(
                                              'Get OTP',
                                              style: TextStyle(
                                                color: Color(0xFF0F172A),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // ==========================================
                              // 6. CREATE NEW ACCOUNT LINK
                              // ==========================================
                              Center(
                                child: GestureDetector(
                                  onTap: () => context.push('/get-started'),
                                  child: const Text(
                                    'Create new account',
                                    style: TextStyle(
                                      color: Color(0xFF2563EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // ==========================================
                              // 7. OR CONTINUE WITH
                              // ==========================================
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFF332D30),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'or continue with',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.62),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFF332D30),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              // ==========================================
                              // 8. SOCIAL LOGIN BUTTONS
                              // ==========================================
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialCard(
                                    child: _buildGoogleIcon(),
                                    isDark: true,
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialCard(
                                    child: _buildFacebookIcon(),
                                    isDark: true,
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialCard(
                                    child: _buildAppleIcon(true),
                                    isDark: true,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
}

  // ================================================================
  // SOCIAL LOGIN CARD
  // ================================================================

  Widget _buildSocialCard({required Widget child, required bool isDark}) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 1),
      ),
      child: Center(child: child),
    );
  }

  // ================================================================
  // GOOGLE ICON
  // ================================================================

  Widget _buildGoogleIcon() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: GoogleGLogoPainter()),
    );
  }

  // ================================================================
  // FACEBOOK ICON
  // ================================================================

  Widget _buildFacebookIcon() {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // APPLE ICON
  // ================================================================

  Widget _buildAppleIcon(bool isDark) {
    return const Icon(Icons.apple_rounded, size: 27, color: Colors.white);
  }
}

// ====================================================================
// GOOGLE G LOGO PAINTER
// ====================================================================

class GoogleGLogoPainter extends CustomPainter {
  const GoogleGLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final double cx = w / 2;
    final double cy = h / 2;

    final double r = w / 2 - 2;
    final double strokeWidth = w * 0.22;

    final Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);

    Paint arcPaint(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Google arc segments
    canvas.drawArc(rect, -2.8, 1.4, false, arcPaint(const Color(0xFFEA4335)));
    canvas.drawArc(rect, -4.0, 1.2, false, arcPaint(const Color(0xFFFBBC05)));
    canvas.drawArc(rect, 0.7, 1.5, false, arcPaint(const Color(0xFF34A853)));
    canvas.drawArc(rect, -0.2, 0.9, false, arcPaint(const Color(0xFF4285F4)));

    // Google blue bar
    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final Rect barRect = Rect.fromLTRB(
      cx - 1,
      cy - strokeWidth / 2,
      cx + r + 1,
      cy + strokeWidth / 2,
    );

    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
