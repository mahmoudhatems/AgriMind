import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial()) {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('dark_mode') ?? false;
    final isNotif = prefs.getBool('notifications') ?? true;
    final localeCode = prefs.getString('locale') ?? 'en';

    emit(state.copyWith(
      darkMode: isDark,
      notifications: isNotif,
      locale: Locale(localeCode),
    ));
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
    emit(state.copyWith(darkMode: value));
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    emit(state.copyWith(notifications: value));
  }

  Future<void> changeLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.languageCode);
    emit(state.copyWith(locale: newLocale));
  }
}
