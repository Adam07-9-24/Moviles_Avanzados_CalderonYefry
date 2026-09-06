// Desarrollado por: Calderon Yefry

import Foundation

// ===== TODO 1: Registro de 5 alumnos =====
var alumnos: [String] = []

for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}

print("Alumnos: \(alumnos)")

// ===== TODO 2: Buscar un alumno =====
print("Buscar alumno:")
let buscar = readLine() ?? ""

if alumnos.contains(buscar) {
    print("El alumno \(buscar) está en la lista.")
} else {
    print("El alumno \(buscar) NO está en la lista.")
}

// ===== TODO 3: Notas con clasificación =====
var notasClase: [Double] = []

for i in 1...5 {
    print("Nota del alumno \(i):")
    let nota = Double(readLine() ?? "") ?? 0
    notasClase.append(nota)
}

var sumaNotas: Double = 0
var aprobados = 0
var desaprobados = 0

for nota in notasClase {
    sumaNotas += nota

    if nota >= 13 {
        aprobados += 1
    } else {
        desaprobados += 1
    }
}

print("Promedio: \(sumaNotas / Double(notasClase.count))")
print("Aprobados: \(aprobados), Desaprobados: \(desaprobados)")

// ===== FIX: Arrays =====
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Fresa")

var colores = ["Rojo", "Azul", "Verde"]
colores.append("Amarillo")

let numeros = [10, 20, 30, 40, 50]
print(numeros[4])

// ===== PREDICT: Arrays =====
var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista) // PREDICT 1: [2, 3, 4, 5, 6]
print(lista.count) // PREDICT 2: 5

var nombres = ["Ana", "Carlos", "Beto"]
print(nombres.sorted()) // PREDICT 3: ["Ana", "Beto", "Carlos"]
print(nombres) // PREDICT 4: ["Ana", "Carlos", "Beto"]

// ===== TODO 4: Catálogo de productos =====
var productos: [String: Double] = [:]

for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    productos[nombre] = precio
}

// ===== TODO 5: Mostrar catálogo =====
print("===== CATÁLOGO =====")

for (nombre, precio) in productos {
    print("\(nombre): S/. \(precio)")
}

// ===== TODO 6: Valor total =====
var valorTotal = 0.0

for (_, precio) in productos {
    valorTotal += precio
}

print("Valor total: S/. \(valorTotal)")

// ===== TODO 7: Buscar producto =====
print("Buscar producto:")
let buscarProd = readLine() ?? ""

if let precioEncontrado = productos[buscarProd] {
    print("\(buscarProd) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}

// ===== ANALYZE =====
var edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
var mayores: [String] = []

for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}

print("Mayores de 21: \(mayores)")
// ANALYZE 1: Recorre las edades, guarda los nombres con 21 años o más e imprime: Mayores de 21: ["Luis"]

do {
    // ===== TODO 8: Eliminar duplicados =====
    var numeros: [Int] = []

    for i in 1...8 {
        print("Número \(i):")
        let n = Int(readLine() ?? "") ?? 0
        numeros.append(n)
    }

    print("Con duplicados: \(numeros)")

    let sinDuplicados = Array(Set(numeros)).sorted()

    print("Sin duplicados: \(sinDuplicados)")

    // ===== TODO 9: Comparar asistencia =====
    var alumnosLunes: Set<String> = []

    for i in 1...4 {
        print("Alumno del lunes \(i):")
        let nombre = readLine() ?? ""
        alumnosLunes.insert(nombre)
    }

    var alumnosMartes: Set<String> = []

    for i in 1...4 {
        print("Alumno del martes \(i):")
        let nombre = readLine() ?? ""
        alumnosMartes.insert(nombre)
    }

    let ambosDias = alumnosLunes.intersection(alumnosMartes)
    let soloLunes = alumnosLunes.subtracting(alumnosMartes)
    let soloMartes = alumnosMartes.subtracting(alumnosLunes)

    print("Ambos días: \(ambosDias)")
    print("Solo lunes: \(soloLunes)")
    print("Solo martes: \(soloMartes)")

    // ===== PREDICT =====
    let a: Set = [1, 2, 3, 4, 5]
    let b: Set = [4, 5, 6, 7, 8]

    print(a.intersection(b)) // PREDICT 5: [4, 5] (el orden puede variar)
    print(a.union(b).count) // PREDICT 6: 8
    print(a.subtracting(b)) // PREDICT 7: [1, 2, 3] (el orden puede variar)

    var repetidos: Set = ["A", "B", "A", "C", "B"]
    print(repetidos.count) // PREDICT 8: 3
}

do {
    // ===== EJERCICIO 4: Combinación de Colecciones =====
    // ===== TODO 10: Inventario de productos =====
    // Desarrollado por: Calderon Yefry

    // Pide N productos con nombre, precio y stock
    // Calcula valor total y muestra stock bajo

    var precios: [String: Double] = [:]
    var stocks: [String: Int] = [:]

    print("¿Cuántos productos?")
    let n = Int(readLine() ?? "") ?? 0

    if n > 0 {
        for i in 1...n {
            print("Producto \(i) - Nombre:")
            let nombre = readLine() ?? ""

            print("Precio:")
            let precio = Double(readLine() ?? "") ?? 0

            print("Stock:")
            let stock = Int(readLine() ?? "") ?? 0

            precios[nombre] = precio
            stocks[nombre] = stock
        }
    }

    var valorInventario = 0.0

    for (nombre, stock) in stocks {
        if let precio = precios[nombre] {
            valorInventario += precio * Double(stock)
        }
    }

    print("Valor total del inventario: S/. \(valorInventario)")

    print("Productos con stock bajo:")

    for (nombre, stock) in stocks {
        if stock < 5 {
            print("\(nombre): \(stock)")
        }
    }
}

do {
    // Desarrollado por: Calderon Yefry
    // ===== CARRITO DE COMPRAS 2.0 =====

    var nombres: [String] = []
    var precios: [Double] = []
    var cantidades: [Int] = []

    // TODO 11: Pedir productos
    print("¿Cuántos productos va a comprar?")
    let totalProductos = Int(readLine() ?? "") ?? 0

    if totalProductos > 0 {
        for i in 1...totalProductos {
            print("\nProducto \(i) - Nombre:")
            nombres.append(readLine() ?? "")

            print("Precio unitario:")
            precios.append(Double(readLine() ?? "") ?? 0)

            print("Cantidad:")
            cantidades.append(Int(readLine() ?? "") ?? 0)
        }
    }

    // TODO 12: Calcular subtotales
    var subtotales: [Double] = []

    for i in 0..<nombres.count {
        let sub = precios[i] * Double(cantidades[i])
        subtotales.append(sub)
    }

    // TODO 13: Total del carrito
    var totalCarrito = 0.0

    for sub in subtotales {
        totalCarrito += sub
    }

    // TODO 14: Nombre del cliente
    print("\nNombre del cliente:")
    let cliente = readLine() ?? ""

    // TODO 15: Descuento
    var descPct = 0.0

    if totalCarrito >= 5000 {
        descPct = 0.15
    } else if totalCarrito >= 2000 {
        descPct = 0.10
    } else if totalCarrito >= 500 {
        descPct = 0.05
    }

    let descuento = totalCarrito * descPct
    let totalConDesc = totalCarrito - descuento

    // TODO 16: IGV y total
    let igv = totalConDesc * 0.18
    let totalFinal = totalConDesc + igv

    // TODO 17: Categoría
    var categoria = ""

    switch Int(totalCarrito) {
    case 0..<500:
        categoria = "Regular"
    case 500..<2000:
        categoria = "Frecuente"
    case 2000..<5000:
        categoria = "VIP"
    default:
        categoria = "Premium"
    }

    // TODO 18: Ticket
    let sep = String(repeating: "=", count: 45)

    print(sep)
    print(" TICKET DE COMPRA 2.0")
    print(" Cliente: \(cliente) (\(categoria))")
    print(sep)

    for i in 0..<nombres.count {
        print("\(nombres[i]) x\(cantidades[i]) S/. \(subtotales[i])")
    }

    print(sep)
    print("Subtotal: S/. \(totalCarrito)")

    if descPct > 0 {
        print("Descuento (\(descPct * 100)%): -S/. \(descuento)")
    }

    print("IGV (18%): S/. \(igv)")
    print(sep)
    print("TOTAL: S/. \(totalFinal)")
    print(sep)
    print("¡Gracias por su compra, \(cliente)!")
}
