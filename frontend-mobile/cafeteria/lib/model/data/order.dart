import 'dart:convert';

import 'package:cafeteria/model/data/dish_in_order.dart';

class Order {
  final List<DishInOrder> dishes;

  Order(this.dishes);

  Map<String, dynamic> toJson() =>
      {'dishes': dishes.map((e) => e.toJson()).toList()};
}
