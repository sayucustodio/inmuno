import 'package:flutter/material.dart';
import 'package:inmuno/data/models/hijo_model.dart';
import 'package:inmuno/data/services/persona_services.dart';

class HijosProvider with ChangeNotifier {
  List<HijoConDetalleModel> _hijos = [];
  List<HijoConDetalleModel> get hijos => _hijos;

  Future<void> updateHijos(int usuarioId) async {
    try {
      final personaService = PersonaService();
      final nuevosHijos = await personaService.getHijosConDetalles(usuarioId);

      _hijos = nuevosHijos;
      notifyListeners();
    } catch (e) {
      print('Error al cargar hijos: $e');
    }
  }

  void setHijos(List<HijoConDetalleModel> hijos) {
    _hijos = hijos;
    notifyListeners();
  }

  void clearHijos() {
    _hijos = [];
    notifyListeners();
  }
}
