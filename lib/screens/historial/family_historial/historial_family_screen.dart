import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/screens/historial/widgets/custom_detail_cita.dart';
import 'package:inmuno/screens/historial/widgets/custom_list_cita.dart';

class HistorialFamilyPage extends StatefulWidget {
  final String dni;

  const HistorialFamilyPage({super.key, required this.dni});

  @override
  State<HistorialFamilyPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialFamilyPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _mostrarLista = false;

  late final Map<DateTime, Map<String, String>> _citasPaciente;

  final Map<DateTime, Map<String, String>> _todasLasCitas = {
    DateTime.utc(2025, 7, 1): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Influenza estacional',
      'hora': '08:00 AM',
      'observaciones': 'Niño debe acudir en ayunas. Llevar carnet.',
      'medico': 'DRA. ROCÍO CHÁVEZ',
      'estado': 'Finalizado',
    },
    DateTime.utc(2025, 7, 3): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Triple viral (SRP)',
      'hora': '09:30 AM',
      'observaciones': 'Verificar fiebre previa. Evitar antigripales.',
      'medico': 'DR. EDUARDO RAMOS',
      'estado': 'Finalizado',
    },
    DateTime.utc(2025, 7, 6): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Poliomielitis (OPV)',
      'hora': '10:00 AM',
      'observaciones': 'Evitar alimentos pesados antes de la cita.',
      'medico': 'DRA. LILIANA GÓMEZ',
      'estado': 'Pendiente',
    },
    DateTime.utc(2025, 7, 9): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Hepatitis A',
      'hora': '11:45 AM',
      'observaciones': 'Confirmar asistencia el día anterior.',
      'medico': 'DR. FERNANDO CARRANZA',
      'estado': 'Pendiente',
    },
    DateTime.utc(2025, 7, 12): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Difteria',
      'hora': '01:00 PM',
      'observaciones': 'Presentarse con adulto responsable.',
      'medico': 'DRA. MARIELA HUERTA',
      'estado': 'Reprogramado',
    },
    DateTime.utc(2025, 7, 15): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Neumococo',
      'hora': '08:30 AM',
      'observaciones':
          'Revisar alergias antes de la dosis y permanecer en reposo durante 2 dias. Traer en ayunas.',
      'medico': 'DR. JORGE SALVATIERRA',
      'estado': 'Cancelado',
    },
    DateTime.utc(2025, 7, 18): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Varicela',
      'hora': '02:00 PM',
      'observaciones': 'Evitar contacto con personas enfermas.',
      'medico': 'DRA. VERÓNICA RIVERA',
      'estado': 'Pendiente',
    },
    DateTime.utc(2025, 7, 22): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Rotavirus',
      'hora': '10:30 AM',
      'observaciones': 'No comer 2 horas antes. Solo líquidos.',
      'medico': 'DR. LUIS ZEGARRA',
      'estado': 'Finalizado',
    },
    DateTime.utc(2025, 7, 26): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'Hepatitis B',
      'hora': '11:15 AM',
      'observaciones': 'Verificar temperatura corporal previa.',
      'medico': 'DRA. MÓNICA PALACIOS',
      'estado': 'Reprogramado',
    },
    DateTime.utc(2025, 7, 30): {
      'paciente': 'JUAN MARCELO RAMIREZ CERNA',
      'dni': '75232113',
      'vacuna': 'COVID-19 pediátrica',
      'hora': '09:00 AM',
      'observaciones': 'Evitar contacto físico post-vacunación.',
      'medico': 'DR. GUSTAVO MORALES',
      'estado': 'Pendiente',
    },
  };

  @override
  void initState() {
    super.initState();
    _citasPaciente = _filtrarCitasPorDNI(widget.dni);
  }

  Map<DateTime, Map<String, String>> _filtrarCitasPorDNI(String dni) {
    return Map.fromEntries(
      _todasLasCitas.entries.where((entry) => entry.value['dni'] == dni),
    );
  }

  DateTime _normalizeDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  String _capitalize(String text) =>
      text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1)}' : '';

  Color _estadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'finalizado':
        return AppColors.estadoFinalizado;
      case 'pendiente':
        return AppColors.estadoPendiente;
      case 'cancelado':
        return AppColors.estadoCancelado;
      case 'reprogramado':
        return AppColors.estadoReprogramado;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Icon(Icons.medical_services_rounded, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'Historial de Vacunación',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() => _mostrarLista = !_mostrarLista);
              },
              icon: Icon(
                _mostrarLista ? Icons.calendar_today : Icons.list_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: _mostrarLista
          ? CustomListCita(citas: _citasPaciente)
          : Column(
              children: [
                TableCalendar(
                  locale: 'es_ES',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _selectedDay = null;
                    });
                  },
                  eventLoader: (day) {
                    final normalizedDay = _normalizeDate(day);
                    return _citasPaciente.containsKey(normalizedDay) ? [1] : [];
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      final cita = _citasPaciente[_normalizeDate(date)];
                      if (cita != null) {
                        final color = _estadoColor(cita['estado'] ?? '');
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    selectedBuilder: (context, date, _) {
                      final cita = _citasPaciente[_normalizeDate(date)];
                      final color = cita != null
                          ? _estadoColor(cita['estado'] ?? '')
                          : Colors.green;
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    markerDecoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    markersAlignment: Alignment.bottomCenter,
                    markersMaxCount: 1,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextFormatter: (date, locale) {
                      final month = DateFormat.MMMM(locale).format(date);
                      return '${_capitalize(month)} ${date.year}';
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (_selectedDay != null &&
                    _citasPaciente.containsKey(_normalizeDate(_selectedDay!)))
                  CustomDetalleCita(
                    cita: _citasPaciente[_normalizeDate(_selectedDay!)]!,
                  )
                else
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No hay citas para este día.'),
                  ),
              ],
            ),
    );
  }
}
