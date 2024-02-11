import 'package:alco_meter_flutter/app/domain/repositories/user_repo.dart';
import 'package:alco_meter_flutter/app/data/enums/sex.dart';
import 'package:alco_meter_flutter/app/data/models/user.dart';
import 'package:get_it/get_it.dart';

class UserService {
  late final UserRepository userRepository;

  UserService() {
    final services = GetIt.instance;
    userRepository = services.get<UserRepository>();
  }

  Future<User> readSetupFromStorage() async {
    return await userRepository.getUser();
  }

  Future<void> saveSetupToStorage(User userSetup) async {
    await userRepository.addUser(userSetup);
  }
}