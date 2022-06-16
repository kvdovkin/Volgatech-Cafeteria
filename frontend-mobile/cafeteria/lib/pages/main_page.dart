import 'package:cafeteria/api/api_client.dart';
import 'package:cafeteria/pages/AccountPage.dart';
import 'package:cafeteria/pages/MenuPage.dart';
import 'package:cafeteria/pages/MyOrderPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPage extends State<MainPage> {
  int _currentIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      MenuPage(),
      MyOrderPage(),
      AccountPage(),
    ];

    return Scaffold(
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 117, 124),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Аккаунт',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
