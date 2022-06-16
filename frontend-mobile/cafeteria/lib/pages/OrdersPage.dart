import 'package:flutter/material.dart';

import '../widgets/FinishedOrders.dart';
import '../widgets/PaidOrders.dart';

class OrdersPage extends StatelessWidget {
  final List<Widget> _children = [
    PaidOrdersPage(),
    FinishedOrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 17, 145, 153),
            title: Text('Мои заказы'),
            centerTitle: true,
            automaticallyImplyLeading: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                    icon: Text(
                  "Оплаченные",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
                Tab(
                    icon: Text(
                  "Завершенные",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _children[0],
              _children[1],
            ],
          ),
        ));
  }
}
