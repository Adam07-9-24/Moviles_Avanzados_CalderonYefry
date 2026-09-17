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


var saldoTarjeta: Double = 0.0
let estadoTarjeta = "Activa"
let tarifaViaje: Double = 3.0


func normalizar(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(options: .diacriticInsensitive, locale: .current)
        .lowercased()
}


func formatearMonto(_ monto: Double) -> String {
    return String(format: "%.2f", monto)
}


func recargarSaldoTarjeta() {
    print("\nIngrese el monto a recargar:")
    let montoIngresado = readLine() ?? ""
    let textoMonto = montoIngresado.trimmingCharacters(
        in: .whitespacesAndNewlines
    )


    guard let monto = Double(textoMonto), monto.isFinite, monto > 0 else {
        print("\nMonto no válido.")
        return
    }


    let saldoAnterior = saldoTarjeta
    saldoTarjeta += monto


    print("\nRecarga realizada correctamente.")
    print("Saldo anterior: S/ \(formatearMonto(saldoAnterior))")
    print("Saldo recargado: S/ \(formatearMonto(monto))")
    print("Nuevo saldo: S/ \(formatearMonto(saldoTarjeta))")
}


func gestionarTarjeta() {
    var continuarGestion = true


    while continuarGestion {
        print("----------------------------------------")
        print("       GESTIONAR TARJETA")
        print("----------------------------------------")
        print()
        print("1. Ver estado de la tarjeta")
        print("2. Recargar saldo")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")


        let opcion = readLine() ?? "0"


        switch opcion {
        case "1":
            print("\nEstado de la tarjeta: \(estadoTarjeta)")
            print("Saldo actual: S/ \(formatearMonto(saldoTarjeta))")
            print("Tarifa por viaje: S/ \(formatearMonto(tarifaViaje))")
        case "2":
            recargarSaldoTarjeta()
        case "0":
            continuarGestion = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}


func pagarViajeConTarjeta() -> Bool {
    print("\n----------------------------------------")
    print("           PAGO DEL VIAJE")
    print("----------------------------------------")
    print()
    print("Acerque su tarjeta de transporte...")
    print("Presione ENTER para continuar.")
    _ = readLine()


    while saldoTarjeta < tarifaViaje {
        print("\nSaldo insuficiente.")
        print("Saldo actual: S/ \(formatearMonto(saldoTarjeta))")
        print("Tarifa: S/ \(formatearMonto(tarifaViaje))")
        print()
        print("1. Recargar tarjeta")
        print("0. Cancelar viaje")
        print("\nSeleccione una opción:")


        let opcion = readLine() ?? "0"


        switch opcion {
        case "1":
            recargarSaldoTarjeta()
        case "0":
            return false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }


    print("\nSaldo actual: S/ \(formatearMonto(saldoTarjeta))")
    print("Tarifa: S/ \(formatearMonto(tarifaViaje))")


    saldoTarjeta -= tarifaViaje


    print("\nPago realizado correctamente.")
    print("Nuevo saldo: S/ \(formatearMonto(saldoTarjeta))")
    return true
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


func simularViaje(ruta: [NodoRuta], destino: String) {
    guard !ruta.isEmpty else {
        return
    }


    var indiceRuta = 0
    var estacionesRestantes = 0


    if ruta.count > 1 {
        for indice in 1..<ruta.count {
            let nombreAnterior = obtenerNombreEstacion(ruta[indice - 1])
            let nombreActual = obtenerNombreEstacion(ruta[indice])


            if normalizar(nombreAnterior) != normalizar(nombreActual) {
                estacionesRestantes += 1
            }
        }
    }


    var viajeEnCurso = true


    while viajeEnCurso {
        let nodoActual = ruta[indiceRuta]


        print("\n========================================")
        print("           VIAJE INICIADO")
        print("========================================")
        print()
        print("Estación actual: \(obtenerNombreEstacion(nodoActual))")
        print("Línea actual: \(nodoActual.linea)")
        print("Faltan \(estacionesRestantes) estaciones para llegar.")
        print()
        print("1. Avanzar a la siguiente estación")
        print("0. Finalizar viaje")
        print("\nSeleccione una opción:")


        let opcion = readLine() ?? "0"


        switch opcion {
        case "1":
            var avanzoAOtraEstacion = false


            while indiceRuta + 1 < ruta.count && !avanzoAOtraEstacion {
                let nodoPrevio = ruta[indiceRuta]
                let nodoSiguiente = ruta[indiceRuta + 1]
                let estacionPrevia = obtenerNombreEstacion(nodoPrevio)
                let estacionSiguiente = obtenerNombreEstacion(nodoSiguiente)
                let esMismaEstacion = normalizar(estacionPrevia) ==
                    normalizar(estacionSiguiente)


                indiceRuta += 1


                if esMismaEstacion {
                    if nodoPrevio.linea != nodoSiguiente.linea {
                        print("\nConexión necesaria en \(estacionSiguiente).")
                        print(
                            "Cambie de \(nodoPrevio.linea) a " +
                            "\(nodoSiguiente.linea)."
                        )
                    }
                } else {
                    estacionesRestantes -= 1
                    avanzoAOtraEstacion = true


                    while indiceRuta + 1 < ruta.count {
                        let nodoConexionPrevio = ruta[indiceRuta]
                        let nodoConexionSiguiente = ruta[indiceRuta + 1]
                        let estacionConexionPrevia = obtenerNombreEstacion(
                            nodoConexionPrevio
                        )
                        let estacionConexionSiguiente = obtenerNombreEstacion(
                            nodoConexionSiguiente
                        )


                        if normalizar(estacionConexionPrevia) !=
                           normalizar(estacionConexionSiguiente) {
                            break
                        }


                        indiceRuta += 1


                        if nodoConexionPrevio.linea != nodoConexionSiguiente.linea {
                            print(
                                "\nConexión necesaria en " +
                                "\(estacionConexionSiguiente)."
                            )
                            print(
                                "Cambie de \(nodoConexionPrevio.linea) a " +
                                "\(nodoConexionSiguiente.linea)."
                            )
                        }
                    }
                }
            }


            if estacionesRestantes == 0 {
                print("\n========================================")
                print("          DESTINO ALCANZADO")
                print("========================================")
                print("\nHa llegado a \(destino).")
                viajeEnCurso = false
            } else if !avanzoAOtraEstacion {
                viajeEnCurso = false
            }
        case "0":
            print("\nViaje finalizado.")
            viajeEnCurso = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}


func planificarViaje() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarPlanificacion = true


    while continuarPlanificacion {
        print("----------------------------------------")
        print("          PLANIFICAR UN VIAJE")
        print("----------------------------------------")
        print()
        print("1. Ingresar estación de origen y destino")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")


        let opcion = readLine() ?? "0"


        switch opcion {
        case "1":
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


                continue
            }


            if origenNormalizado == destinoNormalizado {
                print("\nYa se encuentra en la estación de destino.")
                continue
            }


            let ruta = calcularRuta(
                desde: nombreOrigenOficial,
                hasta: nombreDestinoOficial
            )


            if ruta.isEmpty {
                print("\nNo se encontró una ruta disponible.")
                continue
            }


            var estacionesParaLlegar = 0
            var conexiones: [(estacion: String, desde: String, hasta: String)] = []


            if ruta.count > 1 {
                for indice in 1..<ruta.count {
                    let nodoPrevio = ruta[indice - 1]
                    let nodoActual = ruta[indice]
                    let estacionPrevia = obtenerNombreEstacion(nodoPrevio)
                    let estacionActual = obtenerNombreEstacion(nodoActual)


                    if normalizar(estacionPrevia) != normalizar(estacionActual) {
                        estacionesParaLlegar += 1
                    }


                    if nodoPrevio.linea != nodoActual.linea {
                        conexiones.append(
                            (
                                estacion: estacionActual,
                                desde: nodoPrevio.linea,
                                hasta: nodoActual.linea
                            )
                        )
                    }
                }
            }


            print("\n========================================")
            print("          VIAJE PLANIFICADO")
            print("========================================")
            print()
            print("Origen: \(nombreOrigenOficial)")
            print("Destino: \(nombreDestinoOficial)")
            print("Estaciones para llegar: \(estacionesParaLlegar)")
            print("Cambios de línea: \(conexiones.count)")


            if !conexiones.isEmpty {
                print("\nConexiones necesarias:")


                for conexion in conexiones {
                    print(
                        "- \(conexion.estacion): \(conexion.desde) → " +
                        "\(conexion.hasta)"
                    )
                }
            }


            var seleccionarAccion = true


            while seleccionarAccion {
                print("\n1. Iniciar viaje")
                print("0. Volver")
                print("\nSeleccione una opción:")


                let opcionViaje = readLine() ?? "0"


                switch opcionViaje {
                case "1":
                    if pagarViajeConTarjeta() {
                        simularViaje(ruta: ruta, destino: nombreDestinoOficial)
                    }


                    seleccionarAccion = false
                case "0":
                    seleccionarAccion = false
                default:
                    print("Opción no válida. Intente nuevamente.")
                }
            }
        case "2":
            mostrarEstacionesPorLinea()
        case "0":
            continuarPlanificacion = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}


func filtrarEstaciones() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var continuarFiltro = true


    while continuarFiltro {
        print("----------------------------------------")
        print("      FILTRAR ESTACIONES POR NOMBRE")
        print("----------------------------------------")
        print()
        print("1. Ingresar texto para filtrar")
        print("2. Ver estaciones disponibles")
        print("0. Volver al menú principal")
        print("\nSeleccione una opción:")


        let opcion = readLine() ?? "0"


        switch opcion {
        case "1":
            var solicitarFiltro = true


            while solicitarFiltro {
                print("\nIngrese una palabra o parte del nombre:")
                print("Ejemplo: San, Plaza, Santa")


                let textoFiltro = readLine() ?? ""
                let filtroNormalizado = normalizar(textoFiltro)
                let textoMostrado = textoFiltro.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
                var nombresOficiales: [String: String] = [:]
                var lineasPorEstacion: [String: [String]] = [:]
                var ordenResultados: [String] = []


                for nombreLinea in ordenLineas {
                    if let estaciones = lineas[nombreLinea] {
                        for estacion in estaciones {
                            let estacionNormalizada = normalizar(estacion)


                            if !filtroNormalizado.isEmpty &&
                               estacionNormalizada.contains(filtroNormalizado) {
                                if lineasPorEstacion[estacionNormalizada] == nil {
                                    nombresOficiales[estacionNormalizada] = estacion
                                    lineasPorEstacion[estacionNormalizada] = [nombreLinea]
                                    ordenResultados.append(estacionNormalizada)
                                } else if let lineasRegistradas = lineasPorEstacion[estacionNormalizada],
                                          !lineasRegistradas.contains(nombreLinea) {
                                    lineasPorEstacion[estacionNormalizada, default: []].append(nombreLinea)
                                }
                            }
                        }
                    }
                }


                if !ordenResultados.isEmpty {
                    print("\nResultados encontrados para \"\(textoMostrado)\":")
                    print()


                    for (indice, claveEstacion) in ordenResultados.enumerated() {
                        if let nombreOficial = nombresOficiales[claveEstacion],
                           let lineasEncontradas = lineasPorEstacion[claveEstacion] {
                            let textoLineas = lineasEncontradas.joined(separator: ", ")
                            print("\(indice + 1). \(nombreOficial) - \(textoLineas)")
                        }
                    }


                    print(
                        "\nCantidad de estaciones encontradas: " +
                        "\(ordenResultados.count)"
                    )
                    solicitarFiltro = false
                } else {
                    print(
                        "\nNo se encontraron estaciones que coincidan con el filtro."
                    )
                    print()
                    print("1. Intentar otro filtro")
                    print("2. Ver estaciones disponibles")
                    print("0. Volver al menú principal")
                    print("\nSeleccione una opción:")


                    var opcionValida = false


                    while !opcionValida {
                        let opcionSinResultados = readLine() ?? "0"


                        switch opcionSinResultados {
                        case "1":
                            opcionValida = true
                        case "2":
                            mostrarEstacionesPorLinea()
                            opcionValida = true
                            solicitarFiltro = false
                        case "0":
                            opcionValida = true
                            solicitarFiltro = false
                            continuarFiltro = false
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
            continuarFiltro = false
        default:
            print("Opción no válida. Intente nuevamente.")
        }
    }
}


func mostrarInformacionMetro() {
    let ordenLineas = ["Línea 1", "Línea 2", "Línea 3", "Línea 4"]
    var totalEstacionesRegistradas = 0
    var nombresOficiales: [String: String] = [:]
    var lineasPorEstacion: [String: [String]] = [:]
    var ordenEstaciones: [String] = []


    for nombreLinea in ordenLineas {
        if let estaciones = lineas[nombreLinea] {
            totalEstacionesRegistradas += estaciones.count


            for estacion in estaciones {
                let estacionNormalizada = normalizar(estacion)


                if lineasPorEstacion[estacionNormalizada] == nil {
                    nombresOficiales[estacionNormalizada] = estacion
                    lineasPorEstacion[estacionNormalizada] = [nombreLinea]
                    ordenEstaciones.append(estacionNormalizada)
                } else if let lineasRegistradas = lineasPorEstacion[estacionNormalizada],
                          !lineasRegistradas.contains(nombreLinea) {
                    lineasPorEstacion[estacionNormalizada, default: []].append(nombreLinea)
                }
            }
        }
    }


    var estacionesConexion: [String] = []


    for claveEstacion in ordenEstaciones {
        if let lineasEncontradas = lineasPorEstacion[claveEstacion],
           lineasEncontradas.count > 1 {
            estacionesConexion.append(claveEstacion)
        }
    }


    print("----------------------------------------")
    print("    INFORMACIÓN GENERAL DEL METRO")
    print("----------------------------------------")
    print("\nCantidad de líneas: \(lineas.count)")
    print("\nEstaciones por línea:")


    for nombreLinea in ordenLineas {
        let cantidadEstaciones = lineas[nombreLinea]?.count ?? 0
        print("- \(nombreLinea): \(cantidadEstaciones)")
    }


    print("\nTotal de estaciones registradas: \(totalEstacionesRegistradas)")
    print("Estaciones únicas: \(ordenEstaciones.count)")
    print("Estaciones de conexión: \(estacionesConexion.count)")
    print("\nEstaciones de conexión:")


    for claveEstacion in estacionesConexion {
        if let nombreOficial = nombresOficiales[claveEstacion],
           let lineasEncontradas = lineasPorEstacion[claveEstacion] {
            let textoLineas = lineasEncontradas.joined(separator: ", ")
            print("- \(nombreOficial): \(textoLineas)")
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
    print("8. Ver información general del Metro")
    print("9. Planificar un viaje")
    print("10. Gestionar tarjeta de transporte")
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
        case "7":
            filtrarEstaciones()
        case "8":
            mostrarInformacionMetro()
        case "9":
            planificarViaje()
        case "10":
            gestionarTarjeta()
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
