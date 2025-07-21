class PersonaModel {
  final int id;
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

  PersonaModel({
    required this.id,
    required this.dni,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.sexo,
    required this.fechaNacimiento,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.esMenor,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      id: json['id'] ?? 0,
      dni: json['dni'] ?? '',
      nombres: json['nombres'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      sexo: json['sexo'] ?? '',
      fechaNacimiento:
          json['fecha_nacimiento'] != null && json['fecha_nacimiento'] != ''
              ? DateTime.parse(json['fecha_nacimiento'])
              : null,
      direccion: json['direccion'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      esMenor: json['es_menor'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'nombres': nombres,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'sexo': sexo,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String(),
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
      'es_menor': esMenor,
    };
  }
}
