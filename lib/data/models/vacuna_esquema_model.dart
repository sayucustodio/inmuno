// ignore_for_file: non_constant_identifier_names

class VacunaEsquemaModel {
  final int vacuna_id;
  final String nombre;
  final String descripcion;
  final String dosis;
  final String via;
  final bool? es_obligatoria;
  final int? esquema_id;
  final int? edad_minima_meses;
  final int? edad_maxima_meses;
  final String? dosis_orden;

  VacunaEsquemaModel({
    required this.vacuna_id,
    required this.nombre,
    required this.descripcion,
    required this.dosis,
    required this.via,
    required this.es_obligatoria,
    this.esquema_id,
    this.edad_minima_meses,
    this.edad_maxima_meses,
    this.dosis_orden,
  });

  factory VacunaEsquemaModel.fromJson(Map<String, dynamic> json) {
    return VacunaEsquemaModel(
      vacuna_id: json['vacuna_id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      dosis: json['dosis'],
      via: json['via'],
      es_obligatoria: json['es_obligatoria'],
      esquema_id: json['esquema_id'],
      edad_minima_meses: json['edad_minima_meses'],
      edad_maxima_meses: json['edad_maxima_meses'],
      dosis_orden: json['dosis_orden'],
    );
  }
}
