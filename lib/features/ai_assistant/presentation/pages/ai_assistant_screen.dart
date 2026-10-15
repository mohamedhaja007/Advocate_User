import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubit/ai_assistant_cubit.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;
  bool _isBookmarked = false;
  int? _ratingState; // 1 for thumbs up, -1 for thumbs down

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onTextChanged);
    context.read<AiAssistantCubit>().loadHistory();
  }

  void _onTextChanged() {
    final hasText = _inputController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _inputController.removeListener(_onTextChanged);
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSend([String? presetText]) {
    final text = presetText ?? _inputController.text.trim();
    if (text.isNotEmpty) {
      context.read<AiAssistantCubit>().sendMessage(text);
      _inputController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Bar matching reference image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withAlpha(8),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                  Text(
                    'Ai Chat',
                    style: AppTextStyles.headingMedium(
                      color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AiAssistantCubit>().loadHistory();
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withAlpha(8),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Icon(
                        Icons.history_rounded,
                        color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Body: Welcome Empty State OR Conversation Stream
            Expanded(
              child: BlocConsumer<AiAssistantCubit, AiAssistantState>(
                listener: (context, state) {
                  if (state is AiAssistantLoaded) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  if (state is AiAssistantLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? AppColors.white : AppColors.primaryBlue,
                        ),
                      ),
                    );
                  } else if (state is AiAssistantLoaded) {
                    if (state.messages.isEmpty) {
                      return _buildWelcomeState(isDark);
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      itemCount: state.messages.length + (state.isThinking ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.messages.length && state.isThinking) {
                          return _buildThinkingIndicator(isDark);
                        }

                        final msg = state.messages[index];
                        final isUser = msg.sender == 'user';

                        if (isUser) {
                          return _buildUserBubble(msg.message);
                        } else {
                          return _buildAiResponseCard(msg.message, isDark);
                        }
                      },
                    );
                  }
                  return _buildWelcomeState(isDark);
                },
              ),
            ),

            // Bottom Input Bar Container
            _buildBottomInputBar(isDark),
          ],
        ),
      ),
    );
  }

  // Welcome / Empty State View matching reference image
  Widget _buildWelcomeState(bool isDark) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi Alex !',
              style: AppTextStyles.headingLarge(
                color: isDark ? AppColors.white : AppColors.lightTextPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'How can I help you today?',
              style: AppTextStyles.headingMedium(
                color: isDark ? AppColors.white.withAlpha(220) : AppColors.lightTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Get quick guidance on Indian legal matters, understand your rights, or explore your legal options.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
              ).copyWith(height: 1.4),
            ),
            const SizedBox(height: 28),

            // Preset prompt pills
            Wrap(
              spacing: 10,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildPromptChip('Help me understand my legal rights', isDark),
                _buildPromptChip('I need a family lawyer', isDark),
                _buildPromptChip('I have a property dispute', isDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptChip(String prompt, bool isDark) {
    return GestureDetector(
      onTap: () => _onSend(prompt),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2638) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? const Color(0xFF2E3B54) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          prompt,
          style: AppTextStyles.bodySmall(
            color: isDark ? AppColors.white : const Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // User Message Bubble matching dark navy rounded rectangle in design
  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0F213A),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium(
            color: AppColors.white,
            fontSize: 14,
          ).copyWith(height: 1.4),
        ),
      ),
    );
  }

  // AI Response Card matching reference screenshot
  Widget _buildAiResponseCard(String text, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Title header bar
        Row(
          children: [
            Text(
              'Nyaya Legal Intelligence',
              style: AppTextStyles.headingSmall(
                color: isDark ? AppColors.white : const Color(0xFF0F172A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Sec 108 TPA',
                style: AppTextStyles.caption(
                  color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF4338CA),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Main AI Response Card Container
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Answer Text
              Text(
                text.isNotEmpty
                    ? text
                    : 'Under prevailing Indian tenancy jurisprudence and Section 108 of the Transfer of Property Act, standard wear and tear is the owner\'s statutory maintenance duty. Deductions require proven actual damage and certified GST bills.',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155),
                  fontSize: 14,
                ).copyWith(height: 1.5),
              ),
              const SizedBox(height: 16),

              // 3 Highlighted Key Sub-Cards
              _buildSubCard(
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFFD97706),
                title: 'Normal Wear & Tear Excluded',
                description:
                    'Faded paint from routine usage cannot be charged back to the tenant.',
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              _buildSubCard(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFD97706),
                title: 'Statutory Right to Invoices',
                description:
                    'The lessor must produce legitimate, itemized work receipts to justify withholding.',
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              _buildSubCard(
                icon: Icons.hourglass_bottom_rounded,
                iconColor: const Color(0xFFD97706),
                title: '30-Day Mandatory Settlement',
                description:
                    'Model Tenancy norms prescribe full refund upon vacant possession, plus interest if delayed.',
                isDark: isDark,
              ),
              const SizedBox(height: 20),

              // Recommended Next Steps
              Text(
                'RECOMMENDED NEXT STEPS',
                style: AppTextStyles.caption(
                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                ).copyWith(letterSpacing: 0.5),
              ),
              const SizedBox(height: 10),

              // CTA Button: Talk to Counsel
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/lawyers');
                },
                icon: const Icon(Icons.phone_in_talk_outlined, size: 16),
                label: const Text('Talk to Counsel (₹499)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                  foregroundColor: isDark ? const Color(0xFF0F172A) : AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: AppTextStyles.bodySmall(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Divider line
              Divider(
                color: isDark ? const Color(0xFF26304A) : const Color(0xFFF1F5F9),
                height: 1,
              ),
              const SizedBox(height: 12),

              // Action Toolbar (Copy, Bookmark, Share, Thumbs Up/Down)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied legal advice to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      size: 18,
                    ),
                    color: _isBookmarked
                        ? AppColors.primaryBlue
                        : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _isBookmarked = !_isBookmarked;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isBookmarked ? 'Bookmarked legal advice' : 'Removed from bookmarks',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, size: 18),
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sharing legal advice link...'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      _ratingState == 1 ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                      size: 18,
                    ),
                    color: _ratingState == 1
                        ? AppColors.primaryBlue
                        : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _ratingState = _ratingState == 1 ? 0 : 1;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      _ratingState == -1 ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                      size: 18,
                    ),
                    color: _ratingState == -1
                        ? Colors.redAccent
                        : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _ratingState = _ratingState == -1 ? 0 : -1;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for AI Sub-Cards
  Widget _buildSubCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242D45) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.caption(
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ).copyWith(height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Thinking indicator while AI generates response
  Widget _buildThinkingIndicator(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? AppColors.white : AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  context.tr('ai_thinking'),
                  style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Input Bar Component matching the reference designs
  Widget _buildBottomInputBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      ),
      child: Row(
        children: [
          // Text input rounded pill
          Expanded(
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withAlpha(6),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  // Attachment + icon
                  GestureDetector(
                    onTap: () => context.push('/document-upload'),
                    child: Icon(
                      Icons.add_rounded,
                      color: isDark ? AppColors.white : const Color(0xFF64748B),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Text input field
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      onSubmitted: (_) => _onSend(),
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ask any Indian legal issue',
                        hintStyle: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),

                  // Scan / Fullscreen icon
                  GestureDetector(
                    onTap: () => context.push('/notice-scanner'),
                    child: Icon(
                      Icons.crop_free_rounded,
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Send OR Microphone Circular Button
          GestureDetector(
            onTap: () {
              if (_hasText) {
                _onSend();
              } else {
                context.push('/voice-assistant');
              }
            },
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isDark ? AppColors.white : const Color(0xFF0F213A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                _hasText ? Icons.navigation_rounded : Icons.mic_none_rounded,
                color: isDark ? const Color(0xFF0F213A) : AppColors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
