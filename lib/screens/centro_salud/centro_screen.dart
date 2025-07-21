import 'package:flutter/material.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/screens/centro_salud/centro_salud_perfil_screen.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/widgets/header_perfil_general.dart';
import 'package:provider/provider.dart';

class CentroSaludScreen extends StatelessWidget {
  const CentroSaludScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final centroSalud = Provider.of<CentroSaludProvider>(context).centrosalud;

    final String nombre = centroSalud?.nombre ?? 'Centro de Salud';
    final String tipo = centroSalud?.tipo ?? 'Clínica';

    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.encabezado,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  HeaderPerfilGeneral(
                    icon: Icons.local_hospital,
                    titulo: nombre,
                    subtitulo: tipo,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ClinicaPerfilCard(),
            ),
          ),
        ],
      ),
    );
  }
}
