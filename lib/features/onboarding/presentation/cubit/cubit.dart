import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/features/onboarding/data/models/vendor_onboarding_request_model.dart';
import 'package:plugdin/features/onboarding/domain/repositories/onboarding_flow_repository.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.repository}) : super(const OnboardingState());

  final OnboardingFlowRepository repository;

  final ImagePicker _picker = ImagePicker();

  void selectRole(RoleType roleType) {
    emit(
      state.copyWith(
        selectedRoleType: roleType,
      ),
    );
  }

  void setSelectedCity(City? city) {
    emit(
      state.copyWith(
        selectedCity: city,
      ),
    );
  }

  void setSelectedPrimaryCategory(CategoryType? category) {
    emit(
      state.copyWith(
        selectedPrimaryCategory: category,
      ),
    );
  }

  void setSelectedAdditionalCategory(CategoryType? category) {
    emit(
      state.copyWith(
        selectedAdditionalCategory: category,
      ),
    );
  }

  void setCurrentPage(int page) {
    emit(
      state.copyWith(
        currentPage: page,
      ),
    );
  }

  void nextPage() {
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
      ),
    );
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
        ),
      );
    }
  }

  Future<void> customerEmailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
    required String userName,
  }) async {
    emit(
      state.copyWith(
        customerEmailSignUp: const DataState.loading(),
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
          customerEmailSignUp: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          customerEmailSignUp: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> vendorEmailSignUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String companyName,
    required String personName,
    required String address,
    required String city,
    required String phoneNumber,
    required String primaryCategory,
    required String businessDescription,
    String? companyLogo,
    List<String>? additionalCategories,
    List<String>? links,
  }) async {
    emit(
      state.copyWith(
        vendorEmailSignUp: const DataState.loading(),
      ),
    );

    final response = await repository.vendorEmailSignUp(
      vendorOnboardingRequestModel: VendorOnboardingRequestModel(
        name: name,
        username: username,
        email: email,
        password: password,
        companyName: companyName,
        companyLogo: companyLogo,
        personName: personName,
        address: address,
        city: city,
        phoneNumber: phoneNumber,
        primaryCategory: primaryCategory,
        additionalCategories: additionalCategories,
        links: links,
        businessDescription: businessDescription,
      ),
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          vendorEmailSignUp: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          vendorEmailSignUp: DataState.failure(
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
          emailLogin: const DataState.loaded(
            data: true,
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

  Future<void> googleSignIn() async {
    emit(
      state.copyWith(
        googleSignIn: const DataState.loading(),
      ),
    );

    final response = await repository.googleSignIn();

    if (response.isSuccess) {
      emit(
        state.copyWith(
          googleSignIn: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          googleSignIn: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> pickTeamImage({ImageSource source = ImageSource.gallery}) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    // if (pickedFile != null) {
    //   addTeamImage(
    //     File(pickedFile.path),
    //   );
    // }
  }

  Future<void> pickTeamImageFromCamera() async {
    await pickTeamImage(source: ImageSource.camera);
  }

  Future<void> pickTeamImageFromGallery() async {
    await pickTeamImage();
  }
}
