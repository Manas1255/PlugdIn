import 'package:equatable/equatable.dart';

class OnboardingFlowState extends Equatable {
  const OnboardingFlowState({
    this.currentPage = 0,
  });

  final int currentPage;

  OnboardingFlowState copyWith({
    int? currentPage,
  }) {
    return OnboardingFlowState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    currentPage,
  ];
}
