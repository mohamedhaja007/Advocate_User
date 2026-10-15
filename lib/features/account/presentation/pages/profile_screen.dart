import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/localization/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(text: 'Karthik');
  final TextEditingController _lastNameController = TextEditingController(text: 'R');
  final TextEditingController _emailController = TextEditingController(text: 'karthikr@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+91 98765 43210');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: context.tr('edit_profile'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    const AppAvatar(
                      name: 'Karthik R',
                      radius: 44,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              AppTextField(
                label: context.tr('first_name'),
                controller: _firstNameController,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('last_name'),
                controller: _lastNameController,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('email_address'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('phone_number'),
                controller: _phoneController,
                readOnly: true,
              ),
              const SizedBox(height: 32),
              AppButton(
                text: context.tr('save'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
