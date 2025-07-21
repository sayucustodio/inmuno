import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inmuno/core/constants.dart';
import 'package:inmuno/data/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<UsuarioModel> login(String usuario, String clave) async {
    final url = Uri.parse(AppConstants.loginEndpoint);

    final response = await http.post(
      url,
      headers: AppConstants.jsonHeaders,
      body: jsonEncode({
        'usuario': usuario,
        'clave': clave,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UsuarioModel.fromJson(data);
    } else {
      throw Exception('Error en login: ${response.body}');
    }
  }

  Future<void> guardarSesion(String token, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('userId', userId);
  }

  Future<void> guardarUsuario(UsuarioModel usuario) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(usuario.toJson());
    await prefs.setString('usuario', jsonString);
  }
}
