import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inmuno/utils/colors.dart';

class ResumenCitaCard extends StatelessWidget {
  final String nombreUsuario;
  final String? proximaCita;
  final String? vacuna;
  final String? medico;
  final String? hora;
  final VoidCallback onVerCalendario;
  final VoidCallback onAgendarCita;

  const ResumenCitaCard({
    super.key,
    required this.nombreUsuario,
    required this.onVerCalendario,
    required this.onAgendarCita,
    this.proximaCita,
    this.vacuna,
    this.medico,
    this.hora,
  });

  @override
  Widget build(BuildContext context) {
    final tieneCita = proximaCita != null && proximaCita!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(0),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '¡Hola, $nombreUsuario!',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            tieneCita
                ? 'Tu próxima cita de vacunación es:'
                : 'Su próxima cita de vacunación es:',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 40),
                Center(
                  child: SvgPicture.asset(
                    tieneCita
                        ? 'assets/svg/ic_calendar_user.svg'
                        : 'assets/svg/ic_calendar_inmuno.svg',
                    height: 90,
                    width: 90,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: tieneCita
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proximaCita!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (vacuna != null)
                              Text(
                                '💉 Vacuna: $vacuna',
                                style: const TextStyle(fontSize: 13),
                              ),
                            if (medico != null)
                              Text(
                                '👨‍⚕️ Médico: $medico',
                                style: const TextStyle(fontSize: 13),
                              ),
                            if (hora != null)
                              Text(
                                '🕒 Hora: $hora',
                                style: const TextStyle(fontSize: 13),
                              ),
                            const SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: onVerCalendario,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                elevation: 0,
                                minimumSize: const Size(0, 36),
                              ),
                              child: const Text('Ver calendario',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Todavía no tienes citas',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: onAgendarCita,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                elevation: 0,
                                minimumSize: const Size(0, 36),
                              ),
                              child: const Text('Agendar cita',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
