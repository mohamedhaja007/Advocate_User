import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_header.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: 'Voice Assistant',
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Text(
                _isListening
                    ? 'Listening... Speak your legal query'
                    : 'Tap the microphone to start speaking',
                textAlign: TextAlign.center,
                style: AppTextStyles.headingSmall(
                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                ),
              ),

              // Animated Pulsing Mic Wave Graphic
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isListening = !_isListening;
                  });
                },
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: _isListening
                        ? AppColors.primaryBlue
                        : AppColors.purpleAccent.withAlpha(40),
                    shape: BoxShape.circle,
                    boxShadow: _isListening
                        ? [
                            BoxShadow(
                              color: AppColors.primaryBlue.withAlpha(100),
                              blurRadius: 30,
                              spreadRadius: 10,
                            )
                          ]
                        : [],
                  ),
                  child: Icon(
                    _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                    size: 64,
                    color: _isListening ? AppColors.white : AppColors.purpleAccent,
                  ),
                ),
              ),

              Column(
                children: [
                  Text(
                    'Supported in 6 Languages',
                    style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
