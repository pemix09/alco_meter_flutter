import 'package:alco_meter_flutter/app/domain/repositories/user_repo.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';
import 'package:get_it/get_it.dart';

class UserService {
  late final UserRepository userRepository;
  User? user;   //caching

  UserService() {
    final services = GetIt.instance;
    userRepository = services.get<UserRepository>();
  }

  Future<User?> readSetupFromStorage() async {
    user ??= await userRepository.getUser();
    return user;
  }

  Future<void> saveSetupToStorage(User userSetup) async {
    user = userSetup;
    await userRepository.addUser(userSetup);
  }
}