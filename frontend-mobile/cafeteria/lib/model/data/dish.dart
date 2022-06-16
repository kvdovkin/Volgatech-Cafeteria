import 'package:cafeteria/api/api_client.dart';

class Dish {
  const Dish({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.grams,
    required this.price,
    required this.quantity,
  });

  final int id;
  final String name;
  final String? imageUrl;
  final int grams;
  final int price;
  final int quantity;

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: "${ApiClient.url.origin}/${(json['imageUrl'] as String)}",
      grams: json['grams'] as int,
      price: json['price'] as int,
      quantity: 0,
    );
  }
}
