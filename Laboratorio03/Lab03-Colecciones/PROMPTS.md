# Prompts — Lab 03

## Docente

Juan Leon — Tecsup

## Herramienta

ChatGPT + Codex

---

## Ejercicio 6 — Gestión de notas

### Prompt (CTRFE)

**CONTEXTO:**
Soy estudiante de Programación en Móviles Avanzado, semana 3. Estoy trabajando Swift con colecciones, condicionales, bucles, readLine(), Arrays, Diccionarios, Sets y switch. El ejercicio debe mantenerse dentro de los conceptos vistos hasta esta semana.

**TAREA:**
Crear un sistema de gestión de notas que:
- Pida N alumnos.
- Pida nombre y exactamente 3 notas por alumno.
- Guarde los datos en un diccionario [String: [Double]].
- Calcule el promedio de cada alumno.
- Clasifique con switch en Excelente, Bueno, Aprobado o Desaprobado.
- Calcule promedio general.
- Obtenga nota más alta y nota más baja.
- Calcule porcentaje de aprobados.
- Ordene los alumnos por promedio.

**RESTRICCIONES:**
- No usar struct.
- No usar class.
- No usar programación orientada a objetos.
- No usar librerías externas.
- Usar únicamente conceptos simples vistos hasta semana 3.
- La cantidad de alumnos debe ser mayor que 0.
- Los nombres no pueden estar vacíos ni repetidos.
- Las notas deben ser numéricas y estar entre 0 y 20.
- Cada alumno debe tener exactamente 3 notas.
- Considerar aprobado un promedio >= 13.
- Usar switch para la clasificación.
- No modificar otros ejercicios.
- No hacer git add, commit ni push.

**FORMATO:**
- Código Swift compatible con Playground.
- Header:
  // Desarrollado por: Calderon Yefry
- Comentar CADA línea del código con un comentario específico.
- Mostrar resultados por alumno y estadísticas generales de forma entendible.

**EJEMPLO:**
Ana: 18, 19, 20 → Promedio 19 → Excelente
Luis: 15, 16, 17 → Promedio 16 → Bueno
Carlos: 10, 11, 12 → Promedio 11 → Desaprobado

---

## Ejercicio 7 — Inventario con menú

### Prompt (CTRFE)

**CONTEXTO:**
Soy estudiante de Programación en Móviles Avanzado, semana 3. Estoy trabajando Swift con colecciones, Diccionarios, while, for, if, switch y readLine(). El ejercicio debe utilizar solamente conceptos vistos hasta esta semana.

**TAREA:**
Crear un inventario que:
- Pida N productos.
- Pida nombre, precio y stock de cada producto.
- Guarde precio y stock usando diccionarios.
- Implemente un menú while con:
  1. Ver inventario
  2. Buscar producto
  3. Ver productos con stock bajo
  4. Ver valor total del inventario
  5. Salir
- Considere stock bajo cuando stock < 5.
- Calcule el valor total usando precio × stock.
- Mantenga el menú activo hasta seleccionar Salir.

**RESTRICCIONES:**
- No usar struct.
- No usar class.
- No usar programación orientada a objetos.
- No usar librerías externas.
- La cantidad de productos debe ser mayor que 0.
- Los nombres no pueden estar vacíos ni repetidos.
- El precio debe ser numérico y >= 0.
- El stock debe ser entero y >= 0.
- Las opciones inválidas del menú deben mostrar un mensaje y volver al menú.
- No modificar el Ejercicio 6.
- No hacer git add, commit ni push.

**FORMATO:**
- Código Swift compatible con Playground.
- Header:
  // Desarrollado por: Calderon Yefry
- Comentar CADA línea con un comentario específico.
- Mostrar reportes claros y formateados para inventario, búsqueda, stock bajo y valor total.

**EJEMPLO:**
Laptop → Precio: 3500, Stock: 2
Mouse → Precio: 45.5, Stock: 10
Teclado → Precio: 100, Stock: 4

Stock bajo:
Laptop: 2
Teclado: 4

Valor total:
3500 × 2 + 45.5 × 10 + 100 × 4 = S/. 7855.0
