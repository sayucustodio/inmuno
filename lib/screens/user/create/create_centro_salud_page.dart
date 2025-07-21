import 'package:flutter/material.dart';
import 'package:inmuno/data/models/centro_salud_model.dart';
import 'package:inmuno/data/services/centrosalud_services.dart';
import 'package:inmuno/screens/user/widgets/card_centro_salud.dart';
import 'package:inmuno/screens/user/widgets/header_widget.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/widgets/custom_search.dart';
import 'create_user_page.dart';

class SeleccionarCentroSaludPage extends StatefulWidget {
  final Map<String, dynamic> datosPersona;

  const SeleccionarCentroSaludPage({super.key, required this.datosPersona});

  @override
  State<SeleccionarCentroSaludPage> createState() =>
      _SeleccionarCentroSaludPageState();
}

class _SeleccionarCentroSaludPageState
    extends State<SeleccionarCentroSaludPage> {
  late Future<List<CentroSaludModel>> _centrosFuture;
  String filtro = "Todos";
  String query = '';

  @override
  void initState() {
    super.initState();
    _centrosFuture = CentroSaludService().listarCentrosSalud();
  }

  void _seleccionarCentro(CentroSaludModel centro) {
    final nuevosDatos = Map<String, dynamic>.from(widget.datosPersona);
    nuevosDatos['centroSaludId'] = centro.id;

    print(
        '📍 Centro de salud seleccionado: ${centro.nombre} (ID: ${centro.id})');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistroDatosUsuarioPage(datosPersona: nuevosDatos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HeaderClinicaWidget(),
      ),
      body: FutureBuilder<List<CentroSaludModel>>(
        future: _centrosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error al cargar centros: ${snapshot.error}'));
          }

          var centros = snapshot.data ?? [];

          centros = centros.where((c) {
            final matchNombre =
                c.nombre.toLowerCase().contains(query.toLowerCase());
            final matchTipo = filtro == "Todos" ||
                c.tipo.toLowerCase() == filtro.toLowerCase();
            return matchNombre && matchTipo;
          }).toList();

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.encabezado,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchInput(
                      hintText: 'Buscar clínica...',
                      onChanged: (value) => setState(() => query = value),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ["Todos", "Privada", "Pública"]
                            .map(
                              (tipo) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: filtro == tipo
                                        ? Colors.white
                                        : Colors.transparent,
                                    side: BorderSide(
                                      color: filtro == tipo
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                  ),
                                  onPressed: () =>
                                      setState(() => filtro = tipo),
                                  child: Row(
                                    children: [
                                      if (filtro == tipo)
                                        const Icon(Icons.check,
                                            size: 16, color: Colors.green),
                                      if (filtro == tipo)
                                        const SizedBox(width: 4),
                                      Text(
                                        tipo,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: filtro == tipo
                                              ? Colors.green.shade700
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: centros.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 2),
                  itemBuilder: (context, index) {
                    final centro = centros[index];

                    return CentroSaludCard(
                      centro: centro,
                      onTap: () => _seleccionarCentro(centro),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
