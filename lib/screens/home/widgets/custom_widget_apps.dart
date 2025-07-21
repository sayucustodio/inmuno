import 'package:flutter/material.dart';
import 'package:inmuno/utils/colors.dart';

class AccesosDirectosWidget extends StatelessWidget {
  final VoidCallback onAgendar;
  final VoidCallback onHistorial;
  final VoidCallback onResultados;

  const AccesosDirectosWidget({
    super.key,
    required this.onAgendar,
    required this.onHistorial,
    required this.onResultados,
  });

  Widget _buildAcceso({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double width,
  }) {
    return _AnimatedButton(
      icon: icon,
      label: label,
      onTap: onTap,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'Accesos directos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final buttonWidth = (constraints.maxWidth - 24) / 3;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildAcceso(
                    icon: Icons.event_available_outlined,
                    label: 'Agendar\nvacunación',
                    onTap: onAgendar,
                    width: buttonWidth,
                  ),
                  _buildAcceso(
                    icon: Icons.access_time_outlined,
                    label: 'Historial de\nvacunas',
                    onTap: onHistorial,
                    width: buttonWidth,
                  ),
                  _buildAcceso(
                    icon: Icons.bar_chart_outlined,
                    label: 'Resultados\nGenerales',
                    onTap: onResultados,
                    width: buttonWidth,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double width;

  const _AnimatedButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.width,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails _) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: _scale),
      duration: const Duration(milliseconds: 100),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 1,
            child: InkWell(
              onTap: widget.onTap,
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: widget.width,
                height: widget.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon,
                          size: 36, color: AppColors.primaryGreen),
                      const SizedBox(height: 10),
                      Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
