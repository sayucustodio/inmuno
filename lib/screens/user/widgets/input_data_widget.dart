import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class CustomInputTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? maxLength;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;

  const CustomInputTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.subtitle,
    this.inputType,
    this.maxLength,
    this.errorText,
    this.validator,
    this.onChanged,
    this.hintText,
    this.isPassword = false,
  });

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: AppColors.primaryGreen, size: 16),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (widget.subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 22),
              child: Text(
                widget.subtitle!,
                style: const TextStyle(fontSize: 12.5, color: Colors.black54),
              ),
            ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            maxLength: widget.maxLength,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              counterText: "",
              hintText: widget.hintText ?? 'Ingrese ${widget.label}',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              errorText: widget.errorText,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryGreen),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    )
                  : widget.errorText != null
                      ? const Icon(Icons.warning_amber_rounded,
                          color: Colors.redAccent, size: 20)
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
