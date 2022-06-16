import 'dish.dart';

class Menu {
  final List<Dish> dishes;

  Menu({required this.dishes});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      dishes: json['dishes'],
    );
  }
}
