part of 'settings_cubit.dart';

class SettingsState {
  final bool notifications;
  final bool darkMode;

  SettingsState({required this.notifications, required this.darkMode});

  factory SettingsState.initial() =>
      SettingsState(notifications: true, darkMode: false);

  SettingsState copyWith({bool? notifications, bool? darkMode}) {
    return SettingsState(
      notifications: notifications ?? this.notifications,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}