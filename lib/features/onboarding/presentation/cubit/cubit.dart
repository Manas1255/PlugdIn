import 'package:bloc/bloc.dart';
import 'package:plugdin/features/onboarding/domain/repositories/onboarding_flow_repository.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';

class OnboardingFlowCubit extends Cubit<OnboardingFlowState> {
  OnboardingFlowCubit({required this.repository})
    : super(const OnboardingFlowState());

  final OnboardingFlowRepository repository;
}
