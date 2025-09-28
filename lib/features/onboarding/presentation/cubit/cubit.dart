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
}
