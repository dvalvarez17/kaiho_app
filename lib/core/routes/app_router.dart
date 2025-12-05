import 'package:go_router/go_router.dart';
import 'package:kaiho_app/features/auth/presentation/pages/login_page.dart';
import 'package:kaiho_app/features/auth/presentation/pages/register_page.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/presentation/pages/cart_page.dart';
import 'package:kaiho_app/features/products/presentation/pages/favorites_page.dart';
import 'package:kaiho_app/features/products/presentation/pages/home_page.dart';
import 'package:kaiho_app/features/products/presentation/pages/product_detail_page.dart';
import 'package:kaiho_app/features/products/presentation/pages/product_list_page.dart';
import 'package:kaiho_app/features/products/presentation/pages/stories_page.dart';
import 'package:kaiho_app/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String products = '/products';
  static const String productDetail = '/product/:id';
  static const String favorites = '/favorites';
  static const String stories = '/stories';
  static const String cart = '/cart';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: products,
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: favorites,
        builder: (context, state) => const FavoritesPage(),
      ),
      GoRoute(
        path: stories,
        builder: (context, state) => const StoriesPage(),
      ),
      GoRoute(
        path: cart,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/product-detail',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailPage(product: product);
        },
      ),
    ],
  );
}