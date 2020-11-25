import 'package:life_wish/Model/LifeWish.dart';
import 'package:life_wish/db/LifeWishDbProvider.dart';

class LifeWishRepository {
  LifeWishDbProvider _dbProvider = LifeWishDbProvider();

  Future<List<LifeWish>> getAllLifeWish() async {
    return _dbProvider.getAllLifeWish();
  }

  Future<void> insertLifeWish(LifeWish item) async {
    return _dbProvider.insertLifeWish(item);
  }

  Future<void> updateLifeWish(LifeWish item) async {
    _dbProvider.updateLifeWish(item);
  }

  Future<int> deleteLifeWish(String id) async {
    return _dbProvider.deleteLifeWish(id);
  }
}
