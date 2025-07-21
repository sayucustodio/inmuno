import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResumenCitaPage extends StatefulWidget {
  final Map<String, dynamic> paciente;
  final List<String> vacunasSeleccionadas;

  const ResumenCitaPage({
    super.key,
    required this.paciente,
    required this.vacunasSeleccionadas,
  });

  @override
  State<ResumenCitaPage> createState() => _ResumenCitaPageState();
}

class _ResumenCitaPageState extends State<ResumenCitaPage> {
  DateTime? fechaSeleccionada;
  String? medicoSeleccionado;

  final List<Map<String, String>> medicos = [
    {
      'nombre': 'Dra. Mónica Salinas',
      'especialidad': 'Pediatra General',
      'telefono': '+51 987 654 321',
      'correo': 'monica.salinas@auna.pe',
      'direccion': 'Consultorio 205 - Piso 2',
      'rating': '4.9',
      'total': '150+',
    },
    {
      'nombre': 'Dr. Luis Mendoza',
      'especialidad': 'Pediatra Neonatal',
      'telefono': '+51 912 345 678',
      'correo': 'luis.mendoza@auna.pe',
      'direccion': 'Consultorio 301 - Piso 3',
      'rating': '4.8',
      'total': '120+',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final paciente = widget.paciente;
    final edad =
        DateTime.now().difference(paciente['fecha_nacimiento']).inDays ~/ 30;
    final edadTexto =
        '${edad ~/ 12} año${edad ~/ 12 == 1 ? '' : 's'} ${edad % 12} mes${edad % 12 == 1 ? '' : 'es'}';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009B72),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirmar Cita',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Revisa y confirma los detalles',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.check_circle_outline, color: Colors.white))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(paciente['imagen']),
                      radius: 30),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(paciente['nombre'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _chip('$edadTexto', Colors.indigo.shade50,
                                Colors.indigo),
                            const SizedBox(width: 6),
                            _chip('Pediátrico', Colors.green.shade50,
                                Colors.green),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Médico Asignado',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_hospital_outlined),
                ),
                items: medicos.map((medico) {
                  return DropdownMenuItem(
                    value: medico['nombre'],
                    child: Text(medico['nombre']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    medicoSeleccionado = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                fechaSeleccionada != null
                    ? DateFormat('dd/MM/yyyy').format(fechaSeleccionada!)
                    : 'Seleccionar fecha',
              ),
              onTap: () async {
                final seleccion = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                  locale: const Locale('es', 'ES'),
                );
                if (seleccion != null) {
                  setState(() {
                    fechaSeleccionada = seleccion;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: (fechaSeleccionada != null && medicoSeleccionado != null)
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('✅ Cita agendada exitosamente')),
                    );
                    Navigator.pop(context);
                  }
                : null,
            icon: const Icon(Icons.check),
            label: const Text('Confirmar cita'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: const Color(0xFF009B72),
              disabledBackgroundColor: Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text,
          style:
              TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}
