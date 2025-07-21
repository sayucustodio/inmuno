// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inmuno/core/constants.dart';
import 'package:inmuno/data/models/vacuna_esquema_model.dart';

class VacunaService {
  Future<List<VacunaEsquemaModel>> getVacunasConEsquema() async {
    final url = Uri.parse('${AppConstants.baseUrl}/vacuna/esquema');
    print('URL para obtener vacunas con esquema: $url');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => VacunaEsquemaModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener vacunas: ${response.body}');
    }
  }
}
