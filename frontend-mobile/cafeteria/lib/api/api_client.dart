import 'dart:convert';
import 'dart:io';

import 'package:cafeteria/model/completed_order.dart';
import 'package:cafeteria/model/data/credentials.dart';
import 'package:cafeteria/model/data/dish.dart';
import 'package:cafeteria/model/data/dish_in_order.dart';
import 'package:cafeteria/model/data/order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'parse_requests.dart';

class ApiClient {
  // Android Emulator IP
  static final Uri url = Uri.http("10.0.2.2:8080", "/api");

  final http.Client client = http.Client();

  var token = "";

  Map<String, String> _headers() => {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

  Future<String> login(final Credentials cred) async => _auth("signin", cred);

  Future<String> register(final Credentials cred) async =>
      _auth("signup", cred);

  Future<void> placeOrder(final List<DishInOrder> list) async {
    await client.post(url.resolve("api/orders"),
        body: jsonEncode(Order(list).toJson()), headers: _headers());
  }

  Future<List<CompletedOrder>> getOrders() async {
    final response =
        await client.get(url.resolve("api/orders"), headers: _headers());

    if (response.statusCode == HttpStatus.ok) {
      return compute(parseOrders, response.body);
    } else {
      return [];
    }
  }

  Future<String> _auth(final String route, final Credentials cred) async {
    final response = await client.post(
      url.resolve("api/users/$route"),
      body: jsonEncode(cred.toJson()),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception("Не удалось авторизоваться");
    }
  }

  Future<List<Dish>> fetchMenu() async {
    final response =
        await client.get(url.resolve("api/menus/active"), headers: _headers());

    if (response.statusCode == HttpStatus.ok) {
      return compute(parseDishes, response.body);
    } else {
      return [];
    }
  }
}
