import 'package:cafeteria/api/api_client.dart';
import 'package:cafeteria/pages/AccountPage.dart';
import 'package:cafeteria/pages/MenuPage.dart';
import 'package:cafeteria/pages/MyOrderPage.dart';
import 'package:cafeteria/pages/main_page.dart';
import 'package:cafeteria/pages/sign_in_screen.dart';
import 'package:cafeteria/pages/sign_up_screen.dart';
import 'package:cafeteria/providers/Cart.dart';
import 'package:cafeteria/providers/login_model.dart';
import 'package:cafeteria/repositories/authentication_repository.dart';
import 'package:cafeteria/repositories/menu_repository.dart';
import 'package:cafeteria/repositories/order_repository.dart';
import 'package:cafeteria/widgets/OrderOpenCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient();

    return MultiProvider(
      providers: [
        Provider<LoginModel>(
          create: (context) => LoginModel(AuthenticationRepository(apiClient)),
        ),
        Provider<MenuRepository>(
          create: (context) => MenuRepository(apiClient),
        ),
        Provider<OrderRepository>(
          create: (context) => OrderRepository(apiClient),
        ),
        ChangeNotifierProvider<Cart>(create: (context) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/signin',
        routes: {
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
