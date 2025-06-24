// lib/features/settings/presentation/manager/settings_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial()) {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool('darkMode') ?? false;
    final noti = prefs.getBool('notifications') ?? true;

    emit(state.copyWith(darkMode: dark, notifications: noti));
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    emit(state.copyWith(darkMode: value));
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value) {
      // Request permission (especially for Android 13+ & iOS)
      final permission = await Permission.notification.request();
      if (!permission.isGranted) return;
    }

    await prefs.setBool('notifications', value);
    emit(state.copyWith(notifications: value));

    if (value) {
      NotificationService.showLocalNotification(
        id: 1,
        title: "🔔 Notifications Enabled",
        body: "You will now receive alerts from ${StringManager.appName}!",
      );
    }
  }
}
