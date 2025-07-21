import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class RolUtils {
  static String obtenerNombreRol(int? rolId, String? sexo) {
    final genero = (sexo == 'F') ? 'a' : 'o';
    switch (rolId) {
      case 1:
        return 'Administrador';
      case 2:
        return 'Enfermer$genero';
      case 3:
        return sexo == 'F' ? 'Madre de familia' : 'Padre de familia';
      default:
        return 'Perfil Personal';
    }
  }

  static String getGrupoEdad(int edadMeses) {
    if (edadMeses <= 2) return 'Recién Nacido - 2 meses';
    if (edadMeses <= 6) return '2 - 6 meses';
    if (edadMeses <= 11) return '6 - 11 meses';
    if (edadMeses <= 15) return '12 - 15 meses';
    if (edadMeses <= 24) return '16 - 24 meses';
    if (edadMeses <= 48) return '2 - 4 años';
    return '5 años a más';
  }

  static int calcularEdadEnMeses(DateTime? nacimiento) {
    if (nacimiento == null) return 0;
    final ahora = DateTime.now();
    return (ahora.year - nacimiento.year) * 12 +
        (ahora.month - nacimiento.month);
  }

  static String obtenerEdadFormateada(int meses) {
    final anios = meses ~/ 12;
    final restoMeses = meses % 12;

    if (anios == 0) return '$restoMeses meses';
    if (restoMeses == 0) return '$anios años';
    return '$anios años $restoMeses meses';
  }

  static formatFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
  }

  static String obtenerNombreCompleto({
    required String? nombres,
    required String? apellidoPaterno,
    required String? apellidoMaterno,
  }) {
    return [
      nombres?.trim(),
      apellidoPaterno?.trim(),
      apellidoMaterno?.trim(),
    ].where((e) => e != null && e.isNotEmpty).join(' ');
  }
}

class PerfilWidgets {
  static Widget buildInfoCard(String titulo, List<Widget> inputs,
      {IconData icono = Icons.person_outline, VoidCallback? onEdit}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.encabezado,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icono, size: 18, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: inputs),
          ),
        ],
      ),
    );
  }
}
