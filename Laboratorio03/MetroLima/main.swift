import Foundation

// MARK: - Datos del Metro

let lineas: [String: [String]] = [
    "Línea 1": [
        "Villa El Salvador",
        "Parque Industrial",
        "Pumacahua",
        "Villa María",
        "María Auxiliadora",
        "San Juan",
        "Atocongo",
        "Jorge Chávez",
        "Ayacucho",
        "Cabitos",
        "Angamos",
        "San Borja Sur",
        "La Cultura",
        "Nicolás Arriola",
        "Gamarra",
        "Miguel Grau",
        "El Ángel",
        "Presbítero Maestro",
        "Caja de Agua",
        "Pirámide del Sol",
        "Los Jardines",
        "Los Postes",
        "San Carlos",
        "San Martín",
        "Santa Rosa",
        "Bayóvar"
    ],
    "Línea 2": [
        "Puerto del Callao",
        "Buenos Aires",
        "Juan Pablo II",
        "Insurgentes",
        "Carmen de la Legua",
        "Óscar Benavides",
        "San Marcos",
        "Elio",
        "La Alborada",
        "Tingo María",
        "Parque Murillo",
        "Plaza Bolognesi",
        "Estación Central",
        "Plaza Manco Cápac",
        "Cangallo",
        "28 de Julio",
        "Nicolás Ayllón",
        "Circunvalación",
        "San Juan de Dios",
        "Evitamiento",
        "Óvalo Santa Anita",
        "Colectora Industrial",
        "Hermilio Valdizán",
        "Mercado Santa Anita",
        "Vista Alegre",
        "Prolongación Javier Prado",
        "Municipalidad de Ate"
    ],
    "Línea 3": [
        "El Álamo",
        "Huandoy",
        "2 de Octubre",
        "Villa Sol",
        "Naranjal",
        "Carlos Izaguirre",
        "Tomás Valle",
        "Bartolomé de las Casas",
        "José Granda",
        "Caquetá",
        "Tacna",
        "Garcilaso de la Vega",
        "Estación Central",
        "Parque de la Reserva",
        "Museo de Historia Natural",
        "César Canevaro",
        "Conde de San Isidro",
        "Andrés Aramburú",
        "Huaca Pucllana",
        "Parque Central de Miraflores",
        "Parque Reducto",
        "República de Panamá",
        "Juana Alarco",
        "Cabitos",
        "Alejandro Velasco",
        "Las Gardenias",
        "Los Héroes",
        "Pedro Miotta"
    ],
    "Línea 4": [
        "Gambetta",
        "Canta Callao",
        "Bocanegra",
        "Aeropuerto",
        "El Olivar",
        "Quilca",
        "Morales Duárez",
        "Carmen de la Legua",
        "Venezuela",
        "Rafael Escardó",
        "Pando",
        "José de Sucre",
        "Brasil",
        "Felipe Salaverry",
        "Guillermo Prescott",
        "Las Palmeras",
        "Conde de San Isidro",
        "Javier Prado",
        "Pablo Carriquirry",
        "La Cultura",
        "San Luis",
        "Monterrico",
        "Manuel Olguin",
        "Los Frutales",
        "La Molina",
        "Santa Patricia",
        "Mayorazgo",
        "Mercado Santa Anita"
    ]
]

func normalizar(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(options: .diacriticInsensitive, locale: .current)
        .lowercased()
}

func mostrarLineas() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]

    print("========================================")
    print("        LÍNEAS DISPONIBLES")
    print("========================================")
    print()

    for (indice, nombreLinea) in ordenLineas.enumerated() {
        print("\(indice + 1). \(nombreLinea)")
    }
}

func mostrarEstacionesPorLinea() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]

    print("----------------------------------------")
    print("       VER ESTACIONES DE UNA LÍNEA")
    print("----------------------------------------")
    print()

    for (indice, nombreLinea) in ordenLineas.enumerated() {
        print("\(indice + 1). \(nombreLinea)")
    }

    print("\nSeleccione una línea:")
    let opcion = readLine() ?? ""
    let nombreLinea: String

    switch opcion {
    case "1":
        nombreLinea = "Línea 1"
    case "2":
        nombreLinea = "Línea 2"
    case "3":
        nombreLinea = "Línea 3"
    case "4":
        nombreLinea = "Línea 4"
    default:
        print("Opción de línea no válida.")
        return
    }

    if let estaciones = lineas[nombreLinea] {
        print("\nLÍNEA \(opcion)")
        print("Cantidad de estaciones: \(estaciones.count)")
        print()

        for (indice, estacion) in estaciones.enumerated() {
            print("\(indice + 1). \(estacion)")
        }
    }
}

func buscarEstacion() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarBusqueda = true

    while continuarBusqueda {
        print("----------------------------------------")
        print("          BUSCAR UNA ESTACIÓN")
        print("----------------------------------------")
        print()
        print("1. Escribir el nombre de una estación")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")

        let opcion = readLine() ?? "0"

        switch opcion {
        case "1":
            var solicitarNombre = true

            while solicitarNombre {
                print("\nIngrese el nombre de la estación:")
                print("Ejemplo: Miguel Grau, Gamarra, San Borja Sur")

                let textoBusqueda = readLine() ?? ""
                let textoNormalizado = normalizar(textoBusqueda)
                var nombreOficial = ""
                var lineasEncontradas: [String] = []

                for nombreLinea in ordenLineas {
                    if let estaciones = lineas[nombreLinea] {
                        for estacion in estaciones {
                            if normalizar(estacion) == textoNormalizado {
                                if nombreOficial.isEmpty {
                                    nombreOficial = estacion
                                }

                                lineasEncontradas.append(nombreLinea)
                            }
                        }
                    }
                }

                if !lineasEncontradas.isEmpty {
                    print("\nEstación encontrada: \(nombreOficial)")
                    print("Pertenece a:")

                    for nombreLinea in lineasEncontradas {
                        print("- \(nombreLinea)")
                    }

                    solicitarNombre = false
                } else {
                    print("\nNo se encontró la estación.")
                    print()
                    print("1. Intentar otra búsqueda")
                    print("2. Ver estaciones disponibles")
                    print("0. Volver al menú principal")
                    print("\nSeleccione una opción:")

                    var opcionValida = false

                    while !opcionValida {
                        let opcionNoEncontrada = readLine() ?? "0"

                        switch opcionNoEncontrada {
                        case "1":
                            opcionValida = true
                        case "2":
                            mostrarEstacionesPorLinea()
                            opcionValida = true
                            solicitarNombre = false
                        case "0":
                            opcionValida = true
                            solicitarNombre = false
                            continuarBusqueda = false
                        default:
                            print("Opción no válida. Intente nuevamente.")
                            print("\nSeleccione una opción:")
                        }
                    }
                }
            }
        case "2":
            mostrarEstacionesPorLinea()
        case "0":
            continuarBusqueda = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}

func mostrarEstacionesCercanas() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarConsulta = true

    while continuarConsulta {
        print("----------------------------------------")
        print("        VER ESTACIONES CERCANAS")
        print("----------------------------------------")
        print()
        print("1. Escribir el nombre de una estación")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")

        let opcion = readLine() ?? "0"

        switch opcion {
        case "1":
            var solicitarNombre = true

            while solicitarNombre {
                print("\nIngrese el nombre de la estación:")
                print("Ejemplo: Miguel Grau, Gamarra, San Borja Sur")

                let textoBusqueda = readLine() ?? ""
                let textoNormalizado = normalizar(textoBusqueda)
                var nombreOficial = ""
                var cantidadCoincidencias = 0

                for nombreLinea in ordenLineas {
                    if let estaciones = lineas[nombreLinea] {
                        for estacion in estaciones {
                            if normalizar(estacion) == textoNormalizado {
                                if nombreOficial.isEmpty {
                                    nombreOficial = estacion
                                }

                                cantidadCoincidencias += 1
                            }
                        }
                    }
                }

                if cantidadCoincidencias > 0 {
                    print("\nEstación: \(nombreOficial)")

                    if cantidadCoincidencias > 1 {
                        print()
                    }

                    var coincidenciasMostradas = 0

                    for nombreLinea in ordenLineas {
                        if let estaciones = lineas[nombreLinea] {
                            for (indice, estacion) in estaciones.enumerated() {
                                if normalizar(estacion) == textoNormalizado {
                                    if coincidenciasMostradas > 0 {
                                        print()
                                    }

                                    if cantidadCoincidencias == 1 {
                                        print("Línea: \(nombreLinea)")
                                    } else {
                                        print(nombreLinea)
                                    }

                                    var estacionAnterior = "No tiene"
                                    var estacionSiguiente = "No tiene"

                                    if indice > 0 {
                                        estacionAnterior = estaciones[indice - 1]
                                    }

                                    if indice + 1 < estaciones.count {
                                        estacionSiguiente = estaciones[indice + 1]
                                    }

                                    print("Estación anterior: \(estacionAnterior)")
                                    print("Estación siguiente: \(estacionSiguiente)")
                                    coincidenciasMostradas += 1
                                }
                            }
                        }
                    }

                    solicitarNombre = false
                } else {
                    print("\nNo se encontró la estación.")
                    print()
                    print("1. Intentar otra búsqueda")
                    print("2. Ver estaciones disponibles")
                    print("0. Volver al menú principal")
                    print("\nSeleccione una opción:")

                    var opcionValida = false

                    while !opcionValida {
                        let opcionNoEncontrada = readLine() ?? "0"

                        switch opcionNoEncontrada {
                        case "1":
                            opcionValida = true
                        case "2":
                            mostrarEstacionesPorLinea()
                            opcionValida = true
                            solicitarNombre = false
                        case "0":
                            opcionValida = true
                            solicitarNombre = false
                            continuarConsulta = false
                        default:
                            print("Opción no válida. Intente nuevamente.")
                            print("\nSeleccione una opción:")
                        }
                    }
                }
            }
        case "2":
            mostrarEstacionesPorLinea()
        case "0":
            continuarConsulta = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}

func mostrarConexionesEstacion() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarConsulta = true

    while continuarConsulta {
        print("----------------------------------------")
        print("     VER CONEXIONES DE UNA ESTACIÓN")
        print("----------------------------------------")
        print()
        print("1. Escribir el nombre de una estación")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")

        let opcion = readLine() ?? "0"

        switch opcion {
        case "1":
            var solicitarNombre = true

            while solicitarNombre {
                print("\nIngrese el nombre de la estación:")
                print("Ejemplo: Cabitos, La Cultura, Estación Central")

                let textoBusqueda = readLine() ?? ""
                let textoNormalizado = normalizar(textoBusqueda)
                var nombreOficial = ""
                var lineasEncontradas: [String] = []

                for nombreLinea in ordenLineas {
                    if let estaciones = lineas[nombreLinea] {
                        for estacion in estaciones {
                            if normalizar(estacion) == textoNormalizado {
                                if nombreOficial.isEmpty {
                                    nombreOficial = estacion
                                }

                                lineasEncontradas.append(nombreLinea)
                            }
                        }
                    }
                }

                if lineasEncontradas.count > 1 {
                    print("\nEstación: \(nombreOficial)")
                    print("Conexiones disponibles:")

                    for nombreLinea in lineasEncontradas {
                        print("- \(nombreLinea)")
                    }

                    solicitarNombre = false
                } else if lineasEncontradas.count == 1 {
                    print("\nEstación: \(nombreOficial)")
                    print("Pertenece a: \(lineasEncontradas[0])")
                    print("Esta estación no tiene conexión con otra línea.")
                    solicitarNombre = false
                } else {
                    print("\nNo se encontró la estación.")
                    print()
                    print("1. Intentar otra búsqueda")
                    print("2. Ver estaciones disponibles")
                    print("0. Volver al menú principal")
                    print("\nSeleccione una opción:")

                    var opcionValida = false

                    while !opcionValida {
                        let opcionNoEncontrada = readLine() ?? "0"

                        switch opcionNoEncontrada {
                        case "1":
                            opcionValida = true
                        case "2":
                            mostrarEstacionesPorLinea()
                            opcionValida = true
                            solicitarNombre = false
                        case "0":
                            opcionValida = true
                            solicitarNombre = false
                            continuarConsulta = false
                        default:
                            print("Opción no válida. Intente nuevamente.")
                            print("\nSeleccione una opción:")
                        }
                    }
                }
            }
        case "2":
            mostrarEstacionesPorLinea()
        case "0":
            continuarConsulta = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}

struct NodoRuta: Hashable {
    let linea: String
    let indiceEstacion: Int
}

func obtenerNombreEstacion(_ nodo: NodoRuta) -> String {
    if let estaciones = lineas[nodo.linea],
       nodo.indiceEstacion >= 0,
       nodo.indiceEstacion < estaciones.count {
        return estaciones[nodo.indiceEstacion]
    }

    return ""
}

func calcularRuta(desde nombreOrigen: String, hasta nombreDestino: String) -> [NodoRuta] {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    let origenNormalizado = normalizar(nombreOrigen)
    let destinoNormalizado = normalizar(nombreDestino)
    var nodosOrigen: [NodoRuta] = []
    var nodosDestino = Set<NodoRuta>()

    for nombreLinea in ordenLineas {
        if let estaciones = lineas[nombreLinea] {
            for (indice, estacion) in estaciones.enumerated() {
                let nodo = NodoRuta(linea: nombreLinea, indiceEstacion: indice)
                let estacionNormalizada = normalizar(estacion)

                if estacionNormalizada == origenNormalizado {
                    nodosOrigen.append(nodo)
                }

                if estacionNormalizada == destinoNormalizado {
                    nodosDestino.insert(nodo)
                }
            }
        }
    }

    if nodosOrigen.isEmpty || nodosDestino.isEmpty {
        return []
    }

    // Se comienza desde la estación de origen en cada línea donde aparece.
    var cola = nodosOrigen
    var visitados = Set(nodosOrigen)
    var nodoAnterior: [NodoRuta: NodoRuta] = [:]
    var posicionCola = 0
    var nodoDestinoEncontrado: NodoRuta?

    // Se continúa por niveles hasta encontrar el destino.
    while posicionCola < cola.count && nodoDestinoEncontrado == nil {
        let nodoActual = cola[posicionCola]
        posicionCola += 1

        if nodosDestino.contains(nodoActual) {
            nodoDestinoEncontrado = nodoActual
        } else {
            // Se revisan las estaciones a las que se puede avanzar.
            var siguientesNodos: [NodoRuta] = []

            if let estaciones = lineas[nodoActual.linea] {
                if nodoActual.indiceEstacion > 0 {
                    siguientesNodos.append(
                        NodoRuta(
                            linea: nodoActual.linea,
                            indiceEstacion: nodoActual.indiceEstacion - 1
                        )
                    )
                }

                if nodoActual.indiceEstacion + 1 < estaciones.count {
                    siguientesNodos.append(
                        NodoRuta(
                            linea: nodoActual.linea,
                            indiceEstacion: nodoActual.indiceEstacion + 1
                        )
                    )
                }

                let nombreActualNormalizado = normalizar(
                    obtenerNombreEstacion(nodoActual)
                )

                for otraLinea in ordenLineas {
                    if otraLinea != nodoActual.linea {
                        if let otrasEstaciones = lineas[otraLinea] {
                            for (indice, estacion) in otrasEstaciones.enumerated() {
                                if normalizar(estacion) == nombreActualNormalizado {
                                    siguientesNodos.append(
                                        NodoRuta(
                                            linea: otraLinea,
                                            indiceEstacion: indice
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
            }

            for siguienteNodo in siguientesNodos {
                // Se evita visitar repetidamente la misma estación de una línea.
                if !visitados.contains(siguienteNodo) {
                    visitados.insert(siguienteNodo)
                    nodoAnterior[siguienteNodo] = nodoActual
                    cola.append(siguienteNodo)
                }
            }
        }
    }

    if var nodoActual = nodoDestinoEncontrado {
        var ruta = [nodoActual]

        while let anterior = nodoAnterior[nodoActual] {
            ruta.insert(anterior, at: 0)
            nodoActual = anterior
        }

        return ruta
    }

    return []
}

func mostrarRuta() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarConsulta = true

    while continuarConsulta {
        print("----------------------------------------")
        print("    CÓMO LLEGAR DE UNA ESTACIÓN A OTRA")
        print("----------------------------------------")
        print()
        print("1. Ingresar estación de origen y destino")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")

        let opcion = readLine() ?? "0"

        switch opcion {
        case "1":
            var solicitarEstaciones = true

            while solicitarEstaciones {
                print("\nIngrese la estación de origen:")
                print("Ejemplo: Gamarra")
                let origenIngresado = readLine() ?? ""

                print("\nIngrese la estación de destino:")
                print("Ejemplo: Estación Central")
                let destinoIngresado = readLine() ?? ""

                let origenNormalizado = normalizar(origenIngresado)
                let destinoNormalizado = normalizar(destinoIngresado)
                var nombreOrigenOficial = ""
                var nombreDestinoOficial = ""

                for nombreLinea in ordenLineas {
                    if let estaciones = lineas[nombreLinea] {
                        for estacion in estaciones {
                            if nombreOrigenOficial.isEmpty &&
                               normalizar(estacion) == origenNormalizado {
                                nombreOrigenOficial = estacion
                            }

                            if nombreDestinoOficial.isEmpty &&
                               normalizar(estacion) == destinoNormalizado {
                                nombreDestinoOficial = estacion
                            }
                        }
                    }
                }

                if nombreOrigenOficial.isEmpty || nombreDestinoOficial.isEmpty {
                    print()

                    if nombreOrigenOficial.isEmpty {
                        print("No se encontró la estación de origen.")
                    }

                    if nombreDestinoOficial.isEmpty {
                        print("No se encontró la estación de destino.")
                    }

                    print()
                    print("1. Intentar nuevamente")
                    print("2. Ver estaciones disponibles")
                    print("0. Volver al menú principal")
                    print("\nSeleccione una opción:")

                    var opcionValida = false

                    while !opcionValida {
                        let opcionEstacionInvalida = readLine() ?? "0"

                        switch opcionEstacionInvalida {
                        case "1":
                            opcionValida = true
                        case "2":
                            mostrarEstacionesPorLinea()
                            opcionValida = true
                            solicitarEstaciones = false
                        case "0":
                            opcionValida = true
                            solicitarEstaciones = false
                            continuarConsulta = false
                        default:
                            print("Opción no válida. Intente nuevamente.")
                            print("\nSeleccione una opción:")
                        }
                    }
                } else if origenNormalizado == destinoNormalizado {
                    print("\nYa se encuentra en la estación indicada.")
                    solicitarEstaciones = false
                } else {
                    let ruta = calcularRuta(
                        desde: nombreOrigenOficial,
                        hasta: nombreDestinoOficial
                    )

                    if ruta.isEmpty {
                        print("\nNo se encontró una ruta disponible.")
                    } else {
                        print("\nRuta encontrada:")
                        print()
                        print("Origen: \(nombreOrigenOficial)")
                        print("Destino: \(nombreDestinoOficial)")
                        print()

                        let primerNodo = ruta[0]
                        print("Tome la \(primerNodo.linea).")
                        print()
                        print(obtenerNombreEstacion(primerNodo))

                        var cantidadEstacionesRecorridas = 0
                        var cambiosLinea = 0

                        if ruta.count > 1 {
                            for indiceRuta in 1..<ruta.count {
                                let nodoPrevio = ruta[indiceRuta - 1]
                                let nodoActual = ruta[indiceRuta]

                                if nodoPrevio.linea != nodoActual.linea {
                                    let estacionConexion = obtenerNombreEstacion(nodoActual)
                                    print()
                                    print(
                                        "Cambie de \(nodoPrevio.linea) a " +
                                        "\(nodoActual.linea) en \(estacionConexion)."
                                    )
                                    print()
                                    cambiosLinea += 1
                                } else {
                                    print("↓")
                                    print(obtenerNombreEstacion(nodoActual))
                                    cantidadEstacionesRecorridas += 1
                                }
                            }
                        }

                        print("\nDestino alcanzado.")
                        print()
                        print(
                            "Cantidad de estaciones recorridas: " +
                            "\(cantidadEstacionesRecorridas)"
                        )
                        print("Cambios de línea: \(cambiosLinea)")
                    }

                    solicitarEstaciones = false
                }
            }
        case "2":
            mostrarEstacionesPorLinea()
        case "0":
            continuarConsulta = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}

var continuar = true

while continuar {
    print("========================================")
    print("       METRO DE LIMA Y CALLAO")
    print("========================================")
    print()
    print("1. Ver líneas disponibles")
    print("2. Ver estaciones de una línea")
    print("3. Buscar una estación")
    print("4. Ver estaciones cercanas")
    print("5. Ver conexiones de una estación")
    print("6. Cómo llegar de una estación a otra")
    print("7. Filtrar estaciones por nombre")
    print("8. Ver resumen del Metro")
    print("0. Salir")
    print("\nSeleccione una opción:")

    if let opcion = readLine() {
        switch opcion {
        case "1":
            mostrarLineas()
        case "2":
            mostrarEstacionesPorLinea()
        case "3":
            buscarEstacion()
        case "4":
            mostrarEstacionesCercanas()
        case "5":
            mostrarConexionesEstacion()
        case "6":
            mostrarRuta()
        case "7", "8":
            print("Esta función será implementada próximamente.")
        case "0":
            print("Gracias por usar el sistema del Metro de Lima y Callao.")
            continuar = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    } else {
        continuar = false
    }
}
