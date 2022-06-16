import 'package:cafeteria/model/data/dish_in_order.dart';
import 'package:flutter/foundation.dart';
import 'package:cafeteria/model/data/dish.dart';

class Cart extends ChangeNotifier {
  Map<int, Dish> _items = {};

  Map<int, Dish> get items {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Dish dish) {
    if (!_items.containsKey(dish.id)) {
      _items[dish.id] = dish;
    }

    if (_items.containsKey(dish.id)) {
      _items.update(
        dish.id,
        (existingValue) => Dish(
          id: existingValue.id,
          name: existingValue.name,
          imageUrl: existingValue.imageUrl,
          grams: existingValue.grams,
          price: existingValue.price,
          quantity: existingValue.quantity + 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(int id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingCartItem) => Dish(
          id: existingCartItem.id,
          name: existingCartItem.name,
          imageUrl: existingCartItem.imageUrl,
          price: existingCartItem.price,
          grams: existingCartItem.grams,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(id);
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int getQuantityForItem(int itemId) {
    return _items[itemId]?.quantity ?? 0;
  }

  List<DishInOrder> convertListToDishInOrder() {
    List<DishInOrder> list = [];

    _items.forEach((key, value) {
      list.add(DishInOrder(value.id, value.quantity));
    });

    return list;
  }
}
