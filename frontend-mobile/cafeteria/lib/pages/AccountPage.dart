import 'package:flutter/material.dart';
import 'OrdersPage.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _topUpAccount() {
    return InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 0, 117, 124).withOpacity(0.5),
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
              Icon(Icons.person_add_outlined,
                  color: Color.fromARGB(255, 0, 117, 124).withOpacity(0.5)),
              SizedBox(width: 10),
              Text(
                'Пополнить счет',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 117, 124).withOpacity(0.5)),
              ),
            ],
          ),
        ));
  }

  Widget _myOrders() {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrdersPage()),
          );
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fact_check_outlined,
                  color: Color.fromARGB(255, 0, 117, 124)),
              SizedBox(width: 10),
              Text(
                'Мои заказы',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 117, 124)),
              ),
            ],
          ),
        ));
  }

  Widget _exit() {
    return InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/signin');
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 255, 169, 164),
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
              Icon(Icons.exit_to_app_outlined,
                  color: Color.fromARGB(255, 231, 76, 60)),
              SizedBox(width: 10),
              Text(
                'Выйти',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 231, 76, 60)),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 145, 153),
          title: Padding(
            padding: EdgeInsets.only(top: height * 0.0),
            child: Text('Личный кабинет'),
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
          children: <Widget>[
            SizedBox(height: height * 0.02),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/account.png",
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text("140 ₽",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Остаток",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
            ),
            SizedBox(height: height * 0.02),
            _topUpAccount(),
            SizedBox(height: height * 0.02),
            _myOrders(),
            SizedBox(height: height * 0.02),
            _exit(),
          ],
        ),
      ),
    );

    // //SizedBox(),

    //);
  }
}
