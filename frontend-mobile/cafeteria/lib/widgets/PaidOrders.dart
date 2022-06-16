import 'package:flutter/material.dart';

class PaidOrdersPage extends StatefulWidget {
  @override
  _PaidOrdersPageState createState() => _PaidOrdersPageState();
}

class _PaidOrdersPageState extends State<PaidOrdersPage> {
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
                                        color:
                                            Color.fromARGB(255, 0, 117, 124)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: IconButton(
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
