// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:inmuno/data/models/persona_model.dart';
import 'package:inmuno/data/services/persona_services.dart';

class PersonaProvider with ChangeNotifier {
  PersonaModel? _persona;

  PersonaModel? get persona => _persona;

  void setPersona(PersonaModel p) {
    _persona = p;
    notifyListeners();
  }

  Future<void> updatePersona(int usuarioId) async {
    try {
      final personaService = PersonaService();
      final personadatos = await personaService.getPersonaById(usuarioId);

      _persona = personadatos;
      notifyListeners();
    } catch (e) {
      print('Error al cargar datos actualizados de la persona: $e');
    }
  }

  void clearPersona() {
    _persona = null;
    notifyListeners();
  }
}
