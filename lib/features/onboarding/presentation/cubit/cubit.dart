import 'package:bloc/bloc.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/features/onboarding/domain/repositories/onboarding_flow_repository.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.repository}) : super(const OnboardingState());

  final OnboardingFlowRepository repository;

  void selectRole(RoleType roleType) {
    emit(
      state.copyWith(
        selectedRoleType: roleType,
      ),
    );
  }

  Future<void> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
    required String userName,
  }) async {
    emit(
      state.copyWith(
        emailSignUp: const DataState.loading(),
      ),
    );

    final response = await repository.emailSignUp(
      fullName: fullName,
      email: email,
      password: password,
      role: role,
      userName: userName,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          emailSignUp: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailSignUp: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> emailLogin({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        emailLogin: const DataState.loading(),
      ),
    );

    final response = await repository.emailLogin(
      email: email,
      password: password,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          emailLogin: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailLogin: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> sendPasswordResetCode({
    required String email,
  }) async {
    emit(
      state.copyWith(
        passwordResetCode: const DataState.loading(),
      ),
    );

    final response = await repository.sendPasswordResetCode(
      email: email,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          passwordResetCode: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          passwordResetCode: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void setPasswordResetEmail({required String email}) {
    emit(
      state.copyWith(
        passwordResetEmail: email,
      ),
    );
  }

  Future<void> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    emit(
      state.copyWith(
        verifyPasswordResetCode: const DataState.loading(),
      ),
    );

    final response = await repository.verifyPasswordResetCode(
      email: email,
      code: code,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          verifyPasswordResetCode: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          verifyPasswordResetCode: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(
        resetPassword: const DataState.loading(),
      ),
    );

    final response = await repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          resetPassword: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          resetPassword: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }
}
