import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class CardParental extends StatelessWidget {
  final String nombre;
  final String dni;
  final String estatura;
  final String peso;
  final String edad;
  final String ultimaCita;
  final String imagenUrl;
  final String genero;
  final VoidCallback? onVerHistorial;

  const CardParental({
    super.key,
    required this.nombre,
    required this.dni,
    required this.estatura,
    required this.peso,
    required this.edad,
    required this.ultimaCita,
    required this.imagenUrl,
    required this.genero,
    this.onVerHistorial,
  });

  @override
  Widget build(BuildContext context) {
    final bool esFemenino = genero == 'femenino';

    final Color colorFondo =
        esFemenino ? const Color(0xFFF06595) : AppColors.primaryGreen;
    final Color botonColor =
        esFemenino ? const Color(0xFFF06595) : AppColors.primaryGreen;

    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imagenUrl),
                radius: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorFondo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorFondo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Paciente',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorFondo,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.badge, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          dni,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoBox(Icons.height, 'Estatura', estatura,
                    const Color(0xFFEEF2FF)),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _infoBox(Icons.monitor_weight, 'Peso', peso,
                    const Color(0xFFE8F6EF)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child:
                    _infoBox(Icons.cake, 'Edad', edad, const Color(0xFFF4F0FF)),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _infoBox(Icons.event, 'Última cita', ultimaCita,
                    const Color(0xFFFFF5E6)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onVerHistorial,
              icon: const Icon(Icons.remove_red_eye, size: 16),
              label: const Text('Ver historial médico completo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: botonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                textStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(IconData icon, String label, String value, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.black54),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(fontSize: 10, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
