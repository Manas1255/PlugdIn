import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.notificationsEnabled = false,
    this.profileInfo = const DataState.initial(),
  });

  final bool notificationsEnabled;
  final DataState<UserModel> profileInfo;

  ProfileState copyWith({
    bool? notificationsEnabled,
    DataState<UserModel>? profileInfo,
  }) {
    return ProfileState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      profileInfo: profileInfo ?? this.profileInfo,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    profileInfo,
  ];
}
