import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class CircleGradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const CircleGradientIcon({
    super.key,
    required this.icon,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: AppColors.encabezado,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}
