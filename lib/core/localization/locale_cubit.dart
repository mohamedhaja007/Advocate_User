import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _key = 'selected_locale';

  LocaleCubit() : super(const Locale('en', 'US')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key);
    if (langCode != null && langCode.isNotEmpty) {
      emit(Locale(langCode));
    }
  }

  Future<void> setLocale(String languageCode) async {
    final newLocale = Locale(languageCode);
    emit(newLocale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
  }
}
