import 'package:cafeteria/model/completed_order.dart';
import 'package:cafeteria/repositories/order_repository.dart';
import 'package:cafeteria/widgets/OrderCloseCard.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

class FinishedOrdersPage extends StatefulWidget {
  @override
  _FinishedOrdersPageState createState() => _FinishedOrdersPageState();
}

class _FinishedOrdersPageState extends State<FinishedOrdersPage> {
  // _openPayPopup(context) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;
  //   Alert(
  //       context: context,
  //       title: "Подтвердите оплату",
  //       content: Column(
  //         children: <Widget>[
  //           Container(
  //             height: 100,
  //             width: 100,
  //             child: Padding(
  //               padding: EdgeInsets.only(top: 20),
  //               child: Image.asset(
  //                 "assets/pay.png",
  //                 fit: BoxFit.contain,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       buttons: [
  //         DialogButton(
  //           onPressed: () => Navigator.pop(context),
  //           color: Color.fromARGB(255, 0, 117, 124),
  //           radius: BorderRadius.circular(15),
  //           child: Text(
  //             "Оплатить",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]).show();
  // }

  // Widget _replyOrder() {
  //   return InkWell(
  //       onTap: () {
  //         _openPayPopup(context);
  //       },
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: Color.fromARGB(255, 0, 117, 124),
  //             //                   <--- border color
  //             width: 2.0,
  //           ),
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(20)),
  //         ),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.replay_outlined,
  //                 color: Color.fromARGB(255, 0, 117, 124)),
  //             SizedBox(width: 10),
  //             Text(
  //               'Повторить заказ',
  //               style: TextStyle(
  //                   fontSize: 20, color: Color.fromARGB(255, 0, 117, 124)),
  //             ),
  //           ],
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Positioned(
                child: Container(
              height: height * 0.1,
              color: Colors.white,
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
                            "№ Заказа",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 117, 124)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Дата и время",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 117, 124)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Итого",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 117, 124)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.04),
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down_outlined,
                                      color: Colors.white),
                                  onPressed: () => null,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
              child: FutureBuilder<List<CompletedOrder>>(
                future: context.read<OrderRepository>().getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? OrderList(orders: snapshot.data!)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<CompletedOrder> orders;

  OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCloseCard(order: orders[orders.length - index - 1]);
      },
    );
  }
}
