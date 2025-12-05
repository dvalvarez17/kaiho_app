import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaiho_app/core/routes/app_router.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    // Evitar recargar la misma página (excepto si currentIndex es -1, que significa que no estamos en una página del bottom nav)
    if (index == currentIndex && currentIndex != -1) return;

    switch (index) {
      case 0:
        // Inicio
        if (currentIndex != 0) {
          // Volver al home quitando todas las páginas del stack
          while (context.canPop()) {
            context.pop();
          }
        }
        break;
      case 1:
        // Favoritos
        context.push('/favorites');
        break;
      case 2:
        // Carrito (centro)
        context.push('/cart');
        break;
      case 3:
        // Historias
        context.push('/stories');
        break;
      case 4:
        // Menú
        Scaffold.of(context).openEndDrawer();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Barra de navegación con espacio para el botón flotante
          Container(
            height: 65 + bottomPadding,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavBarItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Inicio',
                    isSelected: currentIndex == 0,
                    onTap: () => _onItemTapped(context, 0),
                  ),
                  _NavBarItem(
                    icon: Icons.favorite_outline,
                    selectedIcon: Icons.favorite,
                    label: 'Favoritos',
                    isSelected: currentIndex == 1,
                    onTap: () => _onItemTapped(context, 1),
                  ),
                  // Espacio para el botón flotante
                  const SizedBox(width: 80),
                  _NavBarItem(
                    icon: Icons.auto_stories_outlined,
                    selectedIcon: Icons.auto_stories,
                    label: 'Historias',
                    isSelected: currentIndex == 3,
                    onTap: () => _onItemTapped(context, 3),
                  ),
                  _NavBarItem(
                    icon: Icons.menu,
                    selectedIcon: Icons.menu_open,
                    label: 'Menú',
                    isSelected: currentIndex == 4,
                    onTap: () => _onItemTapped(context, 4),
                  ),
                ],
              ),
            ),
          ),
          // Botón flotante del carrito en el centro
          Positioned(
            top: -25,
            child: GestureDetector(
              onTap: () => _onItemTapped(context, 2),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00B4D8),
                      Color(0xFF0096C7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00B4D8).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 32,
                    ),
                    // Badge de cantidad
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? const Color(0xFF00B4D8) : Colors.grey[600],
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF00B4D8) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
