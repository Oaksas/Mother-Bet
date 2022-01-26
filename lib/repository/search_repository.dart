import 'package:mother_bet/dataProvider/search_data_provider.dart';
import 'package:mother_bet/models/mother.dart';

class SearchRepository {
  final SearchDataProvider _dataProvider;
  SearchRepository(this._dataProvider);

  Future<List<Mother>> searchFoods(String name) async {
    return _dataProvider.searchFoods(name);
  }
}
