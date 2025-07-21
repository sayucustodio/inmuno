import 'package:flutter/material.dart';
import 'package:inmuno/screens/citas/widgets/card_tarjeta_vacunacion.dart';
import 'package:inmuno/screens/citas/widgets/dropdown_hijo_selector.dart';
import 'package:inmuno/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/models/hijo_model.dart';
import 'package:inmuno/screens/citas/asign_medico.dart';
import 'widgets/card_selector_paciente.dart';

class AgendarPage extends StatefulWidget {
  const AgendarPage({super.key});

  @override
  State<AgendarPage> createState() => _AgendarPageState();
}

class _AgendarPageState extends State<AgendarPage> {
  HijoConDetalleModel? hijoSeleccionado;

  void irAResumen() {
    if (hijoSeleccionado == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumenCitaPage(
          paciente: {
            'nombre':
                '${hijoSeleccionado!.nombres} ${hijoSeleccionado!.apellidoPaterno} ${hijoSeleccionado!.apellidoMaterno}',
            'fecha_nacimiento': hijoSeleccionado!.fechaNacimiento,
            'imagen': hijoSeleccionado!.imagen,
            'ultimaCita':
                hijoSeleccionado!.ultimaCita?.toString().split(' ')[0] ??
                    'Sin registros',
          },
          vacunasSeleccionadas: const [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hijosProvider = Provider.of<HijosProvider>(context);
    final hijos = hijosProvider.hijos;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
            Color(0xFFE5FBE5), // Verde claro solo al fondo
          ],
          stops: [0.0, 0.85, 1.0], // 👈 85% blanco, 15% verde
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // 👈 importante
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Agendar Cita',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            if (hijoSeleccionado != null)
              IconButton(
                icon: const Icon(Icons.navigate_next, color: Colors.white),
                tooltip: 'Siguiente',
                onPressed: irAResumen,
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardSelectorPaciente(
                dropdown: DropdownHijoSelector(
                  hijos: hijos,
                  hijoSeleccionado: hijoSeleccionado,
                  onChanged: (hijo) {
                    setState(() {
                      hijoSeleccionado = hijo;
                    });
                  },
                ),
                onRegistrar: () {
                  print("Registrar nuevo hijo");
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Vacunación por Edad',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDECEF),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text(
                      'Esquema Nacional',
                      style: TextStyle(fontSize: 12, color: Colors.pink),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: hijoSeleccionado != null
                      ? ListaTarjetasVacunacion(
                          edadEnMeses: RolUtils.calcularEdadEnMeses(
                              hijoSeleccionado!.fechaNacimiento),
                        )
                      : const Center(
                          child:
                              Text('Selecciona un hijo para ver sus vacunas'),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
