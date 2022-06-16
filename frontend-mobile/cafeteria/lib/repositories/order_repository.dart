import 'package:cafeteria/api/api_client.dart';
import 'package:cafeteria/model/completed_order.dart';
import 'package:cafeteria/model/data/dish_in_order.dart';

class OrderRepository {
  final ApiClient _apiClient;

  OrderRepository(this._apiClient);

  Future<void> placeOrder(final List<DishInOrder> list) async {
    await _apiClient.placeOrder(list);
  }

  Future<List<CompletedOrder>> getOrders() async {
    final asd = await _apiClient.getOrders();

    asd;

    return asd;
  }
}
