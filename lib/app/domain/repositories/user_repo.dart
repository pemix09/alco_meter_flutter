import 'package:alco_meter_flutter/app/data/models/user.dart';
import 'package:hive/hive.dart';

class UserRepository {
  static const userBoxName = 'usersBox';

  Future<void> addUser(User user) async {
    var usersBox = await Hive.openBox<User>(userBoxName);
    await usersBox.put(user.id, user);
  }

  Future<User> getUser() async {
    var usersBox = await Hive.openBox<User>(userBoxName);
    return usersBox.values.first;
  }

  Future<List<User>> getUsers() async {
    var usersBox = await Hive.openBox<User>(userBoxName);
    return usersBox.values.toList();
  }

  Future<void> deleteUser(User user) async {
    var usersBox = await Hive.openBox<User>(userBoxName);
    await usersBox.delete(user.id);
  }
}
