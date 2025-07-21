import 'package:flutter/material.dart';
import 'package:inmuno/screens/user/widgets/formulario_dni_widget.dart';
import 'package:inmuno/screens/user/widgets/header_widget.dart';
import 'package:inmuno/widgets/custom_circle_container.dart';

class DniInputPage extends StatelessWidget {
  final int rolId;

  const DniInputPage({super.key, required this.rolId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: HeaderRegistroWidget(),
      ),
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            const CircleGradientIcon(icon: Icons.person),
            const SizedBox(height: 12), // antes: 16
            const Text(
              'Completa tus datos personales',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18), // opcional: reducir fontSize
            ),
            const SizedBox(height: 4), // antes: 8
            const Text(
              'Esta información nos ayudará a personalizar tu experiencia y mantener tu perfil actualizado.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13), // opcional: más compacto
            ),
            const SizedBox(height: 16), // antes: 24
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FormularioDniWidget(rolId: rolId),
            ),
          ],
        ),
      ),
    );
  }
}
