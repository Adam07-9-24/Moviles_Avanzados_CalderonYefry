# Gestión de Ventas — Laboratorio 12

**Estudiante:** Yefry Calderon  
**Curso:** Programación en Móviles Avanzado  
**Tecnologías:** Swift, UIKit y Core Data

## Descripción

Gestión de Ventas es una aplicación móvil para iOS orientada a la administración de productos, clientes y operaciones comerciales. El sistema incorpora autenticación, perfiles de usuario, control de inventario, cálculo de importes, consulta de historiales y un panel de indicadores para supervisión.

La información se almacena localmente con Core Data. La navegación y las pantallas se implementan con UIKit y Auto Layout programático.

## Objetivo general

Desarrollar y evaluar una aplicación móvil de gestión de ventas que permita registrar operaciones comerciales, controlar existencias y consultar información mediante persistencia local.

## Funcionalidades principales

- Inicio de sesión mediante usuario y contraseña.
- Registro de usuarios con los roles Vendedor y Supervisor.
- Consulta de productos con búsqueda y filtro por categoría.
- Administración de productos por parte del Supervisor.
- Registro y actualización de clientes.
- Clasificación automática de clientes como Regular, Frecuente o VIP.
- Registro de ventas asociado al vendedor de la sesión.
- Cálculo de subtotal, descuento VIP, IGV y total.
- Validación de cantidad y stock disponible.
- Consulta de ventas propias para el Vendedor.
- Consulta general y filtro por vendedor para el Supervisor.
- Anulación de ventas con motivo obligatorio y reposición de inventario.
- Indicadores diarios y mensuales, gráfico semanal, ranking de vendedores y alertas de stock.
- Visualización del perfil y cierre de sesión.

## Tecnologías

- **Swift:** lenguaje utilizado para la lógica, los controladores y el acceso a datos.
- **UIKit:** construcción de vistas, navegación, tablas, formularios, alertas y pestañas.
- **Core Data:** persistencia local de usuarios, productos, clientes y ventas.
- **Auto Layout:** distribución adaptable de los componentes en pantallas de iPhone.
- **SF Symbols:** iconografía del sistema para navegación, estados y acciones.
- **Swift Charts:** gráfico de barras de ventas de los últimos siete días, integrado en UIKit mediante `UIHostingController`.
- **Xcode:** compilación, firma, ejecución y depuración del proyecto iOS.

El proyecto no utiliza dependencias externas.

## Estructura del proyecto

| Ruta | Responsabilidad |
| --- | --- |
| `Ventas.xcodeproj` | Configuración del proyecto, target y esquema `Ventas` |
| `Ventas/App.swift` | Ciclo de vida, tema visual, autenticación, registro, navegación y cuenta |
| `Ventas/CatalogController.swift` | Catálogo de productos y clientes, búsqueda, filtros y operaciones CRUD |
| `Ventas/SaleController.swift` | Formulario y resumen para registrar una venta |
| `Ventas/SalesController.swift` | Historial, búsqueda, filtros por periodo y vendedor, y anulación |
| `Ventas/DashboardController.swift` | Indicadores, gráfico semanal, ranking y stock bajo |
| `Ventas/Store.swift` | Entidades administradas, persistencia, permisos y reglas de negocio |
| `Ventas/Verification.swift` | Comprobaciones automatizadas en memoria para compilaciones Debug |
| `Ventas/Ventas.xcdatamodeld` | Modelo Core Data con las entidades Usuario, Producto, Cliente y Venta |
| `Ventas/Assets.xcassets` | Icono, fotografías, colores e imágenes utilizadas por la interfaz |
| `Ventas/Info.plist` | Configuración del ciclo de vida por escenas |

## Ejecución en Xcode

1. Abrir `Ventas.xcodeproj` en una versión de Xcode compatible con el SDK configurado.
2. Seleccionar el esquema `Ventas`.
3. Configurar el equipo de desarrollo en **Signing & Capabilities** si Xcode lo solicita.
4. Elegir un simulador de iPhone compatible.
5. Compilar con **Product > Build**.
6. Ejecutar con **Run** o con el botón ▶.
7. En una instalación sin datos, seleccionar **Crear cuenta** para registrar el primer usuario.

## Reglas principales

### Clientes

- Regular: compras vigentes acumuladas menores a S/ 1,000.
- Frecuente: compras vigentes acumuladas desde S/ 1,000.
- VIP: compras vigentes acumuladas desde S/ 5,000.
- Las ventas anuladas no participan en la categoría del cliente.

### Cálculo de ventas

- Subtotal = precio unitario × cantidad.
- Descuento VIP = 10 % del subtotal.
- Otros clientes = 0 % de descuento.
- IGV = 18 % del importe después del descuento.
- Total = subtotal − descuento + IGV.

### Inventario y anulación

- La cantidad debe ser positiva y no puede superar el stock disponible.
- Registrar una venta disminuye el stock del producto.
- Anular una venta requiere un motivo y devuelve las unidades al inventario.
- Una venta anulada no puede anularse nuevamente.
- Los registros relacionados con ventas están protegidos contra eliminación.

## Estudiante

**Yefry Calderon**

## Créditos y licencias

Los iconos SVG de productos pertenecen a **Font Awesome Free** y conservan sus avisos de licencia CC BY 4.0, SIL OFL 1.1 y MIT, según corresponda. Las fotografías ilustrativas del catálogo proceden de **Unsplash** y se utilizan conforme a su licencia. Los símbolos de interfaz pertenecen a **SF Symbols** de Apple.
