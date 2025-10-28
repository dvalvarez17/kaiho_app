# 🔐 Configuración de API WooCommerce

## ⚠️ IMPORTANTE: Seguridad de Credenciales

Las credenciales compartidas anteriormente fueron comprometidas al ser expuestas públicamente. **DEBES regenerarlas inmediatamente** antes de continuar.

---

## 📋 Pasos de Configuración

### 1. Regenerar Credenciales en WooCommerce

1. Accede al panel de administración de WooCommerce
2. Ve a: **WooCommerce > Configuración > Avanzado > API REST**
3. Elimina la API key antigua (la que compartiste)
4. Crea una nueva con permisos de **Lectura/Escritura**
5. Guarda las nuevas credenciales:
   - Consumer Key: `ck_XXXXXXXXXXXXX`
   - Consumer Secret: `cs_XXXXXXXXXXXXX`

### 2. Configurar el archivo .env

1. Abre el archivo `.env` en la raíz del proyecto
2. Reemplaza con tus nuevas credenciales:

```env
WOOCOMMERCE_URL=https://tu-tienda.com
WOOCOMMERCE_CONSUMER_KEY=ck_TU_NUEVA_CONSUMER_KEY
WOOCOMMERCE_CONSUMER_SECRET=cs_TU_NUEVO_CONSUMER_SECRET
API_VERSION=wc/v3
```

**Importante:**
- Reemplaza `https://tu-tienda.com` con la URL de tu tienda
- NO incluyas `/wp-json/` ni rutas adicionales en la URL
- El archivo `.env` NO debe subirse a Git (ya está en .gitignore)

### 3. Instalar Dependencias

Ejecuta en la terminal:

```bash
flutter pub get
```

### 4. Generar Código de Serialización

Los modelos usan `json_serializable`, así que necesitas generar los archivos `.g.dart`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Si necesitas regenerarlos más tarde:

```bash
flutter pub run build_runner watch
```

### 5. Verificar la Configuración

Ejecuta la app y verifica que:
- No hay errores de compilación
- Los productos se cargan desde tu API
- Las imágenes se muestran correctamente

---

## 🏗️ Arquitectura Implementada

```
lib/
├── core/
│   ├── config/
│   │   └── env_config.dart          # Lectura de variables de entorno
│   └── network/
│       └── api_client.dart          # Cliente HTTP con Dio
│
├── features/
│   └── products/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── product_remote_datasource.dart
│       │   ├── models/
│       │   │   ├── product_model.dart
│       │   │   └── category_model.dart
│       │   └── repositories/
│       │       └── product_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product_entity.dart
│       │   ├── repositories/
│       │   │   └── product_repository.dart
│       │   └── usecases/
│       │       ├── get_products_usecase.dart
│       │       ├── get_featured_products_usecase.dart
│       │       ├── get_new_arrivals_usecase.dart
│       │       └── get_product_by_id_usecase.dart
│       │
│       └── presentation/
│           └── bloc/
│               ├── product_bloc.dart
│               ├── product_event.dart
│               └── product_state.dart
```

---

## 🎯 Endpoints Disponibles

El datasource implementa los siguientes endpoints de WooCommerce:

### Productos
- `GET /products` - Lista de productos (con paginación, búsqueda, filtros)
- `GET /products/{id}` - Detalle de producto

### Categorías
- `GET /products/categories` - Lista de categorías

### Parámetros de Consulta

```dart
// Ejemplo: Obtener productos destacados
productBloc.add(LoadFeaturedProductsEvent(
  page: 1,
  perPage: 10,
));

// Ejemplo: Buscar productos
productBloc.add(SearchProductsEvent(
  query: 'camisa',
  page: 1,
  perPage: 20,
));
```

---

## 🔒 Seguridad

### ✅ Implementado:
- Variables de entorno con `.env`
- `.env` excluido de Git
- Autenticación WooCommerce con consumer_key/secret
- Manejo de errores HTTP
- Timeout configurado (30s)

### 🚧 Recomendaciones Adicionales:
1. **Producción**: Usa un backend proxy que maneje las API keys
2. **CI/CD**: Usa secrets del CI para inyectar credenciales
3. **Monitoreo**: Implementa logging de errores (Sentry, Firebase Crashlytics)
4. **Rate Limiting**: Implementa caché local para reducir llamadas

---

## 🧪 Cómo Usar el BLoC

### En HomePage (ejemplo):

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<ProductBloc>()
        ..add(LoadFeaturedProductsEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return CircularProgressIndicator();
          }

          if (state is FeaturedProductsLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(product: product);
              },
            );
          }

          if (state is ProductError) {
            return Text('Error: ${state.message}');
          }

          return Container();
        },
      ),
    );
  }
}
```

---

## 🐛 Solución de Problemas

### Error: "DioException: Connection timeout"
- Verifica tu conexión a internet
- Asegúrate de que la URL de WooCommerce es accesible
- Verifica que no hay firewall bloqueando la conexión

### Error: "Consumer key is invalid"
- Regenera las credenciales en WooCommerce
- Verifica que copiaste correctamente las credenciales en `.env`
- Asegúrate de que el `.env` está en la raíz del proyecto

### Error: "404 Not Found"
- Verifica que WooCommerce está instalado y activado
- Asegúrate de que la API REST está habilitada
- Verifica la URL en `.env` (no debe incluir `/wp-json/`)

### Los productos no se muestran
- Verifica que tienes productos publicados en WooCommerce
- Revisa la consola para ver los logs de red
- Usa Postman para probar los endpoints manualmente

---

## 📞 Endpoints de Prueba

Puedes probar tus credenciales con curl:

```bash
curl "https://tu-tienda.com/wp-json/wc/v3/products?consumer_key=ck_XXX&consumer_secret=cs_XXX"
```

---

## ✅ Checklist de Configuración

- [ ] Regenerar credenciales de WooCommerce
- [ ] Configurar `.env` con nuevas credenciales
- [ ] Ejecutar `flutter pub get`
- [ ] Ejecutar `build_runner` para generar código
- [ ] Verificar que la app compila sin errores
- [ ] Probar carga de productos desde la API
- [ ] Verificar que las imágenes se muestran
- [ ] Probar búsqueda y filtros (opcional)

---

**¡Listo!** Tu app ahora está conectada de forma segura con la API de WooCommerce 🎉
