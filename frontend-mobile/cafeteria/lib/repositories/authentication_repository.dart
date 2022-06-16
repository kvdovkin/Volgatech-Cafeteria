import 'package:cafeteria/api/api_client.dart';
import 'package:cafeteria/model/data/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final ApiClient _apiClient;
  SharedPreferences? _preferences;

  AuthenticationRepository(this._apiClient);

  Future<String?> get token async {
    _preferences = await SharedPreferences.getInstance()
      ..getString("token");
  }

  Future<String> login(String name, String password) async {
    final token = await _apiClient.login(Credentials(name, password));

    await _onAuthenticated(token);

    return token;
  }

  Future<String> register(String name, String password) async {
    final token = await _apiClient.register(Credentials(name, password));

    await _onAuthenticated(token);

    return token;
  }

  Future<void> _onAuthenticated(String token) async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    _preferences!.setString("token", token);

    _apiClient.token = token;
  }
}
