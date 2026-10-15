import 'package:flutter/material.dart';

class LanguageItem {
  final String code;
  final String name;
  final String nativeName;
  final String? badge;

  const LanguageItem({
    required this.code,
    required this.name,
    required this.nativeName,
    this.badge,
  });
}

class LocalizationConfig {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('ta', 'IN'),
    Locale('ml', 'IN'),
    Locale('kn', 'IN'),
    Locale('te', 'IN'),
  ];

  static const List<LanguageItem> languages = [
    LanguageItem(code: 'en', name: 'English', nativeName: 'Primary Default', badge: 'Primary Default'),
    LanguageItem(code: 'hi', name: 'Hindi', nativeName: 'हिंदी'),
    LanguageItem(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
    LanguageItem(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
    LanguageItem(code: 'kn', name: 'Kannada', nativeName: 'ಕನ್ನಡ'),
    LanguageItem(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
  ];

  static String getLanguageName(String languageCode) {
    final lang = languages.firstWhere(
      (l) => l.code == languageCode,
      orElse: () => languages.first,
    );
    return lang.name;
  }
}
