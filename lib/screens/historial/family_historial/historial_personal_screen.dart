import 'package:flutter/material.dart';
import 'package:inmuno/screens/historial/widgets/custom_list_cita.dart';
import 'package:inmuno/utils/colors.dart';

class HistorialPersonalPage extends StatelessWidget {
  final String? dni;

  const HistorialPersonalPage({super.key, required this.dni});

  Map<DateTime, Map<String, String>> _filtrarCitas(String? dni) {
    final todasLasCitas = {
      DateTime.utc(2025, 7, 12): {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'dni': '12345678',
        'vacuna': 'INFLUENZA',
        'hora': '09:00 AM',
        'observaciones':
            'Presentarse en ayunas. Llevar carnet de vacunación actualizado.',
        'medico': 'DR. LUIS FERNANDO PAREDES',
        'estado': 'Pendiente',
      },
      DateTime.utc(2025, 7, 14): {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'dni': '12345678',
        'vacuna': 'COVID 19',
        'hora': '12:30 PM',
        'observaciones': 'Traer inyección de remdesivir y suero.',
        'medico': 'SAYURI CUSTODIO',
        'estado': 'Pendiente',
      },
      DateTime.utc(2025, 8, 5): {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'dni': '12345678',
        'vacuna': 'TÉTANOS',
        'hora': '11:45 AM',
        'observaciones': 'Confirmar asistencia con 1 día de anticipación.',
        'medico': 'DR. HÉCTOR MANSILLA',
        'estado': 'Reprogramado',
      },
    };

    return Map.fromEntries(
      todasLasCitas.entries.where((entry) => entry.value['dni'] == dni),
    );
  }

  @override
  Widget build(BuildContext context) {
    final citasFiltradas = _filtrarCitas(dni);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.person_pin_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Mis Citas Médicas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: CustomListCita(citas: citasFiltradas),
    );
  }
}
