import 'package:flutter/material.dart';
import '../models/vacuna_model.dart';

class VacunaProvider with ChangeNotifier {
  final List<VacunaModel> _vacunas = [];

  List<VacunaModel> get vacunas => [..._vacunas];

  void agregarVacuna(VacunaModel vacuna) {
    _vacunas.add(vacuna);
    notifyListeners();
  }

  void eliminarVacuna(String id) {
    _vacunas.removeWhere((v) => v.id == id);
    notifyListeners();
  }

  void cargarVacunas(List<VacunaModel> lista) {
    _vacunas.clear();
    _vacunas.addAll(lista);
    notifyListeners();
  }
}
