import 'package:flutter/material.dart';

import 'MenuPage.dart';

class MyOrderEmptyPage extends StatefulWidget {
  MyOrderEmptyPage({required this.title});

  final String title;

  @override
  _MyOrderEmptyPageState createState() => _MyOrderEmptyPageState();
}

class _MyOrderEmptyPageState extends State<MyOrderEmptyPage> {
  Widget _backMenuButton() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MenuPage()),
          // );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 0, 117, 124),
              //                   <--- border color
              width: 2.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            'Вернуться в меню',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 0, 117, 124)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        // here the desired height
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 145, 153),
          title: Padding(
            padding: EdgeInsets.only(top: height * 0.00),
            child: Text('Мой заказ'),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/empty_basket.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: height * 0.02),
            Align(
              alignment: Alignment.center,
              child: Text("Ваша корзина пуста",
                  style: TextStyle(
                      color: Color.fromARGB(255, 147, 147, 147), fontSize: 20)),
            ),
            SizedBox(height: height * 0.1),
            _backMenuButton(),
          ],
        ),
      ),
    );
  }
}
