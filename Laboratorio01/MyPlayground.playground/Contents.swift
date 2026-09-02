
import Foundation

print("Título del Libro:")
let tituloLibro = readLine() ?? ""

print("Tipo de Usuario (Alumno/Docente/Admin):")
let tipoUsuario = readLine() ?? ""

print("Fecha de Préstamo (dd/MM/yyyy):")
let fechaPrestamo = readLine() ?? ""

print("Fecha de Devolución (dd/MM/yyyy):")
let fechaDevolucion = readLine() ?? ""

let formatoFecha = DateFormatter()
formatoFecha.dateFormat = "dd/MM/yyyy"

let calendario = Calendar.current

let prestamo = formatoFecha.date(from: fechaPrestamo)
let devolucion = formatoFecha.date(from: fechaDevolucion)

var diasOtorgados = 0
var multaBase = 0.0

switch tipoUsuario.lowercased() {
case "alumno":
    diasOtorgados = 7
    multaBase = 1.50

case "docente":
    diasOtorgados = 15
    multaBase = 2.00

case "admin":
    diasOtorgados = 10
    multaBase = 3.00

default:
    diasOtorgados = 0
    multaBase = 0.0
}

var fechaLimite: Date?
var diasAtraso = 0
var multaTotal = 0.0

if let prestamo = prestamo, let devolucion = devolucion {

    fechaLimite = calendario.date(
        byAdding: .day,
        value: diasOtorgados,
        to: prestamo
    )

    if let limite = fechaLimite {
        diasAtraso = max(
            0,
            calendario.dateComponents(
                [.day],
                from: limite,
                to: devolucion
            ).day ?? 0
        )
    }

    if diasAtraso > 0 {
        for dia in 1...diasAtraso {

            if dia <= 3 {
                multaTotal += multaBase

            } else if dia <= 6 {
                multaTotal += multaBase * 1.5

            } else {
                multaTotal += multaBase * 2
            }
        }
    }
}

print("\n----- RESULTADO -----")
print("Libro: \(tituloLibro)")
print("Usuario: \(tipoUsuario)")
print("Fecha Préstamo: \(fechaPrestamo)")

if let limite = fechaLimite {
    print("Fecha Límite: \(formatoFecha.string(from: limite))")
}

print("Fecha Devolución: \(fechaDevolucion)")
print("Días de Atraso: \(diasAtraso)")
print("Multa Total: S/ \(String(format: "%.2f", multaTotal))")

if diasAtraso > 0 {
    print("Estado: Devuelto con atraso")
} else {
    print("Estado: Devuelto a tiempo")
}

if diasAtraso >= 10 {
    print("Situación: Usuario suspendido para nuevos préstamos")
} else {
    print("Situación: Usuario habilitado")
}
