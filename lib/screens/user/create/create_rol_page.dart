import 'package:flutter/material.dart';
import 'package:inmuno/screens/user/create/create_personaldata_page.dart';
import 'package:inmuno/screens/user/widgets/card_rol_widget.dart';

import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/widgets/custom_circle_container.dart';

class SeleccionRolPage extends StatelessWidget {
  const SeleccionRolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.encabezado,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 56, top: 10),
                    child: Text(
                      'Selecciona tu rol',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 56, right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            minHeight: 4,
                            value: 0.33,
                            backgroundColor: Colors.white24,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.fondoDifuminado,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CircleGradientIcon(icon: Icons.favorite),
              const SizedBox(height: 16),
              const Text(
                '¡Bienvenido!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona tu rol para acceder a las funciones más relevantes para ti.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              CardRolWidget(
                icon: Icons.family_restroom,
                iconColor: Colors.blueAccent,
                title: 'Padre de familia',
                subtitle: 'Gestiona la salud y bienestar de tu familia',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DniInputPage(rolId: 3)),
                  );
                },
              ),
              const SizedBox(height: 16),
              CardRolWidget(
                icon: Icons.medical_services,
                iconColor: Colors.green,
                title: 'Personal de salud',
                subtitle: 'Brinda atención médica profesional',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DniInputPage(rolId: 2)),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
