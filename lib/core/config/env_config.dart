import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get woocommerceUrl => dotenv.env['WOOCOMMERCE_URL'] ?? '';
  static String get consumerKey => dotenv.env['WOOCOMMERCE_CONSUMER_KEY'] ?? '';
  static String get consumerSecret => dotenv.env['WOOCOMMERCE_CONSUMER_SECRET'] ?? '';
  static String get apiVersion => dotenv.env['API_VERSION'] ?? 'wc/v3';

  static bool get isConfigured =>
      woocommerceUrl.isNotEmpty &&
      consumerKey.isNotEmpty &&
      consumerSecret.isNotEmpty;

  static String get baseUrl => '$woocommerceUrl/wp-json/$apiVersion';
}
