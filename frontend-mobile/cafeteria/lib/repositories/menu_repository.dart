import 'package:cafeteria/api/api_client.dart';
import 'package:cafeteria/model/data/dish.dart';
import 'package:cafeteria/model/data/menu.dart';

class MenuRepository {
  final ApiClient _apiClient;

  MenuRepository(this._apiClient);

  Future<List<Dish>> fetchMenu() async {
    return await _apiClient.fetchMenu();
  }
}
