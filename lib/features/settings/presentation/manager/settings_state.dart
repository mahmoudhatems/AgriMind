part of 'settings_cubit.dart';

class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;

  const SettingsState({
    required this.notificationsEnabled,
    required this.darkModeEnabled,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}
