import 'package:flutter/material.dart';

class AppColors {
  // Verde principal
  static const Color primaryGreen = Color(0xFF00C896);

  // Variantes de verde
  static const Color greenLight = Color(0xFFC8E6C9);
  static const Color greenMedium = Color(0xFF81C784);
  static const Color greenDark = Color(0xFF388E3C);
  static const Color greenAccent = Color(0xFF69F0AE);
  static const Color greenSuccess = Color(0xFF2E7D32);
  static const Color greenBackground = Color(0xFFE8F5E9);

  // Fondo blanco
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  // Texto
  static const Color darkText = Color(0xFF212121);
  static const Color mediumText = Color(0xFF424242);
  static const Color lightText = Color(0xFF757575);
  static const Color disabledText = Color(0xFF9E9E9E);

  // Negro y gris oscuro
  static const Color black = Color(0xFF000000);
  static const Color black87 = Color(0xDD000000); // para textos principales
  static const Color black54 = Color(0x8A000000); // para textos secundarios
  static const Color black12 = Color(0x1F000000); // para bordes

  // Estados de citas
  static const Color estadoFinalizado =
      Color(0xFF00C896); // Igual a primaryGreen
  static const Color estadoPendiente = Color(0xFFFFA726); // Naranja medio
  static const Color estadoCancelado =
      Color(0xFFD32F2F); // Rojo fuerte (igual a errorRed)
  static const Color estadoReprogramado = Color(0xFF607D8B); // Azul grisáceo

  //Encabezado
  static const List<Color> encabezado = [
    Color(0xFF00C896),
    Color(0xFF00B4A4),
  ];

// Azules adicionales
  static const Color blueLight = Color(0xFFBBDEFB);
  static const Color blue = Color(0xFF2196F3);
  static const Color blueDark = Color(0xFF1976D2);

// Amarillos
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color amber = Color(0xFFFFC107);

// Fondo gris claro
  static const Color backgroundGray = Color(0xFFF5F5F5);
  // Colores para tarjetas de vacunación por rango
  static const Color tarjetaRosa1 = Color(0xFFF670A7);
  static const Color tarjetaRosa2 = Color(0xFFF94374);

  static const Color tarjetaAzul1 = Color(0xFF56CCF2);
  static const Color tarjetaAzul2 = Color(0xFF2F80ED);

  static const Color tarjetaMorado1 = Color(0xFF9B51E0);
  static const Color tarjetaMorado2 = Color(0xFFBB6BD9);

  static const Color tarjetaVerde1 = Color(0xFF00B894);
  static const Color tarjetaVerde2 = Color(0xFF00CEC9);

  static const Color tarjetaAmarilla1 = Color(0xFFFDCB6E);
  static const Color tarjetaAmarilla2 = Color(0xFFE17055);

  // Otros
  static const Color borderGray = Color(0xFFBDBDBD);
  static const Color errorRed = Color(0xFFD32F2F);

  static const List<Color> fondoDifuminado = [
    Colors.white,
    Colors.white70,
    Color.fromARGB(255, 139, 205, 187),
  ];
}
