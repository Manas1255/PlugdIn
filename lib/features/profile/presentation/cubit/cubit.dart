import 'package:bloc/bloc.dart';
import 'package:plugdin/features/profile/domain/repositories/profile_repository.dart';
import 'package:plugdin/features/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

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
}
