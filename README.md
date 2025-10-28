# Kaiho App

E-commerce de productos sostenibles construido con Flutter y arquitectura BLoC.

## 🚀 Inicio Rápido

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la app
flutter run
```

## 📂 Estructura del Proyecto

```
lib/
├── core/              # Configuración global (theme, routes)
├── features/          # Características modulares
│   ├── auth/         # Autenticación (Login/Register)
│   └── products/     # Productos (Home/Lista)
└── shared/           # Widgets compartidos
```

## 📖 Documentación Completa

Ver [ARQUITECTURA.md](./ARQUITECTURA.md) para:
- Diagramas de arquitectura y flujo
- Guía de integración Firebase
- Convenciones de código
- Roadmap de desarrollo

## 🎯 Estado Actual

**Versión**: 0.1.0 - MVP
**Pantallas**: Login, Registro, Home, Lista de Productos
**Estado**: Listo para integración Firebase

## 📦 Dependencias Principales

- `flutter_bloc` - Gestión de estado
- `go_router` - Navegación
- `firebase_auth` - Autenticación (próximamente)
- `equatable` - Comparación de objetos

## 🔜 Próximos Pasos

1. Configurar Firebase
2. Implementar OAuth con Google
3. Crear ProductBloc
4. Agregar carrito de compras

---

Para más detalles técnicos, consulta [ARQUITECTURA.md](./ARQUITECTURA.md)
