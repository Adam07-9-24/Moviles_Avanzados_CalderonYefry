# Registro de Prompts – Gestión de Ventas

**Estudiante:** Yefry Calderon  
**Curso:** Programación en Móviles Avanzado  
**Semana:** 12  
**Tecnologías:** Swift, UIKit y Core Data

## Prompt 1. Desarrollo de la aplicación Gestión de Ventas

**Contexto:**

Necesito desarrollar una aplicación móvil para iOS que permita administrar los productos, clientes y ventas de una tienda. La aplicación debe utilizar Swift, UIKit y Core Data para almacenar la información localmente.

**Tarea:**

Desarrolla una aplicación de Gestión de Ventas que incluya las siguientes funcionalidades:

- Inicio de sesión y registro de usuarios.
- Autenticación con usuario y contraseña.
- Roles de Vendedor y Supervisor.
- Registro, consulta, edición y eliminación de productos según permisos.
- Gestión de clientes.
- Registro de ventas con selección de productos y cantidades.
- Control automático del inventario.
- Historial de ventas.
- Anulación de ventas con motivo obligatorio.
- Panel de indicadores comerciales para el Supervisor.
- Cierre de sesión.

Implementa cuatro entidades en Core Data: Usuario, Producto, Cliente y Venta, con sus respectivos atributos y relaciones.

**Restricciones:**

- Utilizar Swift y UIKit.
- Implementar Core Data como almacenamiento local.
- Respetar los permisos de cada rol.
- Validar los campos obligatorios.
- Evitar registros duplicados de usuarios.
- Mantener una estructura de código organizada.
- No utilizar dependencias externas innecesarias.

**Formato esperado:**

Proyecto iOS funcional con archivos Swift organizados, modelo Core Data, pantallas de navegación y operaciones comerciales, preparado para ejecutarse en Xcode.

## Prompt 2. Diseño de interfaz y funcionalidades comerciales

**Contexto:**

La aplicación Gestión de Ventas necesita una interfaz moderna y fácil de utilizar que permita realizar operaciones comerciales desde un iPhone.

**Tarea:**

Diseña e implementa una interfaz utilizando UIKit, con colores azul marino y turquesa, tarjetas informativas, botones personalizados, iconos SF Symbols, formularios organizados e indicadores visuales.

Desarrolla las siguientes pantallas:

1. Inicio de sesión.
2. Registro de usuarios.
3. Catálogo de productos.
4. Gestión de clientes.
5. Registro de ventas.
6. Mis ventas.
7. Ventas del equipo.
8. Anulación de ventas.
9. Resumen del supervisor.

Incluye también una sección de Cuenta con información del usuario y opción para cerrar sesión.

Implementa las siguientes reglas de negocio:

- Cliente Regular: compras acumuladas menores a S/ 1,000.
- Cliente Frecuente: compras desde S/ 1,000.
- Cliente VIP: compras desde S/ 5,000.
- Aplicar un descuento del 10 % a clientes VIP.
- Calcular el IGV del 18 % después del descuento.
- Reducir el stock al registrar una venta.
- Impedir ventas que superen el stock disponible.
- Devolver el stock cuando se anule una venta.
- Solicitar un motivo obligatorio para la anulación.
- Excluir las ventas anuladas de los indicadores y categorías de clientes.

**Restricciones:**

- Utilizar UIKit y Auto Layout.
- Mantener la información mediante Core Data.
- Restringir las funcionalidades según el rol.
- Permitir la anulación únicamente al Supervisor.
- Evitar anulaciones duplicadas.
- Validar correctamente los importes y cantidades.
- Diseñar pantallas adaptables a diferentes tamaños de iPhone.

**Formato esperado:**

Interfaces desarrolladas en Swift con UIKit, navegación funcional, formularios validados, indicadores visuales y cálculos comerciales implementados correctamente.

## Prompt 3. Implementación de pruebas y documentación

**Contexto:**

La aplicación Gestión de Ventas necesita contar con pruebas funcionales y documentación técnica que permita comprender sus componentes, operaciones y reglas de negocio.

**Tarea:**

Implementa y organiza las verificaciones necesarias para comprobar el funcionamiento de los módulos de autenticación, productos, clientes, ventas e inventario.

Incluye casos de prueba para:

- Registro exitoso de usuarios.
- Validación de usuarios duplicados.
- Inicio de sesión correcto e incorrecto.
- Restricciones de acceso por roles.
- Registro y edición de productos.
- Registro de clientes.
- Cálculo de ventas regulares y VIP.
- Validación de stock insuficiente.
- Consulta de ventas por vendedor.
- Anulación con motivo obligatorio.
- Devolución del stock.
- Persistencia de datos después de reiniciar la aplicación.

Organiza también la documentación técnica del proyecto, incluyendo descripción general, objetivos, tecnologías, entidades, relaciones, permisos, funcionalidades, reglas de negocio y procedimiento de ejecución.

**Restricciones:**

- Mantener Swift, UIKit y Core Data.
- No modificar las reglas comerciales establecidas.
- Utilizar casos de prueba con resultados esperados.
- No registrar pruebas como exitosas sin haberlas ejecutado.
- Mantener una documentación clara y académica.
- Evitar dependencias adicionales innecesarias.

**Formato esperado:**

Código de comprobaciones funcionales y documentación organizada en archivos Markdown, incluyendo README.md, EXPEDIENTE.md y PRUEBAS.md, con instrucciones para ejecutar y verificar la aplicación en Xcode.
