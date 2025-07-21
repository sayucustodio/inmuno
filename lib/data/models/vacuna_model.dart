class VacunaModel {
  final String id;
  final String nombre;
  final DateTime fechaAplicacion;
  final int dosis;
  final String observaciones;

  VacunaModel({
    required this.id,
    required this.nombre,
    required this.fechaAplicacion,
    required this.dosis,
    this.observaciones = '',
  });

  factory VacunaModel.fromJson(Map<String, dynamic> json) {
    return VacunaModel(
      id: json['id'],
      nombre: json['nombre'],
      fechaAplicacion: DateTime.parse(json['fechaAplicacion']),
      dosis: json['dosis'],
      observaciones: json['observaciones'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fechaAplicacion': fechaAplicacion.toIso8601String(),
      'dosis': dosis,
      'observaciones': observaciones,
    };
  }
}
