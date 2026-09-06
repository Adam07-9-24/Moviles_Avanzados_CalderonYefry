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
