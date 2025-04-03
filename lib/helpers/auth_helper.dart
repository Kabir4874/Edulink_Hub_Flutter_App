import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  static Future<Map<String, dynamic>?> decodeToken() async {
    final token = await getToken();
    if (token != null) {
      try {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
        return decodedToken;
      } catch (e) {
        print("Error decoding token: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
