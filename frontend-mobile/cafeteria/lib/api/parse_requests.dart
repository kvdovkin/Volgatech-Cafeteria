import 'dart:convert';

import 'package:cafeteria/model/completed_order.dart';
import 'package:cafeteria/model/data/dish.dart';

List<Dish> parseDishes(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['dishes'].cast<Map<String, dynamic>>();

  return parsed.map<Dish>((json) => Dish.fromJson(json)).toList();
}

List<CompletedOrder> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<CompletedOrder>((json) => CompletedOrder.fromJson(json))
      .toList();
}
