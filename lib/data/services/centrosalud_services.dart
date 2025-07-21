import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inmuno/core/constants.dart';
import 'package:inmuno/data/models/centro_salud_model.dart';

class CentroSaludService {
  Future<List<CentroSaludModel>> listarCentrosSalud() async {
    final url = Uri.parse('${AppConstants.baseUrl}/centrosalud/listar');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CentroSaludModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al listar centros de salud: ${response.body}');
    }
  }
}
