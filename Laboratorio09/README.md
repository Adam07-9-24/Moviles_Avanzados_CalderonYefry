
# Laboratorio 09 - Boleta de Pago en SwiftUI

**Curso:** Programación en Móviles Avanzado  
**Institución:** TECSUP  
**Estudiante:** Yefry Calderón  
**Tecnología:** Swift y SwiftUI  
**Plataforma:** iOS  
**Entorno de desarrollo:** Xcode  
**Simulador:** iPhone 17 Pro  

---

## 1. Descripción del proyecto

BoletaPago es una aplicación móvil desarrollada con SwiftUI que permite calcular una boleta de pago simplificada de un trabajador.

La aplicación recibe los datos ingresados por el usuario, calcula sus remuneraciones, descuentos pensionarios y aportaciones del empleador, y muestra el monto neto a pagar.

El objetivo es aplicar estructuras, clases, colecciones, validaciones y operaciones matemáticas en Swift, manteniendo separada la lógica de cálculo de la interfaz gráfica.

## 2. Funcionalidades implementadas

- Registro del sueldo básico mensual.
- Ingreso de días laborados entre 1 y 30.
- Selección de asignación familiar mediante la opción de hijos.
- Selección del sistema de pensiones ONP o AFP.
- Cálculo de horas extras con recargos del 25 % y 35 %.
- Registro de adelantos de sueldo.
- Cálculo de remuneraciones totales.
- Cálculo de descuentos ONP y AFP.
- Cálculo de la aportación EsSalud.
- Cálculo del neto a pagar.
- Validación de los datos ingresados.
- Visualización de la boleta en una pantalla desplazable.

## 3. Tecnologías utilizadas

| Tecnología | Utilización |
|---|---|
| Swift | Lenguaje de programación |
| SwiftUI | Construcción de la interfaz gráfica |
| Xcode | Desarrollo y ejecución |
| iOS Simulator | Pruebas de la aplicación |
| Git | Control de versiones |
| GitHub | Almacenamiento del código fuente |

## 4. Estructura de la aplicación

El proyecto utiliza tres archivos Swift principales:

### BoletaPagoApp.swift

Contiene el punto de entrada de la aplicación y presenta la vista principal mediante `WindowGroup`.

### ContentView.swift

Implementa la interfaz gráfica utilizando componentes SwiftUI como:

- Text
- TextField
- Picker
- Button
- VStack
- HStack
- ScrollView
- @State

También gestiona los datos ingresados, las validaciones y la presentación de resultados.

### Boleta.swift

Contiene los modelos de datos, parámetros de cálculo y la clase Boleta, encargada de realizar las operaciones de remuneraciones, descuentos y aportaciones.

Para los cálculos monetarios se utiliza `Decimal` y se redondean los conceptos a dos decimales.

## 5. Fórmulas utilizadas

| Concepto | Fórmula |
|---|---|
| Sueldo computable | Sueldo básico / 30 × días laborados |
| Asignación familiar | RMV × 10 % |
| Valor hora | Sueldo básico / 30 / 8 |
| Horas extras 25 % | Valor hora × 1.25 × horas |
| Horas extras 35 % | Valor hora × 1.35 × horas |
| Total remuneraciones | Suma de conceptos remunerativos |
| ONP | Total remuneraciones × 13 % |
| AFP fondo | Total remuneraciones × 10 % |
| AFP comisión | Total remuneraciones × 1.60 % |
| AFP seguro | Total remuneraciones × 1.35 % |
| EsSalud | Total remuneraciones × 9 % |
| Total descuentos | Descuentos pensionarios + adelantos |
| Neto a pagar | Total remuneraciones - total descuentos |

### Parámetros académicos

Se utilizan los siguientes valores establecidos en la actividad:

- RMV: S/ 1,230.00
- Asignación familiar: S/ 123.00
- ONP: 13 %
- EsSalud: 9 %
- AFP Ejemplo: fondo 10 %, comisión 1.60 % y seguro 1.35 %

Las tasas de AFP Ejemplo son valores ficticios para las pruebas del laboratorio.

## 6. Validaciones implementadas

La aplicación comprueba las siguientes condiciones:

- El sueldo básico debe ser mayor que cero.
- Los días laborados deben estar entre 1 y 30.
- Las horas extras no pueden tener valores negativos.
- Los adelantos no pueden ser negativos.
- Los campos numéricos obligatorios deben contener valores válidos.
- La AFP seleccionada debe existir en los parámetros configurados.

Cuando se detecta un dato incorrecto, se muestra un mensaje y se cancela el cálculo.

Los resultados anteriores se eliminan cuando se modifica la información del formulario.

## 7. Caso de prueba 1 - ONP sin hijos

### Datos ingresados

| Campo | Valor |
|---|---|
| Sueldo básico | S/ 2,500.00 |
| Días laborados | 30 |
| Tiene hijos | No |
| Sistema de pensiones | ONP |
| Horas extras 25 % | 0 |
| Horas extras 35 % | 0 |
| Adelantos | S/ 0.00 |

### Resultados obtenidos

| Concepto | Resultado |
|---|---:|
| Sueldo computable | S/ 2,500.00 |
| Asignación familiar | S/ 0.00 |
| Total remuneraciones | S/ 2,500.00 |
| ONP (13 %) | S/ 325.00 |
| Total descuentos | S/ 325.00 |
| EsSalud (9 %) | S/ 225.00 |
| **Neto a pagar** | **S/ 2,175.00** |

**Verificación:** el resultado obtenido en la aplicación coincide con el resultado esperado del caso 1 del laboratorio.

### Evidencia 1: Formulario de la aplicación

![Formulario del caso 1](capturas/caso1.png)

### Evidencia 2: Resultado de la boleta

![Resultado del caso 1](capturas/caso1_calculo.png)

## 8. Casos de prueba restantes

La actividad también contempla los siguientes escenarios:

| Caso | Descripción | Neto esperado |
|---|---|---:|
| 2 | ONP con hijos y 27 días laborados | S/ 1,516.41 |
| 3 | AFP Ejemplo, horas extras y adelanto | S/ 2,631.73 |
| 4 | AFP Ejemplo, 24 días laborados y adelanto | Pendiente de verificación |

Los casos 2, 3 y 4 quedan pendientes de documentar con los resultados y las evidencias obtenidas en el simulador.

## 9. Ejecución de la aplicación

1. Clonar el repositorio desde GitHub.
2. Abrir la carpeta `Laboratorio09/BoletaPago`.
3. Abrir `BoletaPago.xcodeproj` utilizando Xcode.
4. Seleccionar un simulador iOS disponible.
5. Ejecutar la aplicación mediante `Command + R`.
6. Ingresar los datos del trabajador.
7. Presionar el botón **CALCULAR BOLETA**.
8. Revisar las remuneraciones, descuentos, aportaciones y el neto a pagar.

## 10. Conclusión

Durante el desarrollo de este laboratorio implementé una aplicación móvil utilizando SwiftUI para calcular los principales conceptos de una boleta de pago.

Organicé la solución separando la interfaz gráfica de la lógica de negocio, utilicé estructuras y colecciones para representar los datos y agregué validaciones para controlar los valores ingresados.

En la primera prueba comprobé que el cálculo del neto a pagar coincide con el resultado proporcionado en la actividad.

La aplicación tiene fines exclusivamente académicos y presenta una boleta de ejemplo simplificada.
