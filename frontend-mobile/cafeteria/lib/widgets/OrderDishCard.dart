import 'package:flutter/material.dart';

class OrderDishCard extends StatefulWidget {
  @override
  _OrderDishCardState createState() => _OrderDishCardState();
}

class _OrderDishCardState extends State<OrderDishCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.1,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 0.95,
                      child: Image.asset(
                        "assets/potato.png",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text("Картофельное пюре",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18)),
                      ),
                      Text(
                        "150 г",
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("1",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("15 ₽",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
