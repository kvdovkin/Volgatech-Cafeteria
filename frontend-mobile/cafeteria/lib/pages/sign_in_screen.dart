import 'package:cafeteria/cafeteria_colors.dart';
import 'package:cafeteria/pages/MenuPage.dart';
import 'package:cafeteria/pages/main_page.dart';
import 'package:cafeteria/providers/Cart.dart';
import 'package:cafeteria/providers/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CafeteriaColors.tealDark,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Image.asset(
                  "assets/volgatech_logo.png",
                  width: 120,
                  height: 120,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 1.0,
                      child: Text(
                        "Авторизация",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(" | ",
                          style: TextStyle(fontSize: 22, color: Colors.white)),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/signup'),
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          "Регистрация",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              LoginFormWidget(),
            ]),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _nameController = TextEditingController()..text = "User1";
  final _passwordController = TextEditingController()..text = "123456";

  Future<void> _onLoginPressed(BuildContext context) async {
    final loginModel = context.read<LoginModel>();

    await loginModel.login(_nameController.text, _passwordController.text);

    if (loginModel.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Имя пользователя",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Пароль",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                style: TextStyle(
                  color: CafeteriaColors.goldDark,
                  letterSpacing: 8,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            "assets/dots_separator.png",
            height: 12,
          ),
        ),
        Container(
          width: 350,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () {
              _onLoginPressed(context);
            },
            child: Text(
              "Войти",
              style: TextStyle(color: CafeteriaColors.tealDark, fontSize: 16),
            ),
          ),
        ),
        Container(
            width: 350,
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(CafeteriaColors.lks),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: null,
              icon: Image.asset(
                "assets/icon_out.png",
                width: 22,
              ),
              label: Text("Войти через ЛКС"),
            )),
      ],
    );
  }
}
