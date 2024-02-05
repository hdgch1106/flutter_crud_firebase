import 'package:crud_firebase/config/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        scaffoldBackgroundColor: ColorsCustom.background,
        useMaterial3: true,
      );
}
