import 'package:flutter/material.dart';
import 'package:inmuno/data/models/centro_salud_model.dart';

class CentroSaludCard extends StatelessWidget {
  final CentroSaludModel centro;
  final double? distanciaKm;
  final VoidCallback? onTap;

  const CentroSaludCard({
    super.key,
    required this.centro,
    this.distanciaKm,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPrivado = centro.tipo.toLowerCase().contains('priv');
    final isPublico = centro.tipo.toLowerCase().contains('públic') ||
        centro.tipo.toLowerCase().contains('centro') ||
        centro.tipo.toLowerCase().contains('hospital');

    final Color badgeColor = isPrivado
        ? const Color(0xFFE7F0FF)
        : isPublico
            ? const Color(0xFFE2F7EA)
            : Colors.grey.shade200;

    final Color iconColor = isPrivado
        ? const Color(0xFF3973E8)
        : isPublico
            ? const Color(0xFF00B894)
            : Colors.grey;

    final Color borderColor = isPrivado
        ? const Color(0xFFB8D2FF)
        : isPublico
            ? const Color(0xFF9CE8C4)
            : Colors.grey.shade300;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildIconTipo(iconColor),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isPrivado ? 'Privada' : 'Pública',
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              centro.nombre,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${centro.direccion}${_formatearUbicacion(centro)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTipo(Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.local_hospital, size: 20, color: color),
    );
  }

  String _formatearUbicacion(CentroSaludModel c) {
    final partes = [c.distrito, c.provincia]
        .where((p) => p != null && p.isNotEmpty)
        .toList();
    return partes.isNotEmpty ? ', ${partes.join(', ')}' : '';
  }
}
