class UsuarioModel {
  final int id;
  final String nombreCompleto;
  final String usuario;
  final int rolId;
  final String? rolNombre;
  final int? centroSaludId;
  final String? centroSaludNombre;
  final bool activo;
  final String? token;

  UsuarioModel({
    required this.id,
    required this.nombreCompleto,
    required this.usuario,
    required this.rolId,
    this.rolNombre,
    this.centroSaludId,
    this.centroSaludNombre,
    required this.activo,
    this.token,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json['id'],
        nombreCompleto: json['nombreCompleto'],
        usuario: json['usuario'],
        rolId: json['rolId'],
        rolNombre: json['rolNombre'],
        centroSaludId: json['centroSaludId'],
        centroSaludNombre: json['centroSaludNombre'],
        activo: json['activo'] == true,
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombreCompleto': nombreCompleto,
        'usuario': usuario,
        'rolId': rolId,
        'rolNombre': rolNombre,
        'centroSaludId': centroSaludId,
        'centroSaludNombre': centroSaludNombre,
        'activo': activo,
        'token': token,
      };
}
