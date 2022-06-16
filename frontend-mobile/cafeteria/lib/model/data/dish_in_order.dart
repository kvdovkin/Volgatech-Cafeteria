class DishInOrder {
  final int id;
  final int quantity;

  DishInOrder(this.id, this.quantity);

  DishInOrder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}
