import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class CardSelectorPaciente extends StatelessWidget {
  final Widget dropdown;
  final VoidCallback onRegistrar;

  const CardSelectorPaciente({
    super.key,
    required this.dropdown,
    required this.onRegistrar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: const Border(
          left: BorderSide(color: AppColors.primaryGreen, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.event_available, color: AppColors.primaryGreen),
              SizedBox(width: 10),
              Text(
                'Agendar vacunación para mi hijo/a:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          dropdown,
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: onRegistrar,
            icon: const Icon(Icons.add),
            label: const Text("Registrar nuevo niño/a"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryGreen,
              side: const BorderSide(color: AppColors.primaryGreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
