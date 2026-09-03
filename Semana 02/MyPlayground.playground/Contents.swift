import Foundation

// INGRESO DE DATOS

print("Título del Libro:")
let tituloLibro = readLine() ?? ""

print("Tipo de Usuario (Alumno/Docente/Administrador/Coordinador):")
let tipoUsuario = readLine() ?? ""

print("¿Cuántos días desea solicitar el libro?")
let diasSolicitados = Int(readLine() ?? "") ?? 0

print("Fecha de Préstamo (dd/MM/yyyy):")
let fechaPrestamo = readLine() ?? ""

print("Fecha de Devolución (dd/MM/yyyy):")
let fechaDevolucion = readLine() ?? ""

// CONFIGURACIÓN DE FECHAS

let formatoFecha = DateFormatter()
formatoFecha.dateFormat = "dd/MM/yyyy"
formatoFecha.isLenient = false

let calendario = Calendar.current

let prestamo = formatoFecha.date(from: fechaPrestamo)
let devolucion = formatoFecha.date(from: fechaDevolucion)

// REGLAS SEGÚN TIPO DE USUARIO

var diasMaximos = 0
var multaBase = 0.0
var usuarioValido = true

switch tipoUsuario.lowercased() {

case "alumno":
    diasMaximos = 7
    multaBase = 1.50

case "docente":
    diasMaximos = 15
    multaBase = 2.00

case "administrador", "admin":
    diasMaximos = 10
    multaBase = 3.00

case "coordinador":
    diasMaximos = 15
    multaBase = 4.00

default:
    usuarioValido = false
    print("ERROR: Tipo de usuario no válido.")
}

// VARIABLES PARA EL RESULTADO

var fechaLimite: Date?
var diasAtraso = 0
var multaTotal = 0.0

// VALIDAR SOLICITUD

if usuarioValido {

    if diasSolicitados <= 0 {

        print("ERROR: La cantidad de días debe ser mayor que 0.")

    } else if diasSolicitados > diasMaximos {

        print("\n----- SOLICITUD RECHAZADA -----")
        print("El usuario \(tipoUsuario) no puede solicitar \(diasSolicitados) días.")
        print("Máximo permitido: \(diasMaximos) días.")

    } else {

        // SOLICITUD ACEPTADA

        print("\nSolicitud aceptada.")
        print("Días solicitados: \(diasSolicitados)")
        print("Máximo permitido para \(tipoUsuario): \(diasMaximos) días")

        // VALIDAR FECHAS

        if let prestamo = prestamo, let devolucion = devolucion {

            // La fecha límite depende de los días solicitados
            fechaLimite = calendario.date(
                byAdding: .day,
                value: diasSolicitados,
                to: prestamo
            )

            if let limite = fechaLimite {

                // CALCULAR DÍAS DE ATRASO

                diasAtraso = max(
                    0,
                    calendario.dateComponents(
                        [.day],
                        from: limite,
                        to: devolucion
                    ).day ?? 0
                )

                // CALCULAR MULTA PROGRESIVA

                if diasAtraso > 0 {

                    // Solo se calcula multa hasta 20 días
                    let diasParaMulta = min(diasAtraso, 20)

                    for dia in 1...diasParaMulta {

                        if dia <= 3 {

                            // Día 1 al 3: multa normal
                            multaTotal += multaBase

                        } else if dia <= 6 {

                            // Día 4 al 6: 25% adicional
                            multaTotal += multaBase * 1.25

                        } else if dia <= 10 {

                            // Día 7 al 10: 50% adicional
                            multaTotal += multaBase * 1.50

                        } else {

                            // Día 11 al 20: 100% adicional
                            multaTotal += multaBase * 2
                        }
                    }
                }

                // MOSTRAR RESULTADO

                print("\n----- RESULTADO -----")

                print("Libro: \(tituloLibro)")
                print("Usuario: \(tipoUsuario)")
                print("Días Solicitados: \(diasSolicitados)")
                print("Fecha Préstamo: \(fechaPrestamo)")
                print("Fecha Límite: \(formatoFecha.string(from: limite))")
                print("Fecha Devolución: \(fechaDevolucion)")
                print("Días de Atraso: \(diasAtraso)")
                print("Multa Total: S/ \(String(format: "%.2f", multaTotal))")

                if diasAtraso > 0 {
                    print("Estado: Devuelto con atraso")
                } else {
                    print("Estado: Devuelto a tiempo")
                }

                if diasAtraso > 20 {
                    print("Situación: Usuario suspendido para nuevos préstamos")
                } else {
                    print("Situación: Usuario habilitado")
                }
            }

        } else {

            print("ERROR: Las fechas deben tener formato dd/MM/yyyy.")
        }
    }
}
