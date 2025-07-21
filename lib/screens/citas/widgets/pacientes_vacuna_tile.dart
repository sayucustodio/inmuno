import 'package:flutter/material.dart';
import 'package:inmuno/screens/citas/widgets/dialog_alert.dart';

class PacienteVacunasTile extends StatelessWidget {
  final Map<String, dynamic> hijo;
  final List<Map<String, dynamic>> vacunas;
  final Map<String, Set<String>> vacunasSeleccionadasPorHijo;
  final VoidCallback? onChanged;

  const PacienteVacunasTile(
      {super.key,
      required this.hijo,
      required this.vacunas,
      required this.vacunasSeleccionadasPorHijo,
      required this.onChanged});

  int calcularEdadEnMeses(DateTime nacimiento) {
    final ahora = DateTime.now();
    return (ahora.year - nacimiento.year) * 12 +
        (ahora.month - nacimiento.month);
  }

  List<Map<String, dynamic>> vacunasParaEdad(int edadMeses) {
    return vacunas.where((vacuna) {
      final edades = vacuna['EdadRecomendadaMeses'] as List<dynamic>;
      return edades.any((mes) => edadMeses >= mes);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final nombreHijo = hijo['nombre'];
    final fechaNacimiento = hijo['fecha_nacimiento'] as DateTime;
    final edadMeses = calcularEdadEnMeses(fechaNacimiento);
    final edadTexto = '${edadMeses ~/ 12} años y ${edadMeses % 12} meses';
    final vacunasRecomendadas = vacunasParaEdad(edadMeses);

    vacunasSeleccionadasPorHijo.putIfAbsent(nombreHijo, () => {});

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(hijo['imagen']),
          radius: 24,
        ),
        title: Text(
          nombreHijo,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          'Edad: $edadTexto',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        children: vacunasRecomendadas.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No hay vacunas recomendadas para esta edad.'),
                )
              ]
            : vacunasRecomendadas.map((vacuna) {
                final vacunaId = vacuna['Id'];
                final seleccionadas = vacunasSeleccionadasPorHijo[nombreHijo]!;
                final edadesTexto = (vacuna['EdadRecomendadaMeses'] as List)
                    .map((e) => '$e meses')
                    .join(', ');

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: seleccionadas.contains(vacunaId),
                        onChanged: (value) {
                          if (value == true && seleccionadas.isNotEmpty) {
                            dialogShowCustom(context,
                                'Solo puedes seleccionar una de las dosis');
                            return;
                          }

                          if (value != null) {
                            if (value) {
                              seleccionadas
                                ..clear()
                                ..add(vacunaId);
                            } else {
                              seleccionadas.remove(vacunaId);
                            }
                          }

                          if (onChanged != null) {
                            onChanged!();
                          }
                        },
                        activeColor: Colors.teal,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  vacuna['Nombre'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              vacuna['Descripcion'],
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Edad recomendada: $edadesTexto',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}
