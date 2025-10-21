import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.notificationsEnabled = false,
  });

  final bool notificationsEnabled;

  ProfileState copyWith({
    bool? notificationsEnabled,
  }) {
    return ProfileState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
  ];
}
