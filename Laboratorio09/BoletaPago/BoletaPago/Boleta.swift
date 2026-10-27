
import Foundation

enum Parametros {
    static let rmv = Decimal(1230)
    static let asignacionFamiliar = Decimal(string: "0.10")!
    static let onp = Decimal(string: "0.13")!
    static let essalud = Decimal(string: "0.09")!
    static let recargo25 = Decimal(string: "1.25")!
    static let recargo35 = Decimal(string: "1.35")!

    static let tasasAFP: [String: TasasAFP] = [
        "AFP Ejemplo": TasasAFP(
            fondo: Decimal(string: "0.10")!,
            comision: Decimal(string: "0.016")!,
            seguro: Decimal(string: "0.0135")!
        )
    ]
}

// MARK: - Modelos

enum SistemaPension: String, CaseIterable, Identifiable {
    case onp = "ONP"
    case afp = "AFP"

    var id: String { rawValue }
}

struct TasasAFP {
    let fondo: Decimal
    let comision: Decimal
    let seguro: Decimal
}

struct DatosTrabajador {
    let sueldoBasico: Decimal
    let diasLaborados: Int
    let tieneHijos: Bool
    let sistemaPension: SistemaPension
    let afp: String
    let horasExtras25: Decimal
    let horasExtras35: Decimal
    let adelantos: Decimal
}

struct Concepto: Identifiable {
    let id = UUID()
    let nombre: String
    let monto: Decimal
}

struct ResultadoBoleta {
    let remuneraciones: [Concepto]
    let descuentos: [Concepto]
    let aportaciones: [Concepto]

    let totalRemuneraciones: Decimal
    let totalDescuentos: Decimal
    let netoPagar: Decimal
}

// MARK: - Validaciones

enum ErrorBoleta: LocalizedError {
    case sueldoInvalido
    case diasInvalidos
    case montoNegativo
    case afpInvalida

    var errorDescription: String? {
        switch self {
        case .sueldoInvalido:
            return "El sueldo básico debe ser mayor que cero."
        case .diasInvalidos:
            return "Los días laborados deben estar entre 1 y 30."
        case .montoNegativo:
            return "Las horas extras y adelantos no pueden ser negativos."
        case .afpInvalida:
            return "Selecciona una AFP válida."
        }
    }
}

// MARK: - Clase calculadora

final class Boleta {

    // Redondear cada concepto a dos decimales.
    private func redondear(_ valor: Decimal) -> Decimal {
        var numero = valor
        var resultado = Decimal()

        NSDecimalRound(&resultado, &numero, 2, .plain)

        return resultado
    }

    func calcular(_ datos: DatosTrabajador) throws -> ResultadoBoleta {

        // 1. Validar datos de entrada.

        guard datos.sueldoBasico > 0 else {
            throw ErrorBoleta.sueldoInvalido
        }

        guard (1...30).contains(datos.diasLaborados) else {
            throw ErrorBoleta.diasInvalidos
        }

        guard datos.horasExtras25 >= 0,
              datos.horasExtras35 >= 0,
              datos.adelantos >= 0 else {
            throw ErrorBoleta.montoNegativo
        }

        // 2. Calcular sueldo computable.

        let sueldoComputable = redondear(
            datos.sueldoBasico / 30 * Decimal(datos.diasLaborados)
        )

        // 3. Calcular asignación familiar.
        // No se prorratea por días.

        let familiar: Decimal = datos.tieneHijos
            ? redondear(Parametros.rmv * Parametros.asignacionFamiliar)
            : 0

        // 4. Calcular valor de la hora ordinaria.

        let valorHora = datos.sueldoBasico / 30 / 8

        // 5. Calcular horas extras.

        let extras25 = redondear(
            valorHora * Parametros.recargo25 * datos.horasExtras25
        )

        let extras35 = redondear(
            valorHora * Parametros.recargo35 * datos.horasExtras35
        )

        // 6. Registrar remuneraciones.

        let remuneraciones = [
            Concepto(nombre: "Sueldo computable", monto: sueldoComputable),
            Concepto(nombre: "Asignación familiar", monto: familiar),
            Concepto(nombre: "Horas extras 25%", monto: extras25),
            Concepto(nombre: "Horas extras 35%", monto: extras35)
        ]

        let totalRemuneraciones = remuneraciones.reduce(Decimal(0)) {
            $0 + $1.monto
        }

        // 7. Calcular ONP o AFP.

        var descuentoONP = Decimal(0)
        var fondoAFP = Decimal(0)
        var comisionAFP = Decimal(0)
        var seguroAFP = Decimal(0)

        switch datos.sistemaPension {

        case .onp:
            descuentoONP = redondear(
                totalRemuneraciones * Parametros.onp
            )

        case .afp:
            guard let tasas = Parametros.tasasAFP[datos.afp] else {
                throw ErrorBoleta.afpInvalida
            }

            fondoAFP = redondear(
                totalRemuneraciones * tasas.fondo
            )

            comisionAFP = redondear(
                totalRemuneraciones * tasas.comision
            )

            seguroAFP = redondear(
                totalRemuneraciones * tasas.seguro
            )
        }

        // 8. Registrar descuentos.

        let descuentos = [
            Concepto(nombre: "ONP", monto: descuentoONP),
            Concepto(nombre: "AFP fondo", monto: fondoAFP),
            Concepto(nombre: "AFP comisión", monto: comisionAFP),
            Concepto(nombre: "AFP seguro", monto: seguroAFP),
            Concepto(nombre: "Adelantos", monto: redondear(datos.adelantos))
        ]

        let totalDescuentos = descuentos.reduce(Decimal(0)) {
            $0 + $1.monto
        }

        // 9. Calcular EsSalud.
        // Lo paga el empleador, no se descuenta al trabajador.

        let essalud = redondear(
            totalRemuneraciones * Parametros.essalud
        )

        let aportaciones = [
            Concepto(nombre: "EsSalud (9%)", monto: essalud)
        ]

        // 10. Calcular neto a pagar.

        let netoPagar = redondear(
            totalRemuneraciones - totalDescuentos
        )

        return ResultadoBoleta(
            remuneraciones: remuneraciones,
            descuentos: descuentos,
            aportaciones: aportaciones,
            totalRemuneraciones: totalRemuneraciones,
            totalDescuentos: totalDescuentos,
            netoPagar: netoPagar
        )
    }
}

