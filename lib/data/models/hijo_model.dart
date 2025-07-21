class HijoConDetalleModel {
  final int hijoId;
  final String parentesco;

  final int personaId;
  final String dni;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String sexo;
  final DateTime? fechaNacimiento;
  final String direccion;
  final String telefono;
  final String correo;
  final bool esMenor;

  final int? ninoId;
  final String estatura;
  final String peso;
  final String edad;
  final String imagen;
  final String genero;
  final DateTime? ultimaCita;

  HijoConDetalleModel({
    required this.hijoId,
    required this.parentesco,
    required this.personaId,
    required this.dni,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.sexo,
    this.fechaNacimiento,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.esMenor,
    this.ninoId,
    required this.estatura,
    required this.peso,
    required this.edad,
    required this.imagen,
    required this.genero,
    this.ultimaCita,
  });

  factory HijoConDetalleModel.fromJson(Map<String, dynamic> json) {
    return HijoConDetalleModel(
      hijoId: json['hijo_id'],
      parentesco: json['parentesco'] ?? '',
      personaId: json['persona_id'],
      dni: json['dni'] ?? '',
      nombres: json['nombres'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      sexo: json['sexo'] ?? '',
      fechaNacimiento: json['fecha_nacimiento'] == null
          ? null
          : DateTime.tryParse(json['fecha_nacimiento']),
      direccion: json['direccion'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      esMenor: json['es_menor'] ?? false,
      ninoId: json['nino_id'],
      estatura: json['estatura'] ?? '',
      peso: json['peso'] ?? '',
      edad: json['edad'] ?? '',
      imagen: json['imagen'] ?? '',
      genero: json['genero'] ?? '',
      ultimaCita: json['ultima_cita'] == null
          ? null
          : DateTime.tryParse(json['ultima_cita']),
    );
  }
}
