import 'package:flutter/material.dart';

class CustomPerfilListTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;

  const CustomPerfilListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      leading: leading,
      title: Text(title),
      onTap: onTap,
    );
  }
}
