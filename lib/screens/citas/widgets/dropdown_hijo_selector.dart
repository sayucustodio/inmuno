import 'package:flutter/material.dart';
import 'package:inmuno/data/models/hijo_model.dart';
import 'package:inmuno/utils/functions.dart'; // Donde esté RolUtils

class DropdownHijoSelector extends StatelessWidget {
  final List<HijoConDetalleModel> hijos;
  final HijoConDetalleModel? hijoSeleccionado;
  final void Function(HijoConDetalleModel?) onChanged;

  const DropdownHijoSelector({
    super.key,
    required this.hijos,
    required this.hijoSeleccionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<HijoConDetalleModel>(
          isExpanded: true,
          value: hijos.contains(hijoSeleccionado) ? hijoSeleccionado : null,
          items: hijos.map((hijo) {
            final edadMeses =
                RolUtils.calcularEdadEnMeses(hijo.fechaNacimiento);
            final edadFormateada = RolUtils.obtenerEdadFormateada(edadMeses);

            return DropdownMenuItem<HijoConDetalleModel>(
              value: hijo,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(hijo.imagen),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${hijo.nombres} ${hijo.apellidoPaterno} ($edadFormateada)",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          dropdownColor: Colors.white,
          menuMaxHeight: 250, // ⬅️ Limita la altura del dropdown
        ),
      ),
    );
  }
}
