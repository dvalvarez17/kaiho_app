import 'package:flutter/material.dart';
import 'package:kaiho_app/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kaiho_app/core/network/api_client.dart';
import 'package:kaiho_app/core/routes/app_router.dart';
import 'package:kaiho_app/core/theme/app_theme.dart';
import 'package:kaiho_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:kaiho_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:kaiho_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:kaiho_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:kaiho_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_featured_products_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_new_arrivals_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:kaiho_app/features/products/presentation/bloc/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar barras del sistema para que el contenido no se superponga
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  // Hacer las barras del sistema transparentes
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // Cargar variables de entorno
  await dotenv.load(fileName: '.env');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializar dependencias
    final apiClient = ApiClient();
    final productRemoteDataSource = ProductRemoteDataSourceImpl(apiClient: apiClient);
    final productRepository = ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(
          create: (_) => ProductBloc(
            getProductsUseCase: GetProductsUseCase(repository: productRepository),
            getFeaturedProductsUseCase: GetFeaturedProductsUseCase(repository: productRepository),
            getNewArrivalsUseCase: GetNewArrivalsUseCase(repository: productRepository),
            getProductByIdUseCase: GetProductByIdUseCase(repository: productRepository),
          ),
        ),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => FavoritesBloc()),
      ],
      child: MaterialApp.router(
        title: 'Kaiho',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
