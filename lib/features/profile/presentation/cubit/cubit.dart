import 'package:bloc/bloc.dart';
import 'package:plugdin/features/profile/domain/repositories/profile_repository.dart';
import 'package:plugdin/features/profile/presentation/cubit/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.repository}) : super(const ProfileState());

  final ProfileRepository repository;

  void toggleNotifications({required bool isEnabled}) {
    emit(
      state.copyWith(
        notificationsEnabled: isEnabled,
      ),
    );
  }
}
