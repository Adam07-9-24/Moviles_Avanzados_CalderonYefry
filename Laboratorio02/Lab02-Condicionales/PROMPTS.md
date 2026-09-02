# Prompts utilizados — Laboratorio 02

## Herramienta de IA utilizada

ChatGPT + Codex


## Ejercicio 6 — Carrito mejorado

### Prompt (estructura CTRFE)

**CONTEXTO:**

Eres un desarrollador experto en Swift, especializado en crear código claro, sencillo y fácil de entender para estudiantes que recién están aprendiendo programación móvil.

Debes trabajar con un carrito de compras básico desarrollado previamente en Swift y mejorarlo sin utilizar conceptos demasiado avanzados.

**TAREA:**

Mejora el carrito de compras implementando las siguientes funcionalidades:

- Aplicar 5% de descuento a un producto si se compran 3 o más unidades del mismo producto.
- Aplicar 20% de descuento adicional si el cupón es "DESCUENTO20".
- Aplicar envío gratis si el total supera S/. 3000; caso contrario, cobrar S/. 25.
- Calcular 1 punto de fidelidad por cada S/. 100 de compra.
- Validar que los precios no sean negativos y que las cantidades sean mayores que cero.
- Mostrar un ticket final con los resultados.

**RESTRICCIONES:**

- Utiliza Swift.
- Mantén el código sencillo y fácil de explicar.
- Usa principalmente variables, condicionales y bucles.
- No uses clases.
- No uses structs.
- No uses programación orientada a objetos.
- No uses conceptos innecesariamente avanzados.
- Mantén los mismos productos del carrito original.
- Comenta cada línea de código explicando específicamente qué hace.
- No utilices comentarios genéricos.

**FORMATO:**

Entrega el código Swift organizado y separado en:

- Datos del carrito.
- Validación.
- Descuentos por cantidad.
- Cupón de descuento.
- Costo de envío.
- Puntos de fidelidad.
- Ticket final.

Cada línea de código debe contener un comentario explicativo.

**EJEMPLO:**

let cupon = "DESCUENTO20" // Guarda el código del cupón que se validará.

if cupon == "DESCUENTO20" { // Comprueba si el cupón corresponde al código válido.
    // Aquí se aplica el descuento correspondiente.
}

### ¿Funcionó a la primera?

Sí. La solución implementó correctamente las cinco funcionalidades solicitadas. También revisé los cálculos antes de guardar el ejercicio y confirmé que el descuento por cantidad se aplicaba únicamente al producto que cumplía la condición.

### ¿La IA usó algo que no conocías?

Sí. Aprendí mejor cómo convertir un valor Double a Int para obtener solamente los puntos completos de fidelidad:

Int(totalFinal / 100.0)

También reforcé el uso del operador || para comprobar varias condiciones.


---

## Ejercicio 7 — Juego de adivinanza

### Prompt (estructura CTRFE)

**CONTEXTO:**

Eres un desarrollador experto en Swift, especializado en crear ejemplos sencillos para estudiantes que están aprendiendo condicionales y bucles.

Debes crear un pequeño juego de adivinanza manteniendo una lógica fácil de leer y explicar.

**TAREA:**

Crea un juego de adivinanza que tenga:

- Un número secreto fijo igual a 42.
- Cinco intentos simulados mediante variables.
- Un bucle while para controlar los intentos.
- Comparaciones que indiquen "Muy alto", "Muy bajo" o "¡Correcto!".
- Un contador que indique cuántos intentos fueron necesarios.
- Un mensaje de pérdida si ninguno de los cinco intentos acierta.

Utiliza estos intentos:

20
50
35
42
60

**RESTRICCIONES:**

- Utiliza Swift.
- No uses arrays.
- No uses funciones.
- No uses clases.
- No uses structs.
- No uses números aleatorios.
- Utiliza while para controlar los intentos.
- Utiliza if / else if / else para realizar las comparaciones.
- Mantén exactamente cinco intentos simulados.
- Comenta cada línea del código explicando específicamente qué hace.
- Mantén la solución sencilla y fácil de entender.

**FORMATO:**

Entrega código Swift que muestre:

- Número del intento.
- Valor probado.
- Resultado de la comparación.
- Cantidad de intentos utilizados.
- Mensaje de pérdida si corresponde.

Cada línea de código debe contener un comentario explicativo.

**EJEMPLO:**

let numeroSecretoIA = 42 // Guarda el número fijo que el jugador debe adivinar.

if intentoActualIA > numeroSecretoIA { // Comprueba si el intento es mayor al número secreto.
    print("Muy alto") // Indica que se debe intentar con un número menor.
}

### ¿Funcionó a la primera?

Sí. El juego recorrió correctamente los intentos y encontró el número 42 en el cuarto intento. También se incluyó el mensaje de pérdida para el caso en que ninguno de los cinco valores sea correcto.

### ¿La IA usó algo que no conocías?

Sí. Reforcé cómo combinar dos condiciones dentro de un while:

numeroIntentoIA <= 5 && !encontradoIA

Esto permite que el bucle continúe solamente mientras queden intentos disponibles y todavía no se haya encontrado el número secreto.
