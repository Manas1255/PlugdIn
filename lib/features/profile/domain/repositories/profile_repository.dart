import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class ProfileRepository {
  Future<RepositoryResponse<UserModel>> fetchProfileInfo();
}
