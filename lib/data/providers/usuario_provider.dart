import 'package:flutter/material.dart';
import 'package:inmuno/data/models/usuario_model.dart';

class UsuarioProvider with ChangeNotifier {
  UsuarioModel? _usuario;

  UsuarioModel? get usuario => _usuario;

  void setUsuario(UsuarioModel user) {
    _usuario = user;
    notifyListeners();
  }

  void clearUsuario() {
    _usuario = null;
    notifyListeners();
  }
}
