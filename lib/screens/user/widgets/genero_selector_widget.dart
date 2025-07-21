import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final IconData icon;
  final String label;
  final T? value;
  final List<T> options;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const CustomDropdownField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryGreen, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            value: value,
            onChanged: onChanged,
            validator: validator,
            iconEnabledColor: AppColors.primaryGreen,
            dropdownColor: Colors.white, // 🔹 Fondo blanco del menú desplegable
            items: options.map((option) {
              return DropdownMenuItem<T>(
                value: option,
                child: Row(
                  children: [
                    Icon(
                      option == 'M' ? Icons.male : Icons.female,
                      color: AppColors.primaryGreen,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      option == 'M' ? 'Masculino' : 'Femenino',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryGreen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
