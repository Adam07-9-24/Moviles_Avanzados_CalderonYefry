# Pruebas Funcionales — Gestión de Ventas

## 1. Objetivo

Definir las verificaciones necesarias para comprobar el correcto funcionamiento de la aplicación Gestión de Ventas, con énfasis en autenticación, permisos, persistencia, cálculos comerciales, inventario, consultas y anulación de operaciones.

## 2. Entorno de pruebas

### Entorno previsto

- **Plataforma:** iOS.
- **IDE:** Xcode.
- **Lenguaje:** Swift.
- **Interfaz:** UIKit.
- **Persistencia:** Core Data.
- **Dispositivo:** simulador de iPhone compatible con el deployment target del proyecto.
- **Configuración automatizada:** compilación Debug con el argumento `--verify`.

### Entorno de revisión documental

La documentación fue organizada en Windows, donde no están disponibles Xcode, el SDK de iOS ni el simulador. En consecuencia, los casos de esta matriz permanecen pendientes hasta ejecutarse en un entorno macOS compatible. La existencia de código de comprobación no se considera por sí sola un resultado aprobado.

## 3. Matriz de pruebas funcionales

| ID | Módulo | Caso de prueba | Resultado esperado | Estado de ejecución |
| --- | --- | --- | --- | --- |
| PF-01 | Registro | Registrar nombre, usuario, contraseña válida, confirmación y rol | Usuario almacenado y sesión iniciada | Pendiente |
| PF-02 | Registro | Registrar un usuario ya existente con distinta combinación de mayúsculas | Registro rechazado por duplicidad | Pendiente |
| PF-03 | Registro | Usar una contraseña menor de seis caracteres | Registro rechazado con mensaje de validación | Pendiente |
| PF-04 | Registro | Ingresar contraseñas diferentes | Registro rechazado sin guardar el usuario | Pendiente |
| PF-05 | Autenticación | Iniciar sesión con credenciales válidas | Acceso concedido y navegación correspondiente al rol | Pendiente |
| PF-06 | Autenticación | Iniciar sesión con usuario o clave incorrectos | Acceso rechazado y sesión vacía | Pendiente |
| PF-07 | Permisos | Acceder como Vendedor y como Supervisor | Pestañas y acciones visibles según el rol | Pendiente |
| PF-08 | Productos | Registrar un producto como Supervisor | Producto guardado con nombre, categoría, precio y stock | Pendiente |
| PF-09 | Clientes | Registrar un cliente con nombre y documento | Cliente guardado y disponible para ventas | Pendiente |
| PF-10 | Ventas | Registrar 3 mouse de S/ 35 para un cliente Regular | Total S/ 123.90 y stock reducido en 3 | Pendiente |
| PF-11 | Ventas | Registrar 2 laptops de S/ 200 para un cliente VIP | Total S/ 424.80 y stock reducido en 2 | Pendiente |
| PF-12 | Inventario | Solicitar una cantidad mayor que el stock | Venta rechazada sin modificar stock ni historial | Pendiente |
| PF-13 | Historial | Consultar ventas como Vendedor | Solo aparecen las ventas del usuario activo | Pendiente |
| PF-14 | Supervisión | Consultar ventas como Supervisor y filtrar por vendedor | Se muestran las operaciones generales o del vendedor elegido | Pendiente |
| PF-15 | Anulación | Intentar anular sin escribir motivo | Botón deshabilitado o validación rechazada | Pendiente |
| PF-16 | Anulación | Anular una venta vigente con motivo | Venta marcada como anulada y cantidad devuelta al stock | Pendiente |
| PF-17 | Anulación | Intentar anular nuevamente la misma venta | Operación rechazada y stock sin cambios adicionales | Pendiente |
| PF-18 | Integridad | Intentar borrar un usuario, producto o cliente con ventas | Eliminación rechazada por validación y regla Deny | Pendiente |
| PF-19 | Indicadores | Registrar y anular operaciones que afectan el resumen | Tarjetas, gráfico, ranking y categorías consideran solo ventas vigentes | Pendiente |
| PF-20 | Persistencia | Cerrar y abrir la aplicación después de guardar datos | Usuarios, productos, clientes, ventas y stock se recuperan | Pendiente |

## 4. Validación de cálculos

### Caso VIP

- Producto: Laptop.
- Precio unitario: S/ 200.00.
- Cantidad: 2.
- Subtotal: `200.00 × 2 = S/ 400.00`.
- Descuento VIP: `400.00 × 10 % = S/ 40.00`.
- Base para IGV: `400.00 − 40.00 = S/ 360.00`.
- IGV: `360.00 × 18 % = S/ 64.80`.
- Total: `400.00 − 40.00 + 64.80 = S/ 424.80`.

### Caso Regular

- Producto: Mouse.
- Precio unitario: S/ 35.00.
- Cantidad: 3.
- Subtotal: `35.00 × 3 = S/ 105.00`.
- Descuento: S/ 0.00.
- Base para IGV: S/ 105.00.
- IGV: `105.00 × 18 % = S/ 18.90`.
- Total: `105.00 + 18.90 = S/ 123.90`.

## 5. Comprobaciones automatizadas

`Verification.swift` define una suite disponible únicamente en compilaciones Debug. `SceneDelegate` la activa cuando los argumentos del proceso contienen `--verify`.

La suite crea un `Store(memory: true)`, utiliza un almacén Core Data temporal en memoria y ejecuta 13 comprobaciones:

1. Usuario único sin distinguir mayúsculas e inicio de sesión después del registro.
2. Rechazo de contraseña corta y confirmación diferente.
3. Rechazo de inicio de sesión con clave incorrecta.
4. Cálculo de venta VIP y reducción de stock.
5. Cálculo de venta Regular.
6. Rechazo de stock insuficiente sin alterar existencias.
7. Aislamiento de ventas y permisos de anulación.
8. Motivo obligatorio para anular.
9. Anulación, reposición de stock y actualización del reporte.
10. Protección de borrado desde la capa de operaciones.
11. Validación de la regla Deny del modelo Core Data.
12. Prevención de una segunda anulación.
13. Repetibilidad del cálculo comercial.

Cada condición utiliza `precondition`; un incumplimiento detiene la ejecución e identifica el caso en consola. Si todas las comprobaciones alcanzan el final, el código imprime el número de verificaciones procesadas. Estas comprobaciones están disponibles en el proyecto, pero deben ejecutarse en Xcode antes de registrar un resultado como aprobado.

## 6. Procedimiento de ejecución

1. Abrir `Ventas.xcodeproj` en Xcode.
2. Seleccionar el esquema `Ventas` y un simulador de iPhone compatible.
3. Configurar la firma si Xcode la requiere.
4. Compilar con **Product > Build** y corregir cualquier error informado.
5. Ejecutar la aplicación sin argumentos para recorrer los flujos manuales.
6. Registrar cuentas separadas para Vendedor y Supervisor.
7. Preparar productos, clientes Regular y VIP, y stock suficiente para los casos numéricos.
8. Ejecutar los casos PF-01 a PF-20 y registrar el resultado observado.
9. Para la suite automatizada, abrir **Product > Scheme > Edit Scheme > Run > Arguments**.
10. Agregar y habilitar el argumento `--verify`.
11. Ejecutar la compilación Debug y revisar las líneas `PASS` y el resumen en la consola.
12. Deshabilitar `--verify` después de la comprobación.
13. Terminar y volver a abrir la aplicación para evaluar la persistencia.

## 7. Registro de resultados

Los estados deben utilizarse de la siguiente manera:

- **Aprobado:** la prueba fue ejecutada y el resultado coincidió con lo esperado.
- **Fallido:** la prueba fue ejecutada y produjo un resultado diferente al esperado.
- **Pendiente:** la prueba aún no fue ejecutada o no existe evidencia verificable de su ejecución.

Al ejecutar los casos se recomienda registrar fecha, versión de Xcode, versión de iOS, dispositivo o simulador, datos iniciales, resultado observado y observaciones. La matriz actual utiliza el estado **Pendiente** para evitar afirmar resultados no comprobados en el entorno de ejecución requerido.
