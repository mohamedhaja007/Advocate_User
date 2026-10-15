import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;
  final bool isRead;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.isRead = true,
  });
}

class AdvocateChatScreen extends StatefulWidget {
  final String advocateName;
  final String advocateImage;

  const AdvocateChatScreen({
    super.key,
    this.advocateName = 'Elena Marlowe',
    this.advocateImage = 'assets/images/Png/Man.png',
  });

  @override
  State<AdvocateChatScreen> createState() => _AdvocateChatScreenState();
}

class _AdvocateChatScreenState extends State<AdvocateChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello Elena',
      isUser: true,
      time: '11:12 am',
      isRead: true,
    ),
    ChatMessage(
      text: 'Hello How can i help you',
      isUser: false,
      time: '11:13 am',
    ),
    ChatMessage(
      text: 'I have a dispute regarding my family property',
      isUser: true,
      time: '11:13 am',
      isRead: true,
    ),
    ChatMessage(
      text: 'Please explain the issue',
      isUser: false,
      time: '11:13 am',
    ),
    ChatMessage(
      text: 'The property is jointly owned by me and my brother. He wants to sell it without my approval.',
      isUser: true,
      time: '11:13 am',
      isRead: true,
    ),
    ChatMessage(
      text: 'Do you have the property documents showing both of your names?',
      isUser: false,
      time: '11:13 am',
    ),
    ChatMessage(
      text: 'Yes, I have the sale deed.',
      isUser: true,
      time: '11:13 am',
      isRead: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final timeStr = '${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'pm' : 'am'}';

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          time: timeStr,
          isRead: false,
        ),
      );
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F0D0E) : const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // 1. TOP HEADER BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF262223) : const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: isDark ? AppColors.white : const Color(0xFF0F172A),
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Profile Pill Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF262223) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? const Color(0xFF3D3739) : const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              widget.advocateImage,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                width: 32,
                                height: 32,
                                color: AppColors.primaryBlue,
                                child: const Icon(Icons.person, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.advocateName,
                            style: AppTextStyles.bodyMedium(
                              color: isDark ? AppColors.white : const Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // 3-Dots Options Menu
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF262223) : const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: isDark ? AppColors.white : const Color(0xFF0F172A),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. MESSAGES LIST
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      // Today Date Pill Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF262223) : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Today',
                          style: AppTextStyles.caption(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Chat Bubbles
                      ..._messages.map((msg) => _buildMessageBubble(msg, isDark)),
                    ],
                  ),
                ),
              ),

              // 3. BOTTOM INPUT BAR
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Pill Textfield Input Bar
                    Expanded(
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF262223) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: isDark ? const Color(0xFF3D3739) : const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Attachment Icon
                            Icon(
                              Icons.attach_file_rounded,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                              size: 22,
                            ),
                            const SizedBox(width: 10),

                            // TextField Input
                            Expanded(
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: const TextSelectionThemeData(
                                    selectionColor: Colors.transparent,
                                    selectionHandleColor: Colors.transparent,
                                  ),
                                ),
                                child: TextField(
                                  controller: _messageController,
                                  cursorColor: isDark ? AppColors.white : const Color(0xFF0F172A),
                                  style: AppTextStyles.bodyMedium(
                                    color: isDark ? AppColors.white : const Color(0xFF0F172A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Message',
                                    hintStyle: AppTextStyles.caption(
                                      color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  onSubmitted: (_) => _sendMessage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Camera Icon
                            GestureDetector(
                              onTap: _sendMessage,
                              child: Icon(
                                _messageController.text.isNotEmpty
                                    ? Icons.send_rounded
                                    : Icons.camera_alt_outlined,
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Mic Icon Button (Solid White Circle)
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.mic_none_rounded,
                            color: Color(0xFF0F172A),
                            size: 24,
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
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, bool isDark) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment:
              msg.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.76,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: msg.isUser
                    ? const Color(0xFF2563EB)
                    : (isDark ? const Color(0xFF262223) : const Color(0xFFF1F5F9)),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(msg.isUser ? 18 : 4),
                  bottomRight: Radius.circular(msg.isUser ? 4 : 18),
                ),
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMedium(
                  color: msg.isUser
                      ? AppColors.white
                      : (isDark ? AppColors.white : const Color(0xFF0F172A)),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ).copyWith(height: 1.35),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.time,
                  style: AppTextStyles.caption(
                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
                if (msg.isUser) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.done_all_rounded,
                    size: 14,
                    color: Color(0xFF3B82F6),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
