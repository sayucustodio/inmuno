class CentroSaludModel {
  final int id;
  final String nombre;
  final String tipo;
  final String? ruc;
  final String direccion;
  final String? distrito;
  final String? provincia;
  final String? departamento;
  final String? telefono;
  final String? correo;
  final String? web;
  final int? responsableId;
  final bool activo;

  CentroSaludModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    this.ruc,
    required this.direccion,
    this.distrito,
    this.provincia,
    this.departamento,
    this.telefono,
    this.correo,
    this.web,
    this.responsableId,
    required this.activo,
  });

  factory CentroSaludModel.fromJson(Map<String, dynamic> json) {
    return CentroSaludModel(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      ruc: json['ruc'],
      direccion: json['direccion'],
      distrito: json['distrito'],
      provincia: json['provincia'],
      departamento: json['departamento'],
      telefono: json['telefono'],
      correo: json['correo'],
      web: json['web'],
      responsableId: json['responsableId'],
      activo: json['activo'],
    );
  }
}
