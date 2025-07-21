import 'package:flutter/material.dart';
import 'package:inmuno/screens/historial/widgets/custom_detail_cita.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, String>>> _citas = {
    DateTime.utc(2025, 7, 14): [
      {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'vacuna': 'COVID 19',
        'dni': '74250233',
        'hora': '12:30 PM',
        'observaciones':
            'Traer inyección de remdesivir y a su menor hijo en ayunas. Llegar 10 minutos antes.',
        'medico': 'SAYURI CUSTODIO',
        'estado': 'Pendiente',
      },
      {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'vacuna': 'TÉTANOS',
        'dni': '74250233',
        'hora': '04:00 PM',
        'observaciones': 'Confirmar asistencia al llegar.',
        'medico': 'DRA. MARÍA PÉREZ',
        'estado': 'Pendiente',
      },
    ],
    DateTime.utc(2025, 7, 12): [
      {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'vacuna': 'INFLUENZA',
        'dni': '74250233',
        'hora': '09:00 AM',
        'observaciones':
            'Presentarse en ayunas. Llevar carnet de vacunación actualizado.',
        'medico': 'DR. LUIS FERNANDO PAREDES',
        'estado': 'Finalizado',
      },
    ],
    DateTime.utc(2025, 7, 20): [
      {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'vacuna': 'VPH',
        'dni': '74250233',
        'hora': '03:15 PM',
        'observaciones': 'Evitar alimentos grasos antes de la cita.',
        'medico': 'DRA. KARINA MENDOZA',
        'estado': 'Cancelado',
      },
    ],
    DateTime.utc(2025, 8, 5): [
      {
        'paciente': 'RODRIGO JORGE GARCIA TREJO',
        'vacuna': 'TÉTANOS',
        'dni': '74250233',
        'hora': '11:45 AM',
        'observaciones': 'Confirmar asistencia con 1 día de anticipación.',
        'medico': 'DR. HÉCTOR MANSILLA',
        'estado': 'Reprogramado',
      },
    ],
  };

  DateTime _normalizeDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  String _capitalize(String text) =>
      text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1)}' : '';

  @override
  Widget build(BuildContext context) {
    return Column(
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
            return _citas[normalizedDay] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              final normalizedDay = _normalizeDate(date);
              final citas = _citas[normalizedDay];
              if (citas != null && citas.isNotEmpty) {
                final color = _estadoColor(citas.first['estado'] ?? '');
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
              final citas = _citas[_normalizeDate(date)];
              final color = citas != null && citas.isNotEmpty
                  ? _estadoColor(citas.first['estado'] ?? '')
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
            todayDecoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            markerDecoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
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
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                if (_selectedDay != null &&
                    _citas.containsKey(_normalizeDate(_selectedDay!)))
                  ..._citas[_normalizeDate(_selectedDay!)]!
                      .map((cita) => CustomDetalleCita(cita: cita))
                      .toList()
                else
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No hay citas para este día.'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
        return AppColors.estadoReprogramado;
    }
  }
}
