# 🔧 Guía de Setup - Kaiho App

## Prerrequisitos

- Flutter SDK 3.7.2 o superior
- Dart SDK incluido con Flutter
- Editor: VS Code, Android Studio o IntelliJ IDEA
- Git

## 📦 Instalación Inicial

### 1. Instalar Dependencias

```bash
flutter pub get
```

### 2. Verificar Instalación

```bash
flutter doctor
```

Asegúrate de que todos los checks estén en verde o al menos:
- ✓ Flutter
- ✓ Android toolchain (para Android)
- ✓ Xcode (para iOS, solo macOS)
- ✓ VS Code / Android Studio

### 3. Ejecutar la Aplicación

```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo/emulador específico
flutter run

# Ejecutar en modo release
flutter run --release
```

## 🔥 Configuración de Firebase (Próximamente)

### Paso 1: Crear Proyecto Firebase

1. Ir a [Firebase Console](https://console.firebase.google.com/)
2. Crear nuevo proyecto "Kaiho"
3. Habilitar Google Analytics (opcional)

### Paso 2: Instalar FlutterFire CLI

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Agregar al PATH si es necesario
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### Paso 3: Configurar Firebase en el Proyecto

```bash
# En la raíz del proyecto
flutterfire configure
```

Seleccionar:
- ✓ Android
- ✓ iOS
- ✓ Web (opcional)

Esto creará:
- `lib/firebase_options.dart`
- Configurará archivos nativos automáticamente

### Paso 4: Habilitar Authentication

1. En Firebase Console → Authentication
2. Click "Get Started"
3. Habilitar métodos:
   - ✓ Email/Password
   - ✓ Google

### Paso 5: Configurar Google Sign-In (Android)

1. En Firebase Console → Project Settings
2. Descargar `google-services.json`
3. Colocar en `android/app/google-services.json`

### Paso 6: Configurar Google Sign-In (iOS)

1. Descargar `GoogleService-Info.plist`
2. Agregar a proyecto Xcode en `ios/Runner/`

### Paso 7: Actualizar Código

En `lib/main.dart`, agregar:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}
```

## 🧪 Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar con coverage
flutter test --coverage

# Ver coverage en HTML
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 🏗️ Build para Producción

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recomendado para Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Build para dispositivo
flutter build ios --release

# Abrir Xcode para archive
open ios/Runner.xcworkspace
```

## 🐛 Solución de Problemas Comunes

### Error: "Null check operator used on a null value"

**Solución**: Verificar que el BlocProvider esté correctamente configurado en `main.dart`

### Error: Firebase no inicializado

**Solución**:
```bash
flutterfire configure
```
Y asegurar que `Firebase.initializeApp()` está en `main()`

### Error: "Gradle sync failed" (Android)

**Solución**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: Pods (iOS)

**Solución**:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### Error: "Cannot resolve symbol" en Android Studio

**Solución**:
1. File → Invalidate Caches
2. Restart Android Studio

## 📱 Emuladores

### Android Emulator

```bash
# Listar AVDs disponibles
flutter emulators

# Iniciar AVD específico
flutter emulators --launch <avd_name>
```

### iOS Simulator (macOS)

```bash
# Abrir simulator
open -a Simulator

# Ejecutar
flutter run
```

## 🔑 Variables de Entorno (Futuro)

Crear archivo `.env` en la raíz:

```env
API_URL=https://api.kaiho.com
STRIPE_PUBLIC_KEY=pk_test_xxxxx
SENTRY_DSN=https://xxxxx
```

## 📊 Análisis de Código

```bash
# Análisis estático
flutter analyze

# Formato de código
dart format lib/

# Fix automático de issues
dart fix --apply
```

## 🚀 CI/CD (Futuro)

### GitHub Actions

Crear `.github/workflows/flutter.yml`:

```yaml
name: Flutter CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.7.2'
    - run: flutter pub get
    - run: flutter analyze
    - run: flutter test
    - run: flutter build apk
```

## 📝 Checklist de Setup

- [ ] Flutter SDK instalado
- [ ] Dependencias instaladas (`flutter pub get`)
- [ ] App ejecuta correctamente
- [ ] Proyecto Firebase creado
- [ ] FlutterFire configurado
- [ ] Authentication habilitado
- [ ] Google Sign-In configurado
- [ ] Tests ejecutando
- [ ] Git configurado

## 📚 Recursos Útiles

- [Flutter Docs](https://docs.flutter.dev/)
- [Firebase Flutter Setup](https://firebase.flutter.dev/docs/overview)
- [BLoC Library](https://bloclibrary.dev/)
- [Material Design 3](https://m3.material.io/)

## 🆘 Soporte

Para problemas o dudas:
1. Revisar [ARQUITECTURA.md](./ARQUITECTURA.md)
2. Consultar documentación oficial
3. Revisar issues conocidos

---

**Última actualización**: 2025-09-29