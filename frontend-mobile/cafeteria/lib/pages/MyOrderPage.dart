import 'package:cafeteria/providers/Cart.dart';
import 'package:cafeteria/model/data/dish.dart';
import 'package:cafeteria/repositories/order_repository.dart';
import 'package:cafeteria/widgets/DishCard.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  _openPayPopup(context) {
    Alert(
        context: context,
        title: "Подтвердите оплату",
        content: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/pay.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              final cart = Provider.of<Cart>(context, listen: false);
              final repository =
                  Provider.of<OrderRepository>(context, listen: false);

              await repository.placeOrder(cart.convertListToDishInOrder());

              cart.clear();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Color.fromARGB(255, 0, 117, 124),
            radius: BorderRadius.circular(15),
            child: Text(
              "Оплатить",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget _payButton() {
    return InkWell(
        onTap: () {
          _openPayPopup(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 117, 124),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            'Оплатить',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 100,
      ),
      body: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Consumer<Cart>(builder: (context, cart, child) {
                return Text("Всего ${cart.itemCount}",
                    style: TextStyle(color: Colors.grey, fontSize: 16));
              }),
            ),
            Expanded(child: _CartList()),
            Align(
              alignment: Alignment.bottomRight,
              child: Consumer<Cart>(builder: (context, cart, child) {
                return Text("Итого ${cart.totalAmount} ₽",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold));
              }),
            ),
            SizedBox(height: height * 0.03),
            _payButton(),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );

    // //SizedBox(),

    //);
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return ListView.builder(
      itemCount: cart.itemCount,
      itemBuilder: (context, i) => DishCard(
        dish: Dish(
          id: cart.items.values.toList()[i].id,
          imageUrl: cart.items.values.toList()[i].imageUrl,
          price: cart.items.values.toList()[i].price,
          quantity: cart.items.values.toList()[i].quantity,
          grams: cart.items.values.toList()[i].grams,
          name: cart.items.values.toList()[i].name,
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  _openDeletePopUp(context) {
    Alert(
        context: context,
        title: "Очистить корзину ?",
        content: Column(
          children: <Widget>[
            Container(
              height: 100,
              // width: 100,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/delete_basket.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).clear();
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Color.fromARGB(255, 0, 117, 124),
            radius: BorderRadius.circular(15),
            child: Text(
              "Очистить",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 17, 145, 153),
          padding: EdgeInsets.only(top: 50),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Мой заказ',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                _openDeletePopUp(context);
              },
            ),
          ]),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
