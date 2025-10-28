import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaiho_app/core/widgets/app_bottom_navigation.dart';
import 'package:kaiho_app/core/widgets/app_drawer.dart';
import 'package:kaiho_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/presentation/bloc/product_bloc.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _selectedCategory = 'Categorías';
  List<ProductEntity> _products = [];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    // Cargar todos los productos al iniciar
    context.read<ProductBloc>().add(const LoadProductsEvent());

    // Agregar listener para detectar cuando llega al final
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottomReached && !_isLoadingMore && !_hasReachedMax) {
      print('🔄 Cargando más productos - Página actual: $_currentPage, Siguiente: ${_currentPage + 1}');
      _loadMoreProducts();
    }
  }

  bool get _isBottomReached {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Cargar cuando está a 200 pixels del final
    final reached = currentScroll >= (maxScroll - 200);
    if (reached) {
      print('📍 Llegó al final - Current: $currentScroll, Max: $maxScroll, Loading: $_isLoadingMore, HasMax: $_hasReachedMax');
    }
    return reached;
  }

  void _loadMoreProducts() {
    final nextPage = _currentPage + 1;
    print('📦 LoadMoreProductsEvent - Página: $nextPage');
    context.read<ProductBloc>().add(LoadMoreProductsEvent(page: nextPage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        print('👂 Listener - Estado: ${state.runtimeType}');

        if (state is ProductsLoaded) {
          print('✅ ProductsLoaded - Productos: ${state.products.length}, Página: ${state.currentPage}, HasMax: ${state.hasReachedMax}');
          setState(() {
            _products = state.products;
            _currentPage = state.currentPage;
            _hasReachedMax = state.hasReachedMax;
            _isLoadingMore = false;
          });
        } else if (state is ProductsLoadingMore) {
          print('⏳ ProductsLoadingMore - Productos: ${state.products.length}, Página: ${state.currentPage}');
          setState(() {
            _products = state.products;
            _currentPage = state.currentPage;
            _isLoadingMore = true;
          });
        } else if (state is ProductError) {
          print('❌ ProductError - ${state.message}');
          setState(() {
            _isLoadingMore = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kaiho'),
            actions: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  final itemCount = cartState is CartLoaded ? cartState.itemCount : 0;
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          context.push('/cart');
                        },
                      ),
                      if (itemCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF00B4D8),
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$itemCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar productos',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF6C757D)),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // Category Filter
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _CategoryChip(
                      label: 'Categorías',
                      isSelected: _selectedCategory == 'Categorías',
                      onTap: () => setState(() => _selectedCategory = 'Categorías'),
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: 'Ofertas',
                      isSelected: _selectedCategory == 'Ofertas',
                      onTap: () => setState(() => _selectedCategory = 'Ofertas'),
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: 'Novedades',
                      isSelected: _selectedCategory == 'Novedades',
                      onTap: () => setState(() => _selectedCategory = 'Novedades'),
                    ),
                  ],
                ),
              ),

              // Product Grid
              Expanded(
                child: state is ProductLoading && _products.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _products.isEmpty
                        ? const Center(
                            child: Text('No hay productos disponibles'),
                          )
                        : CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                sliver: SliverGrid(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final product = _products[index];
                                      return _ProductGridItem(product: product);
                                    },
                                    childCount: _products.length,
                                  ),
                                ),
                              ),
                              // Indicador de carga al final
                              if (_isLoadingMore)
                                const SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              // Espacio para el bottom navigation
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 100),
                              ),
                            ],
                          ),
              ),
            ],
          ),
          endDrawer: const AppDrawer(),
          bottomNavigationBar: const AppBottomNavigation(currentIndex: -1),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00B4D8) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6C757D),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final ProductEntity product;

  const _ProductGridItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/product-detail', extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF00B4D8),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212529),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}