import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/core/services/logout_service.dart';
import 'package:plugdin/features/profile/domain/repositories/profile_repository.dart';
import 'package:plugdin/features/profile/presentation/cubit/state.dart';
import 'package:plugdin/features/profile/presentation/widgets/pi_bottom_sheet.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(const ProfileState());

  final ProfileRepository repository;

  void toggleNotifications({required bool isEnabled}) {
    emit(
      state.copyWith(
        notificationsEnabled: isEnabled,
        userPreferences: const DataState.loading(),
      ),
    );
  }

  Future<void> fetchProfileInfo() async {
    emit(
      state.copyWith(
        profileInfo: const DataState.loading(),
      ),
    );
    final profileResponse = await repository.fetchProfileInfo();
    if (profileResponse.isSuccess) {
      emit(
        state.copyWith(
          profileInfo: DataState.loaded(
            data: profileResponse.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          profileInfo: DataState.failure(
            error: profileResponse.message,
          ),
        ),
      );
    }
  }

  void showLogoutBottomSheet(BuildContext context) {
    PIBottomSheet.show(
      context,
      title: 'Log Out?',
      text:
          'Are you sure you want to log out? You will need to sign in again to access your account.',
      buttonText: 'Log Out',
      onTap: () async {
        context.pop();
        await LogoutService().logout(
          profileCubit: this,
          context: context,
        );
      },
    );
  }

  Future<void> updateProfileInfo({
    required String name,
    required String username,
  }) async {
    emit(
      state.copyWith(
        profileInfo: const DataState.loading(),
      ),
    );

    final updateProfileResponse = await repository.updateProfileInfo(
      name: name,
      username: username,
    );

    if (updateProfileResponse.isSuccess) {
      emit(
        state.copyWith(
          profileInfo: DataState.loaded(
            data: updateProfileResponse.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          profileInfo: DataState.failure(
            error: updateProfileResponse.message,
          ),
        ),
      );
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(
        changePassword: const DataState.loading(),
      ),
    );

    final changePasswordResponse = await repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    if (changePasswordResponse.isSuccess) {
      emit(
        state.copyWith(
          changePassword: DataState.loaded(
            data: changePasswordResponse.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          changePassword: DataState.failure(
            error: changePasswordResponse.message,
          ),
        ),
      );
    }
  }

  Future<void> updateUserPreferences() async {
    emit(
      state.copyWith(
        userPreferences: const DataState.loading(),
      ),
    );

    final response = await repository.updateUserPreferences(
      inAppNotifications: state.notificationsEnabled,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          userPreferences: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          userPreferences: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> clearState() async {
    emit(const ProfileState());
  }
}
