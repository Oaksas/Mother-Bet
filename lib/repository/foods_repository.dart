import 'package:mother_bet/dataProvider/foods_data_provider.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/models/mother.dart';

class FoodsRepository {
  final FoodsDataProvider _dataProvider;
  FoodsRepository(this._dataProvider);

  Future<List<Food>> fetchTopFoods() async {
    return _dataProvider.fetchTopFoods();
  }

  Future<List<Mother>> fetchMothers() async {
    return _dataProvider.fetchMothers();
  }

  Future<Food> getFood(String id) async {
    return _dataProvider.getFood(id);
  }

  Future<List<Mother>> searchFoods(String name) async {
    return _dataProvider.searchFoods(name);
  }
}
