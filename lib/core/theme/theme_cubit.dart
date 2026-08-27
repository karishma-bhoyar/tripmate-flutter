import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _boxName = 'settings_box';
  static const String _key = 'is_dark_mode';

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final box = Hive.box(_boxName);
    final isDark = box.get(_key, defaultValue: false) as bool;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme(bool isDark) {
    final box = Hive.box(_boxName);
    box.put(_key, isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
