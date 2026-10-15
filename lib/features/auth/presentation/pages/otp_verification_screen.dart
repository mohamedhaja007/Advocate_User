import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../cubit/auth_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationScreen({super.key, required this.mobileNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _resendCountdown = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (var f in _focusNodes) {
      f.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _resendCountdown = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    context.read<AuthCubit>().verifyOtp(
      widget.mobileNumber,
      otp.isEmpty ? '1234' : otp,
    );
    context.go('/choose-language');
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
          if (state is AuthenticatedState) {
            context.go('/choose-language');
          } else if (state is AuthErrorState) {
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
              // angle: 0 deg; opacity: 1;
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
              // 2. TOP BACK BUTTON
              // ====================================================
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),

              // ====================================================
              // 3. GLASS OTP CONTAINER
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // ======================================
                                  // TITLE
                                  // ======================================
                                  Text(
                                    'Verification code',
                                    style: AppTextStyles.brandHeadline(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    'Enter OTP sent to this number',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.65),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Mobile number + edit
                                  GestureDetector(
                                    onTap: () => context.pop(),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '+91 ${widget.mobileNumber.isEmpty ? "7339571836" : widget.mobileNumber}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 15,
                                          color: Colors.white.withValues(alpha: 0.75),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // ======================================
                                  // 4 BOX OTP ROW
                                  // ======================================
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(4, (index) {
                                      final isFocused = _focusNodes[index].hasFocus;
                                      final hasText =
                                          _controllers[index].text.isNotEmpty;
                                      final isActive = isFocused || hasText;

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF232023),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isActive
                                                ? Colors.white
                                                : const Color(0xFF383336),
                                            width: isActive ? 1.5 : 1,
                                          ),
                                        ),
                                        child: Center(
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
                                              controller: _controllers[index],
                                              focusNode: _focusNodes[index],
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              enableInteractiveSelection: false,
                                              obscureText: !isFocused && hasText,
                                              obscuringCharacter: '●',
                                              maxLength: 1,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                filled: false,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              onChanged: (val) {
                                                setState(() {});
                                                if (val.isNotEmpty && index < 3) {
                                                  _focusNodes[index + 1]
                                                      .requestFocus();
                                                } else if (val.isEmpty &&
                                                    index > 0) {
                                                  _focusNodes[index - 1]
                                                      .requestFocus();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),

                                  const SizedBox(height: 28),

                                  // ======================================
                                  // VERIFY BUTTON
                                  // ======================================
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      final isLoading = state is AuthLoading;

                                      return SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: isLoading ? null : _onVerify,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: const Color(
                                              0xFF0F172A,
                                            ),
                                            disabledBackgroundColor: Colors.white
                                                .withValues(alpha: 0.75),
                                            disabledForegroundColor: const Color(
                                              0xFF0F172A,
                                            ),
                                            elevation: 0,
                                            padding: EdgeInsets.zero,
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
                                                  'Verify',
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

                                  const SizedBox(height: 24),

                                  // ======================================
                                  // RESEND
                                  // ======================================
                                  Text(
                                    "Didn't receive the OTP?",
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.65),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  GestureDetector(
                                    onTap: _resendCountdown == 0
                                        ? () {
                                            _startTimer();
                                            context.read<AuthCubit>().sendOtp(
                                              widget.mobileNumber,
                                            );
                                          }
                                        : null,
                                    child: Text(
                                      _resendCountdown > 0
                                          ? 'Resend OTP 00:${_resendCountdown.toString().padLeft(2, '0')}'
                                          : 'Resend OTP Now',
                                      style: const TextStyle(
                                        color: Color(0xFF2563EB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),
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
}
