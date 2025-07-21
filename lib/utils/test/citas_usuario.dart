class CitasData {
  static final Map<DateTime, List<Map<String, String>>> citas = {
    DateTime.utc(2025, 5, 14): [
      {
        'paciente': 'JUAN MARCELO RAMIREZ CERNA',
        'vacuna': 'COVID 19',
        'hora': '12:30 PM',
        'observaciones':
            'Traer inyección de remdesivir y a su menor hijo en ayunas. Llegar 10 minutos antes.',
        'medico': 'SAYURI CUSTODIO',
        'estado': 'Finalizado',
      },
    ],
    DateTime.utc(2025, 7, 12): [
      {
        'paciente': 'ANDREA LUCÍA GÓMEZ TORRES',
        'vacuna': 'INFLUENZA',
        'hora': '09:00 AM',
        'observaciones':
            'Presentarse en ayunas. Llevar carnet de vacunación actualizado.',
        'medico': 'DR. LUIS FERNANDO PAREDES',
        'estado': 'Pendiente',
      },
    ],
    DateTime.utc(2025, 7, 20): [
      {
        'paciente': 'LUIS EDUARDO MORALES',
        'vacuna': 'VPH',
        'hora': '03:15 PM',
        'observaciones': 'Evitar alimentos grasos antes de la cita.',
        'medico': 'DRA. KARINA MENDOZA',
        'estado': 'Cancelado',
      },
    ],
    DateTime.utc(2025, 8, 5): [
      {
        'paciente': 'ROSA ELENA VELÁSQUEZ',
        'vacuna': 'TÉTANOS',
        'hora': '11:45 AM',
        'observaciones': 'Confirmar asistencia con 1 día de anticipación.',
        'medico': 'DR. HÉCTOR MANSILLA',
        'estado': 'Reprogramado',
      },
    ],
  };
}
