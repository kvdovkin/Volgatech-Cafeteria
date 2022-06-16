import 'package:flutter/material.dart';

class OrderOpenFinishedCard extends StatefulWidget {
  @override
  _OrderOpenFinishedCardState createState() => _OrderOpenFinishedCardState();
}

class _OrderOpenFinishedCardState extends State<OrderOpenFinishedCard> {
  Widget _replyOrder() {
    return InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.replay_outlined,
                  color: Color.fromARGB(255, 0, 117, 124)),
              SizedBox(width: 10),
              Text(
                'Повторить заказ',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 117, 124)),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        children: [
          Container(
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
                            "№ 123456",
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
                            "23.01.2021 17:21:36",
                            style: TextStyle(fontSize: 18, color: Colors.black),
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
                                  "103 Р",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: width * 0.07),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: height * 0.02,
                                      child: Image.asset(
                                        "assets/arrow_up.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.1,
            child: Container(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("1",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("15 ₽",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: _replyOrder(),
          ),
        ],
      ),
    );
  }
}
