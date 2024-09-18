import 'package:flutter/material.dart';
import 'package:yu_gi_oh_app/config/theme/app_color_scheme.dart';
import 'package:yu_gi_oh_app/config/theme/text_theme.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        fontFamily: 'Stone-Serif',
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: appColorScheme,
        textTheme: textTheme,
      );
}
