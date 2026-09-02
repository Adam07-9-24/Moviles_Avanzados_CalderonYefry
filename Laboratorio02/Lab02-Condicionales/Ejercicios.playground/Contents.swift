import UIKit

// Docente: Juan León S.
// Laboratorio 02
// Estructuras Condicionales y Bucles
// Programación en Móviles Avanzado

// ===== EJERCICIO 6: CARRITO MEJORADO - IA =====

// --- Datos del carrito ---

let productoIA1 = "Laptop" // Guarda el nombre del primer producto.
let precioIA1 = 3500.0 // Guarda el precio unitario de la laptop.
let cantidadIA1 = 1 // Guarda la cantidad de laptops compradas.

let productoIA2 = "Mouse" // Guarda el nombre del segundo producto.
let precioIA2 = 45.50 // Guarda el precio unitario del mouse.
let cantidadIA2 = 2 // Guarda la cantidad de mouses comprados.

let productoIA3 = "Teclado" // Guarda el nombre del tercer producto.
let precioIA3 = 120.00 // Guarda el precio unitario del teclado.
let cantidadIA3 = 1 // Guarda la cantidad de teclados comprados.

let productoIA4 = "Monitor" // Guarda el nombre del cuarto producto.
let precioIA4 = 890.00 // Guarda el precio unitario del monitor.
let cantidadIA4 = 1 // Guarda la cantidad de monitores comprados.

let productoIA5 = "USB Cable" // Guarda el nombre del quinto producto.
let precioIA5 = 15.00 // Guarda el precio unitario del cable USB.
let cantidadIA5 = 3 // Guarda la cantidad de cables USB comprados.


// --- Validación de precios y cantidades ---

var datosValidosIA = true // Indica si todos los precios y cantidades permiten continuar.

if precioIA1 < 0 || precioIA2 < 0 || precioIA3 < 0 || precioIA4 < 0 || precioIA5 < 0 { // Comprueba si algún precio es negativo.
    datosValidosIA = false // Marca los datos como inválidos cuando encuentra un precio negativo.
} // Finaliza la validación de los precios.

if cantidadIA1 <= 0 || cantidadIA2 <= 0 || cantidadIA3 <= 0 || cantidadIA4 <= 0 || cantidadIA5 <= 0 { // Comprueba si alguna cantidad es igual o menor que cero.
    datosValidosIA = false // Marca los datos como inválidos cuando encuentra una cantidad no permitida.
} // Finaliza la validación de las cantidades.

if !datosValidosIA { // Comprueba si alguna validación anterior encontró un dato incorrecto.
    print("Error: precio o cantidad inválida") // Muestra el mensaje solicitado cuando el carrito tiene datos inválidos.
} // Finaliza la presentación del error de validación.

if datosValidosIA { // Permite realizar los cálculos solamente cuando todos los datos son válidos.

    // --- Subtotales y descuentos por cantidad ---

    let subtotalBaseIA1 = precioIA1 * Double(cantidadIA1) // Calcula el subtotal de la laptop antes del descuento por cantidad.
    let subtotalBaseIA2 = precioIA2 * Double(cantidadIA2) // Calcula el subtotal de los mouses antes del descuento por cantidad.
    let subtotalBaseIA3 = precioIA3 * Double(cantidadIA3) // Calcula el subtotal del teclado antes del descuento por cantidad.
    let subtotalBaseIA4 = precioIA4 * Double(cantidadIA4) // Calcula el subtotal del monitor antes del descuento por cantidad.
    let subtotalBaseIA5 = precioIA5 * Double(cantidadIA5) // Calcula el subtotal de los cables USB antes del descuento por cantidad.

    var descuentoCantidadIA1 = 0.0 // Inicia en cero el descuento por cantidad de la laptop.
    var descuentoCantidadIA2 = 0.0 // Inicia en cero el descuento por cantidad de los mouses.
    var descuentoCantidadIA3 = 0.0 // Inicia en cero el descuento por cantidad del teclado.
    var descuentoCantidadIA4 = 0.0 // Inicia en cero el descuento por cantidad del monitor.
    var descuentoCantidadIA5 = 0.0 // Inicia en cero el descuento por cantidad de los cables USB.

    if cantidadIA1 >= 3 { // Comprueba si la laptop alcanza las tres unidades requeridas para el descuento.
        descuentoCantidadIA1 = subtotalBaseIA1 * 0.05 // Calcula el 5% de descuento únicamente sobre el subtotal de la laptop.
    } // Finaliza la comprobación del descuento por cantidad de la laptop.

    if cantidadIA2 >= 3 { // Comprueba si el mouse alcanza las tres unidades requeridas para el descuento.
        descuentoCantidadIA2 = subtotalBaseIA2 * 0.05 // Calcula el 5% de descuento únicamente sobre el subtotal de los mouses.
    } // Finaliza la comprobación del descuento por cantidad de los mouses.

    if cantidadIA3 >= 3 { // Comprueba si el teclado alcanza las tres unidades requeridas para el descuento.
        descuentoCantidadIA3 = subtotalBaseIA3 * 0.05 // Calcula el 5% de descuento únicamente sobre el subtotal del teclado.
    } // Finaliza la comprobación del descuento por cantidad del teclado.

    if cantidadIA4 >= 3 { // Comprueba si el monitor alcanza las tres unidades requeridas para el descuento.
        descuentoCantidadIA4 = subtotalBaseIA4 * 0.05 // Calcula el 5% de descuento únicamente sobre el subtotal del monitor.
    } // Finaliza la comprobación del descuento por cantidad del monitor.

    if cantidadIA5 >= 3 { // Comprueba si el cable USB alcanza las tres unidades requeridas para el descuento.
        descuentoCantidadIA5 = subtotalBaseIA5 * 0.05 // Calcula el 5% de descuento únicamente sobre el subtotal de los cables USB.
    } // Finaliza la comprobación del descuento por cantidad de los cables USB.

    let subtotalIA1 = subtotalBaseIA1 - descuentoCantidadIA1 // Obtiene el subtotal final de la laptop después de su descuento por cantidad.
    let subtotalIA2 = subtotalBaseIA2 - descuentoCantidadIA2 // Obtiene el subtotal final de los mouses después de su descuento por cantidad.
    let subtotalIA3 = subtotalBaseIA3 - descuentoCantidadIA3 // Obtiene el subtotal final del teclado después de su descuento por cantidad.
    let subtotalIA4 = subtotalBaseIA4 - descuentoCantidadIA4 // Obtiene el subtotal final del monitor después de su descuento por cantidad.
    let subtotalIA5 = subtotalBaseIA5 - descuentoCantidadIA5 // Obtiene el subtotal final de los cables USB después de su descuento por cantidad.

    let subtotalProductosIA = subtotalIA1 + subtotalIA2 + subtotalIA3 + subtotalIA4 + subtotalIA5 // Suma los subtotales de productos después de aplicar descuentos por cantidad.


    // --- Cupón de descuento ---

    let cupon = "DESCUENTO20" // Guarda el código de cupón que se validará.
    var descuentoCuponIA = 0.0 // Inicia en cero el descuento que puede otorgar el cupón.

    if cupon == "DESCUENTO20" { // Comprueba si el cupón ingresado corresponde al cupón válido.
        descuentoCuponIA = subtotalProductosIA * 0.20 // Calcula el 20% de descuento sobre el subtotal de productos.
    } // Finaliza la validación y aplicación del cupón.

    let totalDespuesCuponIA = subtotalProductosIA - descuentoCuponIA // Resta el descuento del cupón al subtotal de productos.


    // --- Costo de envío ---

    var costoEnvioIA = 25.00 // Establece en 25 soles el costo inicial del envío.

    if totalDespuesCuponIA > 3000 { // Comprueba si el total después del cupón supera los 3000 soles.
        costoEnvioIA = 0.0 // Cambia el costo de envío a cero porque la compra obtiene envío gratis.
    } // Finaliza la comprobación del envío gratuito.

    let totalFinalIA = totalDespuesCuponIA + costoEnvioIA // Suma el costo de envío al total después del cupón.


    // --- Puntos de fidelidad ---

    let puntosFidelidadIA = Int(totalFinalIA / 100.0) // Divide el total entre 100 y lo convierte a Int para conservar solamente los puntos completos.


    // --- Ticket final ---

    var separadorIA = "" // Crea una cadena vacía para construir la línea separadora del ticket.

    for _ in 1...40 { // Repite cuarenta veces la construcción del separador.
        separadorIA += "=" // Agrega un signo igual en cada repetición del bucle.
    } // Finaliza el bucle que construye el separador.

    print(separadorIA) // Imprime la primera línea separadora del ticket.
    print(" CARRITO MEJORADO - IA") // Imprime el título del ticket del carrito mejorado.
    print(separadorIA) // Imprime una línea que separa el título de los productos.

    print("\(productoIA1) x\(cantidadIA1): S/. \(subtotalBaseIA1)") // Imprime la cantidad y el subtotal base de la laptop.
    if descuentoCantidadIA1 > 0 { // Comprueba si la laptop recibió descuento por cantidad para mostrarlo.
        print("Descuento por cantidad: -S/. \(descuentoCantidadIA1)") // Imprime el descuento por cantidad aplicado a la laptop.
        print("Subtotal con descuento: S/. \(subtotalIA1)") // Imprime el subtotal final de la laptop después del descuento.
    } // Finaliza la impresión opcional del descuento de la laptop.

    print("\(productoIA2) x\(cantidadIA2): S/. \(subtotalBaseIA2)") // Imprime la cantidad y el subtotal base de los mouses.
    if descuentoCantidadIA2 > 0 { // Comprueba si los mouses recibieron descuento por cantidad para mostrarlo.
        print("Descuento por cantidad: -S/. \(descuentoCantidadIA2)") // Imprime el descuento por cantidad aplicado a los mouses.
        print("Subtotal con descuento: S/. \(subtotalIA2)") // Imprime el subtotal final de los mouses después del descuento.
    } // Finaliza la impresión opcional del descuento de los mouses.

    print("\(productoIA3) x\(cantidadIA3): S/. \(subtotalBaseIA3)") // Imprime la cantidad y el subtotal base del teclado.
    if descuentoCantidadIA3 > 0 { // Comprueba si el teclado recibió descuento por cantidad para mostrarlo.
        print("Descuento por cantidad: -S/. \(descuentoCantidadIA3)") // Imprime el descuento por cantidad aplicado al teclado.
        print("Subtotal con descuento: S/. \(subtotalIA3)") // Imprime el subtotal final del teclado después del descuento.
    } // Finaliza la impresión opcional del descuento del teclado.

    print("\(productoIA4) x\(cantidadIA4): S/. \(subtotalBaseIA4)") // Imprime la cantidad y el subtotal base del monitor.
    if descuentoCantidadIA4 > 0 { // Comprueba si el monitor recibió descuento por cantidad para mostrarlo.
        print("Descuento por cantidad: -S/. \(descuentoCantidadIA4)") // Imprime el descuento por cantidad aplicado al monitor.
        print("Subtotal con descuento: S/. \(subtotalIA4)") // Imprime el subtotal final del monitor después del descuento.
    } // Finaliza la impresión opcional del descuento del monitor.

    print("\(productoIA5) x\(cantidadIA5): S/. \(subtotalBaseIA5)") // Imprime la cantidad y el subtotal base de los cables USB.
    if descuentoCantidadIA5 > 0 { // Comprueba si los cables USB recibieron descuento por cantidad para mostrarlo.
        print("Descuento por cantidad: -S/. \(descuentoCantidadIA5)") // Imprime el descuento por cantidad aplicado a los cables USB.
        print("Subtotal con descuento: S/. \(subtotalIA5)") // Imprime el subtotal final de los cables USB después del descuento.
    } // Finaliza la impresión opcional del descuento de los cables USB.

    print(separadorIA) // Imprime una línea antes del resumen de importes.
    print("Subtotal de productos: S/. \(subtotalProductosIA)") // Imprime la suma de productos después de los descuentos por cantidad.
    print("Descuento por cupón: -S/. \(descuentoCuponIA)") // Imprime el descuento obtenido mediante el cupón válido.
    print("Total después del cupón: S/. \(totalDespuesCuponIA)") // Imprime el total después de restar el descuento del cupón.
    print("Costo de envío: S/. \(costoEnvioIA)") // Imprime el costo de envío calculado según el total de la compra.
    print(separadorIA) // Imprime una línea antes de presentar el total final.
    print("TOTAL FINAL: S/. \(totalFinalIA)") // Imprime el monto final que debe pagar el cliente.
    print("Puntos de fidelidad: \(puntosFidelidadIA)") // Imprime los puntos completos obtenidos por la compra.
    print(separadorIA) // Imprime la última línea separadora del ticket.
} // Finaliza los cálculos y el ticket ejecutados cuando los datos son válidos.


// ===== EJERCICIO 7: JUEGO DE ADIVINANZA - IA =====

let numeroSecretoIA = 42 // Guarda el número fijo que el jugador debe adivinar.

let intentoIA1 = 20 // Guarda el valor que se probará en el primer intento.
let intentoIA2 = 50 // Guarda el valor que se probará en el segundo intento.
let intentoIA3 = 35 // Guarda el valor que se probará en el tercer intento.
let intentoIA4 = 42 // Guarda el valor que se probará en el cuarto intento.
let intentoIA5 = 60 // Guarda el valor que se probaría en el quinto intento.

var numeroIntentoIA = 1 // Lleva la cuenta del intento que se está realizando.
var intentoActualIA = intentoIA1 // Guarda el valor que se comparará con el número secreto.
var encontradoIA = false // Indica si alguno de los intentos acertó el número secreto.

while numeroIntentoIA <= 5 && !encontradoIA { // Repite mientras queden intentos y todavía no se haya acertado.
    if numeroIntentoIA == 1 { // Comprueba si corresponde cargar el valor del primer intento.
        intentoActualIA = intentoIA1 // Coloca el primer valor simulado como intento actual.
    } else if numeroIntentoIA == 2 { // Comprueba si corresponde cargar el valor del segundo intento.
        intentoActualIA = intentoIA2 // Coloca el segundo valor simulado como intento actual.
    } else if numeroIntentoIA == 3 { // Comprueba si corresponde cargar el valor del tercer intento.
        intentoActualIA = intentoIA3 // Coloca el tercer valor simulado como intento actual.
    } else if numeroIntentoIA == 4 { // Comprueba si corresponde cargar el valor del cuarto intento.
        intentoActualIA = intentoIA4 // Coloca el cuarto valor simulado como intento actual.
    } else if numeroIntentoIA == 5 { // Comprueba si corresponde cargar el valor del quinto intento.
        intentoActualIA = intentoIA5 // Coloca el quinto valor simulado como intento actual.
    } // Finaliza la selección del valor correspondiente al intento actual.

    print("Intento \(numeroIntentoIA): \(intentoActualIA)") // Muestra el número de intento y el valor que se está probando.

    if intentoActualIA > numeroSecretoIA { // Comprueba si el valor probado es mayor que el número secreto.
        print("Muy alto") // Informa que el jugador debe probar con un número menor.
    } else if intentoActualIA < numeroSecretoIA { // Comprueba si el valor probado es menor que el número secreto.
        print("Muy bajo") // Informa que el jugador debe probar con un número mayor.
    } else { // Se ejecuta cuando el intento actual es igual al número secreto.
        print("¡Correcto!") // Informa que el jugador encontró el número secreto.
        encontradoIA = true // Marca el número secreto como encontrado para detener el while.
        print("Adivinaste en \(numeroIntentoIA) intentos") // Muestra cuántos intentos se necesitaron para acertar.
    } // Finaliza la comparación entre el intento actual y el número secreto.

    if !encontradoIA { // Comprueba si todavía es necesario avanzar al siguiente intento.
        numeroIntentoIA += 1 // Incrementa en uno el contador para continuar con el próximo intento.
    } // Finaliza la actualización del contador de intentos.
} // Finaliza el while cuando se acierta o se terminan los cinco intentos.

if !encontradoIA { // Comprueba después del while si ninguno de los cinco intentos fue correcto.
    print("Perdiste. El número era: \(numeroSecretoIA)") // Muestra el número secreto cuando el jugador agota sus intentos.
} // Finaliza la comprobación del caso de pérdida.
