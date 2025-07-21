import 'package:flutter/material.dart';
import 'package:inmuno/data/models/hijo_model.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/screens/historial/family_historial/historial_family_screen.dart';
import 'package:inmuno/screens/home/widgets/custom_card_parental.dart';
import 'package:inmuno/utils/functions.dart';

class ControlParentalList extends StatefulWidget {
  final int usuarioId;

  const ControlParentalList({super.key, required this.usuarioId});

  @override
  State<ControlParentalList> createState() => _ControlParentalListState();
}

class _ControlParentalListState extends State<ControlParentalList> {
  late Future<List<HijoConDetalleModel>> hijosFuture;

  @override
  void initState() {
    super.initState();
    hijosFuture = PersonaService().getHijosConDetalles(widget.usuarioId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Control parental:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 260,
          child: FutureBuilder<List<HijoConDetalleModel>>(
            future: hijosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final hijos = snapshot.data ?? [];

              if (hijos.isEmpty) {
                return const Center(child: Text('No hay hijos registrados.'));
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hijos.length,
                itemBuilder: (context, index) {
                  final hijo = hijos[index];
                  return CardParental(
                    nombre:
                        '${hijo.nombres} ${hijo.apellidoPaterno} ${hijo.apellidoMaterno}',
                    dni: hijo.dni,
                    estatura: hijo.estatura,
                    peso: hijo.peso,
                    edad: RolUtils.obtenerEdadFormateada(
                      RolUtils.calcularEdadEnMeses(hijo.fechaNacimiento),
                    ),
                    ultimaCita: hijo.ultimaCita != null
                        ? RolUtils.formatFecha(hijo.ultimaCita!)
                        : 'Sin cita',
                    imagenUrl: hijo.imagen,
                    genero: hijo.genero,
                    onVerHistorial: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HistorialFamilyPage(dni: hijo.dni),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
