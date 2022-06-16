import 'package:cafeteria/model/data/dish.dart';
import 'package:cafeteria/providers/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishCard extends StatefulWidget {
  DishCard({required this.dish});

  final Dish dish;

  @override
  _DishCardState createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Container(
        height: 120,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                        aspectRatio: 0.95,
                        child: Image.network(
                          widget.dish.imageUrl ?? "",
                          fit: BoxFit.cover,
                        ))),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 65,
                          alignment: Alignment.centerLeft,
                          child: Text(widget.dish.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 22)),
                        ),
                        Text(
                          "${widget.dish.grams} г",
                          style: TextStyle(color: Colors.grey),
                        )
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible:
                                    cart.getQuantityForItem(widget.dish.id) > 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    cart.removeSingleItem(widget.dish.id);
                                  },
                                  child: Image.asset(
                                    "assets/minus.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    cart.getQuantityForItem(widget.dish.id) > 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "${cart.getQuantityForItem(widget.dish.id)}",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 90, 90, 90),
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  cart.addItem(widget.dish);
                                },
                                child: Image.asset(
                                  "assets/plus.png",
                                  width: 32,
                                  height: 32,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${widget.dish.price} ₽",
                            style: TextStyle(
                                color: Color.fromARGB(255, 90, 90, 90),
                                fontSize: 16),
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
