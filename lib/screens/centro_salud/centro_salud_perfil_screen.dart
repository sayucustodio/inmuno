import 'package:flutter/material.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/screens/perfil/widgets/perfil_build_input.dart';
import 'package:provider/provider.dart';

class ClinicaPerfilCard extends StatelessWidget {
  const ClinicaPerfilCard({super.key});

  @override
  Widget build(BuildContext context) {
    final centroSalud = Provider.of<CentroSaludProvider>(context).centrosalud;

    if (centroSalud == null) {
      return const SizedBox(); // Oculta si no hay centro asignado
    }

    final inputs = [
      PerfilBuildInput.buildInput(
        'Nombre del centro',
        centroSalud.nombre,
        icon: Icons.local_hospital_outlined,
      ),
      PerfilBuildInput.buildInput(
        'Tipo',
        centroSalud.tipo,
        icon: Icons.category_outlined,
      ),
      if (centroSalud.ruc?.isNotEmpty == true)
        PerfilBuildInput.buildInput(
          'RUC',
          centroSalud.ruc!,
          icon: Icons.receipt_outlined,
        ),
      PerfilBuildInput.buildInput(
        'Dirección',
        centroSalud.direccion,
        icon: Icons.location_on_outlined,
      ),
      if (centroSalud.telefono?.isNotEmpty == true)
        PerfilBuildInput.buildInput(
          'Teléfono',
          centroSalud.telefono!,
          icon: Icons.phone_outlined,
        ),
      if (centroSalud.correo?.isNotEmpty == true)
        PerfilBuildInput.buildInput(
          'Correo electrónico',
          centroSalud.correo!,
          icon: Icons.email_outlined,
        ),
      if (centroSalud.web?.isNotEmpty == true)
        PerfilBuildInput.buildInput(
          'Sitio web',
          centroSalud.web!,
          icon: Icons.language_outlined,
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.local_hospital_outlined,
                      size: 18, color: Colors.teal),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Información de la Clínica',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...inputs,
            ],
          ),
        ),
      ),
    );
  }
}
