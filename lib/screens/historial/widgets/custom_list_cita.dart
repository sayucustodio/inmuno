import 'package:flutter/material.dart';
import 'package:inmuno/screens/historial/widgets/cita_card.dart';
import 'package:inmuno/utils/colors.dart';

class CustomListCita extends StatefulWidget {
  final Map<DateTime, Map<String, String>> citas;

  const CustomListCita({super.key, required this.citas});

  @override
  State<CustomListCita> createState() => _CustomListCitaState();
}

class _CustomListCitaState extends State<CustomListCita> {
  String filtroTexto = '';
  String? filtroEstado;

  final List<String> estados = [
    'Finalizado',
    'Pendiente',
    'Cancelado',
    'Reprogramado',
  ];

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
    final sortedEntries = widget.citas.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    final filtradas = sortedEntries.where((entry) {
      final values = entry.value.values.join(' ').toLowerCase();
      final estado = entry.value['estado']?.toLowerCase() ?? '';
      return values.contains(filtroTexto.toLowerCase()) &&
          (filtroEstado == null || estado == filtroEstado!.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por vacuna o medico',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            onChanged: (value) {
              setState(() {
                filtroTexto = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: filtroEstado,
              isExpanded: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.filter_list, size: 20, color: Colors.black54),
                hintText: 'Todos los estados',
                hintStyle: TextStyle(fontSize: 14, color: Colors.black87),
                border: InputBorder.none,
              ),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              items: [
                const DropdownMenuItem(
                    value: null, child: Text('Todos los estados')),
                ...estados.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )),
              ],
              onChanged: (value) {
                setState(() {
                  filtroEstado = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: filtradas.isEmpty
              ? const Center(child: Text('No se encontraron citas.'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtradas.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final entry = filtradas[index];
                    final date = entry.key;
                    final cita = entry.value;

                    return CitaCard(fecha: date, cita: cita);
                  },
                ),
        ),
      ],
    );
  }
}
