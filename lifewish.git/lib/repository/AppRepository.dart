import 'package:life_wish/Model/User.dart';

class AppRepository {
  static final AppRepository _repository = AppRepository._internal();

  factory AppRepository() {
    return _repository;
  }

  int testVal = 0;

  AppRepository._internal();

  //app user
  User _user;

  User get user => _user;

  set user(item) => _user = item;
}
