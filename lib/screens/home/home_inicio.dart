import 'package:flutter/material.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/screens/citas/citas_screen.dart';
import 'package:inmuno/screens/historial/family_historial/historial_personal_screen.dart';
import 'package:inmuno/screens/home/widgets/listile_parental_control.dart';
import 'package:inmuno/screens/home/widgets/resumen_cita_card.dart';
import 'package:inmuno/screens/home/widgets/custom_widget_apps.dart';
import 'package:inmuno/utils/functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/usuario_model.dart';

class InicioPage extends StatelessWidget {
  final UsuarioModel usuario;

  const InicioPage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final persona = Provider.of<PersonaProvider>(context).persona;

    final Map<DateTime, List<Map<String, String>>> citas = {
      DateTime.utc(2025, 7, 12): [
        {
          'paciente': 'SAYURI CUSTODIO ARROYO',
          'vacuna': 'INFLUENZA',
          'hora': '09:00 AM',
          'observaciones':
              'Presentarse en ayunas. Llevar carnet de vacunación actualizado.',
          'medico': 'DR. LUIS FERNANDO PAREDES',
          'estado': 'Pendiente',
        },
      ],
    };

    DateTime hoy = DateTime.now();
    DateTime hoyNormalizado = DateTime.utc(hoy.year, hoy.month, hoy.day);

    final citasDeHoy = citas[hoyNormalizado];
    final citaHoy =
        (citasDeHoy != null && citasDeHoy.isNotEmpty) ? citasDeHoy.first : null;

    String? proximaCita;
    if (citaHoy != null) {
      final fechaFormateada =
          DateFormat('d MMMM yyyy', 'es_ES').format(hoyNormalizado);
      final hora = citaHoy['hora'] ?? '';
      proximaCita = '$hora - $fechaFormateada';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResumenCitaCard(
            nombreUsuario: RolUtils.obtenerNombreCompleto(
              nombres: persona?.nombres,
              apellidoPaterno: persona?.apellidoPaterno,
              apellidoMaterno: persona?.apellidoMaterno,
            ),
            proximaCita: proximaCita,
            vacuna: citaHoy?['vacuna'],
            onVerCalendario: () {
              Navigator.pushNamed(context, '/historial');
            },
            onAgendarCita: () {
              Navigator.pushNamed(context, '/agendar');
            },
          ),
          const SizedBox(height: 10),
          AccesosDirectosWidget(
            onAgendar: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgendarPage()),
              ).then((_) {
                Provider.of<HijosProvider>(context, listen: false)
                    .updateHijos(usuario.id);
              });
            },
            onHistorial: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      HistorialPersonalPage(dni: persona?.dni ?? ''),
                ),
              );
            },
            onResultados: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ver resultados')),
              );
            },
          ),
          const SizedBox(height: 5),
          if (usuario.rolId == 3) ControlParentalList(usuarioId: usuario.id),
        ],
      ),
    );
  }
}
