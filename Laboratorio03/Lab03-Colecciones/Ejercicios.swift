// Laboratorio 03 - Colecciones
// Desarrollado por: Calderon Yefry
// Programación en Móviles Avanzado

// Desarrollado por: Calderon Yefry
// ===== EJERCICIO 6: Gestión de Notas — con IA =====
do { // Crea un ámbito independiente para las variables del Ejercicio 6.
    var cantidadAlumnos = 0 // Guarda una cantidad inicial inválida para activar la validación.

    while cantidadAlumnos <= 0 { // Repite la solicitud hasta recibir una cantidad mayor que cero.
        print("¿Cuántos alumnos desea registrar?") // Solicita la cantidad de alumnos que se registrarán.
        let entradaCantidad = readLine() ?? "" // Lee la cantidad escrita o usa una cadena vacía si no hay entrada.

        if let cantidadValida = Int(entradaCantidad), cantidadValida > 0 { // Comprueba que la entrada sea un entero positivo.
            cantidadAlumnos = cantidadValida // Guarda la cantidad validada para terminar la repetición.
        } else { // Atiende cualquier entrada no numérica, igual a cero o negativa.
            print("Cantidad inválida. Ingrese un número mayor que 0.") // Informa por qué debe volver a ingresar la cantidad.
        } // Cierra la validación de la cantidad ingresada.
    } // Cierra el ciclo que garantiza una cantidad válida de alumnos.

    var notasPorAlumno: [String: [Double]] = [:] // Relaciona cada nombre de alumno con su arreglo de tres notas.

    for numeroAlumno in 1...cantidadAlumnos { // Repite el registro una vez por cada alumno solicitado.
        var nombreAlumno = "" // Prepara una cadena vacía para validar el nombre del alumno actual.

        while nombreAlumno.isEmpty { // Repite la solicitud mientras no exista un nombre válido y único.
            print("Alumno \(numeroAlumno) - Nombre:") // Solicita el nombre correspondiente al alumno actual.
            let nombreIngresado = readLine() ?? "" // Lee el nombre o utiliza una cadena vacía si no hay entrada.

            if nombreIngresado.isEmpty { // Detecta cuando el usuario no escribió ningún nombre.
                print("Nombre inválido. No puede quedar vacío.") // Explica que se debe ingresar un nombre no vacío.
            } else if notasPorAlumno[nombreIngresado] != nil { // Detecta un nombre que ya es clave del diccionario.
                print("Nombre repetido. Ingrese un alumno diferente.") // Evita reemplazar las notas de un alumno registrado.
            } else { // Atiende un nombre no vacío que todavía no existe en el diccionario.
                nombreAlumno = nombreIngresado // Conserva el nombre validado para registrar sus notas.
            } // Cierra la validación del nombre ingresado.
        } // Cierra el ciclo que garantiza un nombre válido y único.

        var notas: [Double] = [] // Crea el arreglo que almacenará exactamente tres notas del alumno.

        for numeroNota in 1...3 { // Solicita exactamente tres notas para el alumno actual.
            var notaValida = false // Indica que todavía no se ha recibido una nota aceptable.
            var notaIngresada = 0.0 // Reserva el valor que guardará la nota después de validarla.

            while !notaValida { // Repite la solicitud hasta recibir un número entre cero y veinte.
                print("Nota \(numeroNota) de \(nombreAlumno):") // Solicita una nota específica del alumno actual.
                let entradaNota = readLine() ?? "" // Lee la nota escrita o usa una cadena vacía si no hay entrada.

                if let valorNota = Double(entradaNota), valorNota >= 0 && valorNota <= 20 { // Valida que la nota sea numérica y pertenezca al rango permitido.
                    notaIngresada = valorNota // Guarda la nota que superó todas las validaciones.
                    notaValida = true // Marca la nota como válida para finalizar la repetición.
                } else { // Atiende una entrada no numérica o fuera del intervalo de cero a veinte.
                    print("Nota inválida. Ingrese un número entre 0 y 20.") // Informa el rango correcto antes de volver a pedir la nota.
                } // Cierra la validación de la nota ingresada.
            } // Cierra el ciclo que garantiza una nota válida.

            notas.append(notaIngresada) // Agrega una única nota validada al arreglo del alumno.
        } // Cierra el ciclo después de almacenar exactamente tres notas.

        notasPorAlumno[nombreAlumno] = notas // Guarda el nombre y sus tres notas en el diccionario principal.
    } // Cierra el registro de todos los alumnos solicitados.

    var promediosPorAlumno: [String: Double] = [:] // Almacena el promedio calculado para cada alumno.
    var sumaPromedios = 0.0 // Acumula los promedios individuales para obtener el promedio general.
    var notaMasAlta = 0.0 // Conserva la mayor nota registrada comenzando desde el mínimo permitido.
    var notaMasBaja = 20.0 // Conserva la menor nota registrada comenzando desde el máximo permitido.
    var cantidadAprobados = 0 // Cuenta alumnos cuyo promedio es mayor o igual que trece.

    print("===== RESULTADOS POR ALUMNO =====") // Presenta el encabezado de los resultados individuales.

    for (nombre, notasAlumno) in notasPorAlumno { // Recorre cada alumno junto con sus tres notas almacenadas.
        var sumaAlumno = 0.0 // Inicia la suma de notas del alumno actual.

        for nota in notasAlumno { // Recorre cada una de las tres notas del alumno actual.
            sumaAlumno += nota // Acumula la nota para calcular el promedio individual.

            if nota > notaMasAlta { // Comprueba si la nota actual supera la mayor registrada.
                notaMasAlta = nota // Actualiza la nota más alta con el nuevo máximo.
            } // Cierra la comparación de la nota más alta.

            if nota < notaMasBaja { // Comprueba si la nota actual es menor que la mínima registrada.
                notaMasBaja = nota // Actualiza la nota más baja con el nuevo mínimo.
            } // Cierra la comparación de la nota más baja.
        } // Cierra el recorrido de las notas del alumno actual.

        var promedioAlumno = 0.0 // Prepara el promedio individual con un valor seguro inicial.

        if !notasAlumno.isEmpty { // Verifica que existan notas antes de realizar una división.
            promedioAlumno = sumaAlumno / Double(notasAlumno.count) // Divide la suma entre la cantidad real de notas del alumno.
        } // Cierra la protección contra una división entre cero.

        var clasificacion = "" // Prepara el texto que describirá el rendimiento del alumno.

        switch promedioAlumno { // Selecciona la clasificación según el promedio calculado.
        case 18...20: // Reconoce los promedios desde dieciocho hasta veinte inclusive.
            clasificacion = "Excelente" // Asigna la clasificación más alta al promedio.
        case 15..<18: // Reconoce los promedios desde quince hasta menos de dieciocho.
            clasificacion = "Bueno" // Asigna la clasificación buena al promedio.
        case 13..<15: // Reconoce los promedios desde trece hasta menos de quince.
            clasificacion = "Aprobado" // Asigna la clasificación aprobatoria básica al promedio.
        case 0..<13: // Reconoce los promedios desde cero hasta menos de trece.
            clasificacion = "Desaprobado" // Asigna la clasificación desaprobatoria al promedio.
        default: // Mantiene el switch completo ante un promedio fuera del rango validado.
            clasificacion = "Desaprobado" // Usa una clasificación segura para el caso que no debería ocurrir.
        } // Cierra la selección de la clasificación del alumno.

        promediosPorAlumno[nombre] = promedioAlumno // Relaciona el alumno con su promedio para ordenarlo después.
        sumaPromedios += promedioAlumno // Acumula el promedio individual para la estadística general.

        if promedioAlumno >= 13 { // Comprueba si el alumno alcanza el promedio mínimo aprobatorio.
            cantidadAprobados += 1 // Incrementa el número de alumnos aprobados.
        } // Cierra la comprobación del estado aprobatorio.

        print("Alumno: \(nombre)") // Muestra el nombre del alumno procesado.
        print("Notas: \(notasAlumno)") // Muestra las tres notas registradas para el alumno.
        print("Promedio: \(promedioAlumno)") // Muestra el promedio obtenido por el alumno.
        print("Clasificación: \(clasificacion)") // Muestra la categoría asignada mediante el switch.
    } // Cierra el recorrido de resultados individuales.

    var promedioGeneral = 0.0 // Prepara el resultado del promedio de todos los alumnos.
    var porcentajeAprobados = 0.0 // Prepara el porcentaje de alumnos con promedio aprobatorio.

    if !notasPorAlumno.isEmpty { // Confirma que existen alumnos antes de calcular estadísticas con división.
        promedioGeneral = sumaPromedios / Double(notasPorAlumno.count) // Calcula el promedio de los promedios individuales.
        porcentajeAprobados = Double(cantidadAprobados) / Double(notasPorAlumno.count) * 100 // Convierte la proporción de aprobados en porcentaje.
    } // Cierra la protección de las divisiones estadísticas.

    print("===== ESTADÍSTICAS =====") // Presenta el encabezado del resumen estadístico.
    print("Promedio general: \(promedioGeneral)") // Muestra el promedio de todos los alumnos registrados.
    print("Nota más alta registrada: \(notaMasAlta)") // Muestra la nota máxima encontrada entre todas las notas.
    print("Nota más baja registrada: \(notaMasBaja)") // Muestra la nota mínima encontrada entre todas las notas.
    print("Porcentaje de alumnos aprobados: \(porcentajeAprobados)%") // Muestra qué porcentaje obtuvo promedio mayor o igual que trece.

    let alumnosOrdenados = promediosPorAlumno.sorted { $0.value > $1.value } // Ordena los pares del diccionario desde el promedio mayor al menor.

    print("===== ALUMNOS ORDENADOS POR PROMEDIO =====") // Presenta el encabezado de la lista ordenada.

    for (nombre, promedio) in alumnosOrdenados { // Recorre los alumnos en el orden descendente obtenido.
        print("\(nombre): \(promedio)") // Muestra cada nombre junto con su promedio ya ordenado.
    } // Cierra el recorrido de la lista ordenada.
} // Cierra el ámbito independiente del Ejercicio 6.

// Desarrollado por: Calderon Yefry
// ===== EJERCICIO 7: Inventario con menú — con IA =====
do { // Crea un ámbito independiente para las variables del Ejercicio 7.
    var cantidadProductos = 0 // Guarda una cantidad inicial inválida para activar la validación.

    while cantidadProductos <= 0 { // Repite la solicitud hasta recibir una cantidad mayor que cero.
        print("¿Cuántos productos desea registrar?") // Solicita el número de productos del inventario.
        let entradaCantidad = readLine() ?? "" // Lee la cantidad escrita o usa una cadena vacía si no hay entrada.

        if let cantidadValida = Int(entradaCantidad), cantidadValida > 0 { // Comprueba que la entrada sea un entero positivo.
            cantidadProductos = cantidadValida // Conserva la cantidad válida para terminar la repetición.
        } else { // Atiende texto, cero, números negativos o una entrada vacía.
            print("Cantidad inválida. Ingrese un número mayor que 0.") // Explica la condición necesaria para continuar.
        } // Cierra la validación de la cantidad ingresada.
    } // Cierra el ciclo que garantiza una cantidad válida de productos.

    var preciosInventario: [String: Double] = [:] // Relaciona cada nombre de producto con su precio.
    var stocksInventario: [String: Int] = [:] // Relaciona cada nombre de producto con su cantidad disponible.

    for numeroProducto in 1...cantidadProductos { // Repite el registro para cada producto solicitado.
        var nombreProducto = "" // Prepara una cadena vacía para validar el nombre del producto actual.

        while nombreProducto.isEmpty { // Repite la solicitud hasta recibir un nombre no vacío y no repetido.
            print("Producto \(numeroProducto) - Nombre:") // Solicita el nombre del producto actual.
            let nombreIngresado = readLine() ?? "" // Lee el nombre o usa una cadena vacía si no hay entrada.

            if nombreIngresado.isEmpty { // Detecta cuando no se escribió ningún nombre.
                print("Nombre inválido. No puede quedar vacío.") // Informa que el nombre es obligatorio.
            } else if preciosInventario[nombreIngresado] != nil { // Comprueba si el nombre ya está registrado como clave.
                print("Producto repetido. Ingrese un nombre diferente.") // Evita reemplazar un producto existente.
            } else { // Atiende un nombre válido que todavía no existe en el inventario.
                nombreProducto = nombreIngresado // Guarda el nombre validado del producto actual.
            } // Cierra la validación del nombre ingresado.
        } // Cierra el ciclo que garantiza un nombre válido y único.

        var precioProducto = 0.0 // Reserva el precio que se almacenará después de validarlo.
        var precioValido = false // Indica que todavía no se ha recibido un precio aceptable.

        while !precioValido { // Repite la solicitud hasta recibir un precio numérico no negativo.
            print("Precio de \(nombreProducto):") // Solicita el precio del producto cuyo nombre fue validado.
            let entradaPrecio = readLine() ?? "" // Lee el precio o usa una cadena vacía si no hay entrada.

            if let precioIngresado = Double(entradaPrecio), precioIngresado >= 0 { // Valida que el precio sea numérico y mayor o igual que cero.
                precioProducto = precioIngresado // Guarda el precio que cumple la condición requerida.
                precioValido = true // Marca el precio como válido para finalizar la repetición.
            } else { // Atiende texto, una entrada vacía o un precio negativo.
                print("Precio inválido. Ingrese un número mayor o igual que 0.") // Informa el rango permitido para el precio.
            } // Cierra la validación del precio ingresado.
        } // Cierra el ciclo que garantiza un precio válido.

        var stockProducto = 0 // Reserva el stock que se almacenará después de validarlo.
        var stockValido = false // Indica que todavía no se ha recibido un stock aceptable.

        while !stockValido { // Repite la solicitud hasta recibir un stock entero no negativo.
            print("Stock de \(nombreProducto):") // Solicita la cantidad disponible del producto actual.
            let entradaStock = readLine() ?? "" // Lee el stock o usa una cadena vacía si no hay entrada.

            if let stockIngresado = Int(entradaStock), stockIngresado >= 0 { // Valida que el stock sea un entero mayor o igual que cero.
                stockProducto = stockIngresado // Guarda el stock que cumple la condición requerida.
                stockValido = true // Marca el stock como válido para finalizar la repetición.
            } else { // Atiende texto, decimales, entradas vacías o números negativos.
                print("Stock inválido. Ingrese un entero mayor o igual que 0.") // Informa el tipo y rango permitidos para el stock.
            } // Cierra la validación del stock ingresado.
        } // Cierra el ciclo que garantiza un stock válido.

        preciosInventario[nombreProducto] = precioProducto // Guarda el precio usando el nombre como clave.
        stocksInventario[nombreProducto] = stockProducto // Guarda el stock usando la misma clave del producto.
    } // Cierra el registro de todos los productos solicitados.

    var opcionMenu = 0 // Inicia el menú con una opción distinta de salir.

    while opcionMenu != 5 { // Mantiene activo el menú hasta que el usuario elija la opción cinco.
        print("===== MENÚ DE INVENTARIO =====") // Muestra el encabezado principal del menú.
        print("1. Ver inventario") // Presenta la opción que lista todos los productos.
        print("2. Buscar producto") // Presenta la opción que consulta un producto por nombre.
        print("3. Ver productos con stock bajo") // Presenta la opción que filtra stocks menores que cinco.
        print("4. Ver valor total del inventario") // Presenta la opción que calcula el valor acumulado.
        print("5. Salir") // Presenta la opción que termina el menú.
        print("Seleccione una opción:") // Solicita al usuario una de las cinco opciones disponibles.
        let entradaOpcion = readLine() ?? "" // Lee la opción o usa una cadena vacía si no hay entrada.

        if let opcionValida = Int(entradaOpcion) { // Comprueba si la opción ingresada puede convertirse en entero.
            opcionMenu = opcionValida // Guarda el entero para procesarlo con el switch.
        } else { // Atiende texto o una entrada vacía en el menú.
            opcionMenu = 0 // Asigna un valor inválido controlado para mostrar el mensaje correspondiente.
        } // Cierra la conversión de la opción del menú.

        switch opcionMenu { // Ejecuta la operación relacionada con la opción elegida.
        case 1: // Atiende la solicitud de mostrar todo el inventario.
            print("===== INVENTARIO =====") // Presenta el encabezado del reporte completo.
            print("Nombre | Precio | Stock") // Muestra los títulos de las columnas del inventario.

            for (nombre, precio) in preciosInventario { // Recorre cada producto junto con su precio almacenado.
                if let stock = stocksInventario[nombre] { // Obtiene el stock asociado usando el mismo nombre como clave.
                    print("\(nombre) | S/. \(precio) | \(stock)") // Muestra nombre, precio y stock en una línea formateada.
                } // Cierra la obtención segura del stock del producto.
            } // Cierra el recorrido de todos los productos del inventario.
        case 2: // Atiende la solicitud de buscar un producto específico.
            print("Nombre del producto que desea buscar:") // Solicita el nombre exacto que se consultará.
            let productoBuscado = readLine() ?? "" // Lee el nombre buscado o usa una cadena vacía si no hay entrada.

            if let precioEncontrado = preciosInventario[productoBuscado], let stockEncontrado = stocksInventario[productoBuscado] { // Obtiene el precio y stock cuando el nombre existe.
                print("===== PRODUCTO ENCONTRADO =====") // Presenta el encabezado del resultado exitoso.
                print("Nombre: \(productoBuscado)") // Muestra el nombre del producto encontrado.
                print("Precio: S/. \(precioEncontrado)") // Muestra el precio asociado al producto encontrado.
                print("Stock: \(stockEncontrado)") // Muestra la cantidad disponible del producto encontrado.
            } else { // Atiende un nombre que no existe en los diccionarios.
                print("Producto no encontrado") // Informa que la búsqueda no produjo coincidencias.
            } // Cierra la búsqueda segura del producto.
        case 3: // Atiende la solicitud de mostrar productos con stock bajo.
            print("===== PRODUCTOS CON STOCK BAJO =====") // Presenta el encabezado del reporte de existencias bajas.
            var hayStockBajo = false // Registra inicialmente que todavía no se encontró stock menor que cinco.

            for (nombre, stock) in stocksInventario { // Recorre cada producto junto con su stock almacenado.
                if stock < 5 { // Comprueba la condición exacta que define un stock bajo.
                    print("\(nombre) | Stock: \(stock)") // Muestra el nombre y stock del producto que cumple la condición.
                    hayStockBajo = true // Registra que al menos un producto tiene stock bajo.
                } // Cierra la comprobación de stock menor que cinco.
            } // Cierra el recorrido de todos los stocks del inventario.

            if !hayStockBajo { // Comprueba si el recorrido terminó sin encontrar existencias bajas.
                print("No hay productos con stock bajo.") // Informa que todos los productos tienen stock de cinco o más.
            } // Cierra la comprobación del resultado vacío.
        case 4: // Atiende la solicitud de calcular el valor total del inventario.
            var valorTotalInventario = 0.0 // Inicia en cero el acumulador monetario del inventario.

            for (nombre, precio) in preciosInventario { // Recorre cada producto junto con su precio unitario.
                if let stock = stocksInventario[nombre] { // Obtiene de forma segura el stock asociado al producto.
                    valorTotalInventario += precio * Double(stock) // Suma el precio multiplicado por la cantidad disponible.
                } // Cierra la obtención segura del stock usado en el cálculo.
            } // Cierra el recorrido que acumula el valor de todos los productos.

            print("===== VALOR TOTAL =====") // Presenta el encabezado del reporte monetario.
            print("Valor total del inventario: S/. \(valorTotalInventario)") // Muestra la suma de precio por stock de todos los productos.
        case 5: // Atiende la opción seleccionada para finalizar el menú.
            print("Gracias por utilizar el sistema de inventario.") // Muestra el mensaje de despedida antes de salir.
        default: // Atiende cualquier entero distinto de las cinco opciones válidas.
            print("Opción no válida. Intente nuevamente.") // Informa el error antes de volver a mostrar el menú.
        } // Cierra la selección de operaciones del menú.
    } // Cierra el ciclo cuando la opción elegida es cinco.
} // Cierra el ámbito independiente del Ejercicio 7.
