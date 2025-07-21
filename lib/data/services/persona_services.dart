// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inmuno/core/constants.dart';
import 'package:inmuno/data/models/centro_salud_model.dart';
import 'package:inmuno/data/models/hijo_model.dart';
import 'package:inmuno/data/models/persona_model.dart';
import 'package:inmuno/data/request/persona_request.dart';

class PersonaService {
  Future<PersonaModel> getPersonaById(int id) async {
    final url = Uri.parse('${AppConstants.baseUrl}/persona/getbyid');
    print('URL que se usará para obtener persona: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PersonaModel.fromJson(data);
    } else {
      throw Exception('Error al obtener persona: ${response.body}');
    }
  }

  Future<List<HijoConDetalleModel>> getHijosConDetalles(int usuarioId) async {
    final url = Uri.parse('${AppConstants.baseUrl}/persona/gethijosdetalles');
    print('URL que se usará para obtener hijos con detalles: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': usuarioId}),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => HijoConDetalleModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener hijos con detalles: ${response.body}');
    }
  }

  Future<CentroSaludModel?> getCentroSaludByUsuarioId(int UsuarioId) async {
    final url = Uri.parse('${AppConstants.baseUrl}/centrosalud/getbyusuario');
    print('URL para obtener centro de salud: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'UsuarioId': UsuarioId}),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return CentroSaludModel.fromJson(json);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Error al obtener centro de salud: ${response.body}');
    }
  }

  Future<bool> editarDatosPersona(UsuarioUpdateRequest request) async {
    final url = Uri.parse('${AppConstants.baseUrl}/persona/updatebyusuario');
    print('URL para editar datos personales: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al editar datos personales: ${response.body}');
    }
  }

  Future<int?> registrarUsuario(Map<String, dynamic> data) async {
    final url = Uri.parse('${AppConstants.baseUrl}/persona/registrar');
    print('URL para registrar usuario: $url');
    print('Payload: ${jsonEncode(data)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['usuarioId'];
    } else {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  Future<Map<String, bool>> verificarExistenciaDatos({
    String? dni,
    String? correo,
    String? usuario,
  }) async {
    final url =
        Uri.parse('${AppConstants.baseUrl}/persona/verificar-existencia');
    print('URL para verificar existencia de datos: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'dni': dni ?? '',
        'correo': correo ?? '',
        'usuario': usuario ?? '',
      }),
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        'dni_existe': json['dni_existe'] ?? false,
        'correo_existe': json['correo_existe'] ?? false,
        'usuario_existe': json['usuario_existe'] ?? false,
      };
    } else {
      throw Exception('Error al verificar existencia: ${response.body}');
    }
  }
}
