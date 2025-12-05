import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00B4D8),
                    Color(0xFF0096C7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage('https://picsum.photos/seed/user1/100/100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Usuario Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'usuario@kaiho.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.person_outline,
              title: 'Mi Perfil',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a perfil
              },
            ),
            _DrawerItem(
              icon: Icons.shopping_bag_outlined,
              title: 'Mis Pedidos',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a pedidos
              },
            ),
            _DrawerItem(
              icon: Icons.favorite_outline,
              title: 'Favoritos',
              onTap: () {
                Navigator.pop(context);
                context.push('/favorites');
              },
            ),
            _DrawerItem(
              icon: Icons.location_on_outlined,
              title: 'Direcciones',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a direcciones
              },
            ),
            _DrawerItem(
              icon: Icons.payment_outlined,
              title: 'Métodos de Pago',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a métodos de pago
              },
            ),
            const Divider(),
            _DrawerItem(
              icon: Icons.settings_outlined,
              title: 'Configuración',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a configuración
              },
            ),
            _DrawerItem(
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a ayuda
              },
            ),
            _DrawerItem(
              icon: Icons.info_outline,
              title: 'Acerca de',
              onTap: () {
                Navigator.pop(context);
                // TODO: Mostrar información de la app
              },
            ),
            const Divider(),
            _DrawerItem(
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
                // TODO: Cerrar sesión
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.grey[800],
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4,
      ),
    );
  }
}
