part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool darkMode;
  final bool notifications;
  final Locale locale;

  const SettingsState({
    required this.darkMode,
    required this.notifications,
    required this.locale,
  });

  factory SettingsState.initial() => const SettingsState(
        darkMode: false,
        notifications: true,
        locale: Locale('en'),
      );

  SettingsState copyWith({
    bool? darkMode,
    bool? notifications,
    Locale? locale,
  }) {
    return SettingsState(
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [darkMode, notifications, locale];
}
