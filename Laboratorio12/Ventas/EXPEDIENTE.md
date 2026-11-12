# Expediente del Proyecto: Gestión de Ventas

**Estudiante:** Yefry Calderon  
**Semana:** 12  
**Grupo:** A  
**Tecnologías:** UIKit y Core Data

## 1. Descripción del proyecto

Gestión de Ventas es una aplicación para iPhone que organiza los procesos básicos de una operación comercial: autenticación del personal, mantenimiento de productos y clientes, registro de ventas, control de inventario, consulta de historiales y supervisión de resultados.

La aplicación diferencia las responsabilidades del Vendedor y del Supervisor. Cada operación queda asociada al usuario de la sesión, mientras que Core Data conserva localmente la información necesaria para continuar el trabajo después de cerrar y volver a abrir la aplicación.

## 2. Objetivos

### Objetivo general

Implementar una aplicación iOS que permita gestionar ventas, inventario y clientes mediante una interfaz UIKit y persistencia local con Core Data.

### Objetivos específicos

- Autenticar usuarios y controlar el acceso mediante roles.
- Administrar la información de productos y clientes.
- Registrar operaciones comerciales asociadas al vendedor activo.
- Validar cantidades y actualizar el inventario de forma consistente.
- Aplicar las reglas de descuento, IGV y clasificación de clientes.
- Conservar usuarios, productos, clientes y ventas mediante Core Data.
- Consultar historiales con búsqueda y filtros temporales.
- Permitir al Supervisor anular operaciones con trazabilidad.
- Presentar indicadores, tendencias, ranking y alertas de inventario.

## 3. Modelo de datos

| Entidad | Atributos reales | Relaciones |
| --- | --- | --- |
| Usuario | `nombre: String`, `usuario: String`, `clave: String`, `rol: String` | `ventas`: relación uno a muchos con Venta |
| Producto | `nombre: String`, `categoria: String`, `precio: Double`, `stock: Int64` | `ventas`: relación uno a muchos con Venta |
| Cliente | `nombre: String`, `documento: String` | `ventas`: relación uno a muchos con Venta |
| Venta | `fecha: Date`, `cantidad: Int64`, `precioUnitario: Double`, `descuento: Double`, `igv: Double`, `total: Double`, `anulada: Bool`, `motivoAnulacion: String?` | `vendedor: Usuario?`, `producto: Producto?`, `cliente: Cliente?` |

Cada Usuario, Producto y Cliente puede relacionarse con varias ventas. Cada Venta referencia como máximo a un vendedor, un producto y un cliente. Las relaciones incluyen sus inversas en el modelo Core Data.

Las relaciones `ventas` de Usuario, Producto y Cliente utilizan la regla de eliminación **Deny**, que impide borrar un registro cuando existen ventas relacionadas. Las relaciones de Venta hacia esas entidades utilizan **Nullify**. El servicio de persistencia también valida esta restricción antes de eliminar.

## 4. Matriz de permisos

| Funcionalidad | Vendedor | Supervisor |
| --- | --- | --- |
| Consultar y buscar productos | Sí | Sí |
| Crear, editar o eliminar productos | No | Sí |
| Consultar clientes | Sí | Sí |
| Crear y editar clientes | Sí | Sí |
| Eliminar clientes sin ventas | No | Sí |
| Registrar ventas | Sí | No |
| Consultar ventas propias | Sí | Sí, mediante filtros generales |
| Consultar todas las ventas | No | Sí |
| Filtrar ventas por vendedor | No | Sí |
| Anular ventas | No | Sí |
| Consultar indicadores y ranking | No | Sí |
| Consultar su cuenta y cerrar sesión | Sí | Sí |

Los permisos se reflejan en las pestañas y controles disponibles. Además, `Store` valida nuevamente el rol antes de ejecutar operaciones protegidas.

## 5. Reglas de negocio

### Categorías de clientes

- **Regular:** compras acumuladas menores a S/ 1,000.
- **Frecuente:** compras acumuladas desde S/ 1,000.
- **VIP:** compras acumuladas desde S/ 5,000.

El total acumulado considera únicamente ventas no anuladas. La categoría utilizada para calcular una nueva operación corresponde al historial vigente del cliente antes de registrar esa venta.

### Descuento e IGV

- Subtotal = precio unitario × cantidad.
- Descuento VIP = 10 % del subtotal.
- Descuento para clientes Regular y Frecuente = 0 %.
- IGV = 18 % de `(subtotal − descuento)`.
- Total = subtotal − descuento + IGV.

Los importes se calculan con `Decimal`, se redondean comercialmente a dos decimales y se almacenan como `Double` en el modelo solicitado.

### Inventario

- La cantidad vendida debe ser un entero mayor que cero.
- La cantidad no puede superar el stock disponible.
- Registrar una venta disminuye el stock en el mismo contexto de persistencia.
- Anular una venta devuelve exactamente la cantidad registrada.
- Una venta solo puede anularse una vez.
- Las ventas anuladas no participan en indicadores ni categorías de clientes.

### Seguridad y permisos

- El nombre y el usuario son obligatorios durante el registro.
- El usuario es único sin distinguir mayúsculas y minúsculas.
- La contraseña debe tener un mínimo de seis caracteres.
- La confirmación debe coincidir con la contraseña.
- El inicio de sesión requiere credenciales válidas.
- La sesión activa determina las pestañas, las consultas y las operaciones permitidas.
- Cerrar sesión elimina la referencia al usuario activo y regresa al acceso.

## 6. Descripción de pantallas

### A1. Inicio de sesión

Presenta el título de la aplicación, campos de usuario y contraseña, mensajes de validación, botón **Ingresar** y acceso al formulario de creación de cuenta.

### A2. Registro de usuario

Organiza el nombre completo, usuario, contraseña, confirmación y rol en secciones visuales. Valida los datos antes de crear el usuario e iniciar la sesión.

### A3. Productos

Muestra el catálogo con fotografías o iconos, precio, categoría y stock. Incluye búsqueda y filtro por categoría. El stock se representa en verde cuando supera 10 unidades, ámbar entre 6 y 10, y rojo cuando es 5 o menor. Las acciones de mantenimiento son exclusivas del Supervisor.

### A4. Clientes

Presenta avatares de iniciales, nombre, documento, total comprado y categoría. Vendedor y Supervisor pueden crear y editar clientes; la eliminación corresponde al Supervisor y respeta las relaciones existentes.

### A5. Nueva venta

Permite seleccionar cliente y producto, consultar el stock, ajustar la cantidad con un stepper y revisar subtotal, descuento, IGV y total antes de registrar la operación.

### A6. Mis ventas

Muestra al Vendedor sus operaciones, indicadores del día y del mes, filtros Todas/Hoy/Mes, búsqueda por cliente y diferenciación visual de ventas anuladas.

### A7. Ventas del equipo

Permite al Supervisor consultar el historial general, buscar por cliente, filtrar por periodo y seleccionar un vendedor mediante controles desplazables.

### A8. Anulación de ventas

Muestra el producto, cliente, cantidad y total de la operación. Solicita un motivo obligatorio, advierte que el stock será restituido y deshabilita la confirmación mientras el motivo esté vacío.

### A9. Resumen del supervisor

Incluye saludo personalizado, venta diaria, variación respecto del día anterior, total mensual, gráfico de siete días, ranking mensual y productos con stock de 10 unidades o menos.

### Cuenta

Presenta avatar, nombre, usuario, rol e información académica. Incluye la acción para cerrar la sesión.

## 7. Diseño de interfaz

La interfaz utiliza azul marino para identidad y jerarquía, turquesa para acciones principales, fondos claros y superficies blancas. Los formularios se agrupan en tarjetas con esquinas redondeadas y espaciado uniforme. SF Symbols identifica acciones, pestañas y estados.

Las tablas muestran información priorizada mediante tipografía de sistema, distintivos de categoría e indicadores de color. Los formularios se presentan dentro de vistas desplazables y utilizan Auto Layout para adaptarse al ancho disponible en iPhone.

## 8. Arquitectura y persistencia

`SceneDelegate` crea la ventana y presenta el flujo de autenticación. Después del acceso, un `UITabBarController` construye la navegación correspondiente al rol mediante controladores de navegación independientes.

Los controladores UIKit gestionan la presentación y las interacciones:

- `LoginController`, `RegisterController` y `AccountController` administran acceso y sesión.
- `CatalogController` atiende productos y clientes.
- `SaleController` registra operaciones.
- `SalesController` consulta y anula ventas.
- `DashboardController` construye indicadores y presenta Swift Charts dentro de UIKit.

`Store` concentra el `NSPersistentContainer`, consultas, guardado, validaciones, permisos y operaciones de negocio. Su contexto principal almacena los objetos del modelo `Ventas.xcdatamodeld`. La configuración normal utiliza un almacén persistente; el modo de verificación utiliza una base en memoria separada.

## 9. Casos de prueba previstos

| ID | Entrada o acción | Resultado esperado |
| --- | --- | --- |
| CP-01 | Registrar un usuario con datos válidos | Usuario almacenado y sesión iniciada |
| CP-02 | Registrar el mismo usuario con otra combinación de mayúsculas | Registro rechazado por duplicidad |
| CP-03 | Usar una contraseña de cuatro caracteres | Registro rechazado |
| CP-04 | Iniciar sesión con clave incorrecta | Acceso rechazado sin crear sesión |
| CP-05 | Vender 2 laptops de S/ 200 a un cliente VIP | Total S/ 424.80 y reducción de stock en 2 |
| CP-06 | Vender 3 mouse de S/ 35 a un cliente Regular | Total S/ 123.90 y reducción de stock en 3 |
| CP-07 | Solicitar una cantidad superior al stock | Operación rechazada sin modificar los datos |
| CP-08 | Consultar ventas desde otro vendedor | Solo se muestran las ventas del usuario activo |
| CP-09 | Anular sin motivo | Confirmación bloqueada y venta vigente |
| CP-10 | Anular una venta válida | Venta marcada, stock restituido e indicadores actualizados |
| CP-11 | Intentar una segunda anulación | Operación rechazada sin volver a sumar stock |
| CP-12 | Borrar una entidad con ventas | Eliminación rechazada por la regla Deny |
| CP-13 | Reiniciar la aplicación después de registrar datos | Información recuperada desde Core Data |

Los casos se consideran previstos hasta que se ejecuten en Xcode y se registre su resultado.

## 10. Plan de trabajo

1. Revisar los requisitos funcionales y las reglas del caso de ventas.
2. Verificar las entidades, atributos, relaciones e inversas de Core Data.
3. Comprobar autenticación, registro, sesión y permisos por rol.
4. Validar el mantenimiento de productos y clientes.
5. Comprobar los cálculos, el stock y el guardado de ventas.
6. Verificar historial, filtros, anulación e indicadores.
7. Ejecutar las comprobaciones automatizadas en una compilación Debug.
8. Recorrer manualmente los flujos de Vendedor y Supervisor.
9. Comprobar persistencia después de cerrar y abrir la aplicación.
10. Registrar los resultados reales y corregir las incidencias detectadas.
