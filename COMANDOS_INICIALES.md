# 🚀 Comandos Iniciales - Kaiho App

## ⚡ Para empezar AHORA

Ejecuta estos comandos en orden:

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Verificar que Flutter esté bien configurado
flutter doctor

# 3. Ver dispositivos disponibles
flutter devices

# 4. Ejecutar la aplicación
flutter run
```

## 📱 Testing de Pantallas

Una vez que la app esté corriendo, prueba la navegación:

1. **Login Page** (pantalla inicial)
   - Ingresa cualquier email y contraseña (6+ caracteres)
   - Click en "Iniciar sesión"
   - Debe navegar a Home Page

2. **Register Page**
   - Desde Login, click en "Crear una"
   - Llena el formulario
   - Click en "Registrarse"
   - Debe navegar a Home Page

3. **Home Page**
   - Verás productos destacados y nuevos
   - Click en "Ver todos" o ícono de búsqueda
   - Navega a Product List Page

4. **Product List Page**
   - Explora el grid de productos
   - Prueba los filtros de categorías
   - Usa la búsqueda

## 🔥 Próximo Paso: Firebase

Cuando estés listo para integrar Firebase:

```bash
# 1. Instalar Firebase CLI (requiere Node.js)
npm install -g firebase-tools

# 2. Login en Firebase
firebase login

# 3. Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# 4. Configurar Firebase en el proyecto
flutterfire configure
```

Luego sigue las instrucciones en `SETUP.md` → "Configuración de Firebase"

## 🐛 Si algo no funciona

```bash
# Limpiar proyecto
flutter clean

# Re-instalar dependencias
flutter pub get

# Si siguen los errores, revisar
flutter doctor -v
```

## 📚 Documentación

- **Inicio rápido**: `README.md`
- **Arquitectura y diagramas**: `ARQUITECTURA.md`
- **Setup completo**: `SETUP.md`
- **Resumen del proyecto**: `PROYECTO_SUMMARY.md`

---

¡Ya estás listo para desarrollar! 🎉