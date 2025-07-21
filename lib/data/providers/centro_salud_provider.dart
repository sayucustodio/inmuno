import 'package:flutter/material.dart';
import 'package:inmuno/data/models/centro_salud_model.dart';

class CentroSaludProvider with ChangeNotifier {
  CentroSaludModel? _centrosalud;

  CentroSaludModel? get centrosalud => _centrosalud;

  void setcentrosalud(CentroSaludModel user) {
    _centrosalud = user;
    notifyListeners();
  }

  void clearcentrosalud() {
    _centrosalud = null;
    notifyListeners();
  }
}
