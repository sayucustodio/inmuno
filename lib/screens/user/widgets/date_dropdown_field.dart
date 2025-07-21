import 'package:flutter/material.dart';

class FechaNacimientoTile extends StatelessWidget {
  final DateTime? fecha;
  final VoidCallback onSeleccionar;
  final bool mostrarError;

  const FechaNacimientoTile({
    super.key,
    required this.fecha,
    required this.onSeleccionar,
    required this.mostrarError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_today),
          title: Text(
            fecha == null
                ? 'Seleccionar fecha de nacimiento'
                : '${fecha!.toLocal()}'.split(' ')[0],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit_calendar),
            onPressed: onSeleccionar,
          ),
        ),
        if (mostrarError)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Debe seleccionar una fecha de nacimiento',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
