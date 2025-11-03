import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.notificationsEnabled = false,
    this.profileInfo = const DataState.initial(),
    this.changePassword = const DataState.initial(),
    this.userPreferences = const DataState.initial(),
    this.deleteAccount = const DataState.initial(),
  });

  final bool notificationsEnabled;
  final DataState<UserModel> profileInfo;
  final DataState<bool> changePassword;
  final DataState<bool> userPreferences;
  final DataState<bool> deleteAccount;

  ProfileState copyWith({
    bool? notificationsEnabled,
    DataState<UserModel>? profileInfo,
    DataState<bool>? changePassword,
    DataState<bool>? userPreferences,
    DataState<bool>? deleteAccount,
  }) {
    return ProfileState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      profileInfo: profileInfo ?? this.profileInfo,
      changePassword: changePassword ?? this.changePassword,
      userPreferences: userPreferences ?? this.userPreferences,
      deleteAccount: deleteAccount ?? this.deleteAccount,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    profileInfo,
    changePassword,
    userPreferences,
    deleteAccount,
  ];
}
