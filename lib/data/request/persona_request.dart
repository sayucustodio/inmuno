class UsuarioUpdateRequest {
  final int usuarioId;
  final String? nombres;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final DateTime? fechaNacimiento;
  final String? direccion;
  final String? telefono;
  final String? correo;

  UsuarioUpdateRequest({
    required this.usuarioId,
    this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.fechaNacimiento,
    this.direccion,
    this.telefono,
    this.correo,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'usuarioId': usuarioId,
      'nombres': nombres,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
    };

    json.removeWhere((key, value) => value == null);
    return json;
  }
}

class UsuarioRegisterRequest {
  String? nombres;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? dni;
  String? direccion;
  String? telefono;
  String? correo;
  String? sexo;
  DateTime? fechaNacimiento;
  String? usuario;
  String? contrasenia;
  int? rolId;
  int? centroSaludId; // opcional

  UsuarioRegisterRequest({
    this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.dni,
    this.direccion,
    this.telefono,
    this.correo,
    this.sexo,
    this.fechaNacimiento,
    this.usuario,
    this.contrasenia,
    this.rolId,
    this.centroSaludId,
  });

  Map<String, Object?> toJson() {
    return {
      "nombres": nombres,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "dni": dni,
      "direccion": direccion,
      "telefono": telefono,
      "correo": correo,
      "sexo": sexo,
      "fechaNacimiento": fechaNacimiento?.toIso8601String(),
      "usuario": usuario,
      "contrasenia": contrasenia,
      "rolId": rolId,
      if (centroSaludId != null) "centroSaludId": centroSaludId,
    };
  }
}
