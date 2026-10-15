import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

export 'app_colors.dart';
export 'app_text_styles.dart';
export 'light_theme.dart';
export 'dark_theme.dart';
export 'theme_cubit.dart';

class AppTheme {
  static ThemeData get light => lightThemeData;
  static ThemeData get dark => darkThemeData;
}
