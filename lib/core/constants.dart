class AppConstants {
  // static const String baseUrl = 'http://192.168.10.96:5177/api';
  static const String baseUrl = 'http://192.168.0.8:5177/api';

  // WhatsApp
  static const String whatsappNumber = '+51934769340'; // sin el +

  static String get whatsappUrl => 'https://wa.me/$whatsappNumber}';

  // Endpoints App
  static const String loginEndpoint = '$baseUrl/auth/login';

  // Header por defecto
  static const Map<String, String> jsonHeaders = {
    'Content-Type': 'application/json',
  };
}
