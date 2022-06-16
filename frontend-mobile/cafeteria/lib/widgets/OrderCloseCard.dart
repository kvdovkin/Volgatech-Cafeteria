import 'package:cafeteria/model/completed_order.dart';
import 'package:flutter/material.dart';

class OrderCloseCard extends StatefulWidget {
  final CompletedOrder order;

  OrderCloseCard({required this.order});

  @override
  _OrderCloseCardState createState() => _OrderCloseCardState();
}

class _OrderCloseCardState extends State<OrderCloseCard> {
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.1,
      color: Colors.white,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "№ ${widget.order.id.toString().padLeft(6, '0')}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.order.dateTime.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: width * 0.06),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.order.totalCost} Р",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
