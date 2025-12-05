import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_featured_products_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_new_arrivals_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:kaiho_app/features/products/domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetNewArrivalsUseCase getNewArrivalsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getFeaturedProductsUseCase,
    required this.getNewArrivalsUseCase,
    required this.getProductByIdUseCase,
  }) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<LoadFeaturedProductsEvent>(_onLoadFeaturedProducts);
    on<LoadNewArrivalsEvent>(_onLoadNewArrivals);
    on<LoadProductByIdEvent>(_onLoadProductById);
    on<SearchProductsEvent>(_onSearchProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final products = await getProductsUseCase(
        page: event.page,
        perPage: event.perPage,
      );

      emit(ProductsLoaded(
        products: products,
        currentPage: event.page,
        hasReachedMax: products.length < event.perPage,
      ));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadFeaturedProducts(
    LoadFeaturedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final products = await getFeaturedProductsUseCase(
        page: event.page,
        perPage: event.perPage,
      );

      emit(FeaturedProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadNewArrivals(
    LoadNewArrivalsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final products = await getNewArrivalsUseCase(
        page: event.page,
        perPage: event.perPage,
      );

      emit(NewArrivalsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadProductById(
    LoadProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final product = await getProductByIdUseCase(event.id);

      emit(ProductDetailLoaded(product: product));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final products = await getProductsUseCase(
        search: event.query,
        page: event.page,
        perPage: event.perPage,
      );

      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;

    print('🔍 LoadMoreProducts - Estado actual: ${currentState.runtimeType}');

    // Solo cargar más si estamos en estado ProductsLoaded y no hemos llegado al máximo
    if (currentState is! ProductsLoaded) {
      print('❌ No es ProductsLoaded');
      return;
    }

    if (currentState.hasReachedMax) {
      print('❌ Ya llegó al máximo');
      return;
    }

    try {
      print('✅ Cargando página ${event.page}...');

      // Emitir estado de carga con los productos actuales
      emit(ProductsLoadingMore(
        products: currentState.products,
        currentPage: currentState.currentPage,
      ));

      final newProducts = await getProductsUseCase(
        page: event.page,
        perPage: event.perPage,
      );

      print('📦 Nuevos productos recibidos: ${newProducts.length}');

      // Si no hay nuevos productos, hemos llegado al máximo
      if (newProducts.isEmpty) {
        print('⚠️ No hay más productos');
        emit(currentState.copyWith(hasReachedMax: true));
        return;
      }

      // Agregar los nuevos productos a la lista existente
      final allProducts = List<ProductEntity>.from(currentState.products)
        ..addAll(newProducts);

      print('✅ Total productos: ${allProducts.length}');

      emit(ProductsLoaded(
        products: allProducts,
        hasReachedMax: newProducts.length < event.perPage,
        currentPage: event.page,
      ));
    } catch (e) {
      print('❌ Error cargando más productos: $e');
      emit(ProductError(message: e.toString()));
    }
  }
}
