import 'package:cafeteria/cafeteria_colors.dart';
import 'package:cafeteria/providers/Cart.dart';
import 'package:cafeteria/model/data/dish.dart';
import 'package:cafeteria/repositories/menu_repository.dart';
import 'package:cafeteria/widgets/DishCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Меню"),
        centerTitle: true,
        backgroundColor: CafeteriaColors.teal,
        toolbarHeight: 60,
      ),
      body: FutureBuilder<List<Dish>>(
        future: context.read<MenuRepository>().fetchMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? DishesList(dishes: snapshot.data!, cart: context.read<Cart>())
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DishesList extends StatelessWidget {
  final List<Dish> dishes;
  final Cart cart;

  DishesList({required this.dishes, required this.cart});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        return DishCard(dish: dishes[index]);
      },
    );
  }
}
