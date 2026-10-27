
import SwiftUI

struct ContentView: View {

    // MARK: - Datos del formulario
    @State private var sueldo = ""
    @State private var dias = "30"
    @State private var tieneHijos = false
    @State private var pension: SistemaPension = .onp
    @State private var afpSeleccionada = "AFP Ejemplo"
    @State private var horas25 = "0"
    @State private var horas35 = "0"
    @State private var adelantos = "0"

    // MARK: - Resultado del cálculo
    @State private var resultado: ResultadoBoleta?
    @State private var mensajeError = ""

    private let calculadora = Boleta()

    private let azul = Color(
        red: 0.07, green: 0.25, blue: 0.52
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {

                encabezado

                formulario

                Button(action: calcular) {
                    HStack {
                        Image(systemName: "calculator")
                        Text("CALCULAR BOLETA")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                }
                .buttonStyle(.borderedProminent)
                .tint(azul)

                if !mensajeError.isEmpty {
                    Text(mensajeError)
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .padding(12)
                }

                if let resultado {
                    vistaBoleta(resultado)
                }

                Text("Boleta de ejemplo • Uso académico")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            .padding(20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }

    // MARK: - Encabezado
    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: "doc.text.fill")
                    .font(.title2)
                    .foregroundStyle(azul)

                Text("Boleta de pago")
                    .font(.largeTitle.bold())
            }

            Text("Calculadora de remuneraciones")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Ingresa los datos del trabajador para calcular el sueldo neto.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 12)
    }

    // MARK: - Formulario
    private var formulario: some View {
        VStack(alignment: .leading, spacing: 18) {

            tituloSeccion(
                "DATOS DEL TRABAJADOR",
                icono: "person.text.rectangle"
            )

            campo(
                "Sueldo básico (S/)",
                texto: $sueldo,
                ejemplo: "Ej. 2500"
            )

            campo(
                "Días laborados (1-30)",
                texto: $dias,
                ejemplo: "Ej. 30"
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("¿Tiene hijos?")
                    .font(.subheadline.weight(.medium))

                Picker("¿Tiene hijos?", selection: $tieneHijos) {
                    Text("No").tag(false)
                    Text("Sí").tag(true)
                }
                .pickerStyle(.segmented)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Sistema de pensiones")
                    .font(.subheadline.weight(.medium))

                Picker("Sistema de pensiones", selection: $pension) {
                    Text("ONP").tag(SistemaPension.onp)
                    Text("AFP").tag(SistemaPension.afp)
                }
                .pickerStyle(.segmented)
            }

            if pension == .afp {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Seleccionar AFP")
                        .font(.subheadline.weight(.medium))

                    Picker("AFP", selection: $afpSeleccionada) {
                        Text("AFP Ejemplo")
                            .tag("AFP Ejemplo")
                    }
                    .pickerStyle(.menu)
                }
            }

            Divider()

            tituloSeccion(
                "DATOS ADICIONALES",
                icono: "clock"
            )

            campo(
                "Horas extras al 25%",
                texto: $horas25,
                ejemplo: "0"
            )

            campo(
                "Horas extras al 35%",
                texto: $horas35,
                ejemplo: "0"
            )

            campo(
                "Adelantos (S/)",
                texto: $adelantos,
                ejemplo: "0"
            )
        }
        .padding(18)
        .background(
            Color(uiColor: .secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 18)
        )
    }

    // MARK: - Campo reutilizable
    private func campo(
        _ titulo: String,
        texto: Binding<String>,
        ejemplo: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.subheadline.weight(.medium))

            TextField(ejemplo, text: texto)
                .keyboardType(.decimalPad)
                .padding(12)
                .background(
                    Color(uiColor: .systemBackground),
                    in: RoundedRectangle(cornerRadius: 10)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            Color.gray.opacity(0.18),
                            lineWidth: 1
                        )
                }
        }
    }

    // MARK: - Título de sección
    private func tituloSeccion(
        _ titulo: String,
        icono: String
    ) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icono)
                .foregroundStyle(azul)

            Text(titulo)
                .font(.subheadline.bold())
                .foregroundStyle(azul)
        }
    }

    // MARK: - Boleta de resultados
    private func vistaBoleta(
        _ datos: ResultadoBoleta
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {

            tituloSeccion(
                "RESULTADO DE LA BOLETA",
                icono: "doc.plaintext"
            )

            Text("Resumen de remuneraciones y descuentos")
                .font(.caption)
                .foregroundStyle(.secondary)

            bloque(
                "REMUNERACIONES",
                icono: "plus.circle",
                conceptos: datos.remuneraciones
            )

            fila(
                "Total remuneraciones",
                monto: datos.totalRemuneraciones,
                destacado: true
            )

            Divider()

            bloque(
                "RETENCIONES / DESCUENTOS",
                icono: "minus.circle",
                conceptos: datos.descuentos
            )

            fila(
                "Total descuentos",
                monto: datos.totalDescuentos,
                destacado: true
            )

            Divider()

            bloque(
                "APORTACIONES DEL EMPLEADOR",
                icono: "building.2",
                conceptos: datos.aportaciones
            )

            Text("EsSalud es asumido por el empleador y no se descuenta del sueldo.")
                .font(.caption)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                Text("NETO A PAGAR")
                    .font(.subheadline.bold())

                Text(moneda(datos.netoPagar))
                    .font(.system(size: 34, weight: .bold))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)

                Text("Monto final que recibe el trabajador")
                    .font(.caption)
            }
            .foregroundStyle(.green)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                Color.green.opacity(0.09),
                in: RoundedRectangle(cornerRadius: 12)
            )
        }
        .padding(18)
        .background(
            Color(uiColor: .secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 18)
        )
    }

    // MARK: - Bloques de conceptos
    private func bloque(
        _ titulo: String,
        icono: String,
        conceptos: [Concepto]
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            tituloSeccion(titulo, icono: icono)

            ForEach(conceptos) { concepto in
                fila(
                    concepto.nombre,
                    monto: concepto.monto
                )
            }
        }
    }

    // MARK: - Fila de resultados
    private func fila(
        _ nombre: String,
        monto: Decimal,
        destacado: Bool = false
    ) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(nombre)
                .font(
                    destacado
                    ? .subheadline.bold()
                    : .subheadline
                )
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 4)

            Text(moneda(monto))
                .font(
                    destacado
                    ? .subheadline.bold()
                    : .subheadline
                )
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }

    // MARK: - Formato de moneda
    private func moneda(_ monto: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "PEN"
        formatter.locale = Locale(identifier: "es_PE")

        return formatter.string(
            from: NSDecimalNumber(decimal: monto)
        ) ?? "S/ 0.00"
    }

    // MARK: - Convertir texto a número
    private func convertir(_ texto: String) -> Decimal? {
        let normalizado = texto
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")

        guard !normalizado.isEmpty else {
            return nil
        }

        return Decimal(
            string: normalizado,
            locale: Locale(identifier: "en_US_POSIX")
        )
    }

    // MARK: - Ejecutar cálculo
    private func calcular() {
        resultado = nil
        mensajeError = ""

        guard let sueldoValor = convertir(sueldo),
              let diasValor = Int(dias),
              let horas25Valor = convertir(horas25),
              let horas35Valor = convertir(horas35),
              let adelantosValor = convertir(adelantos) else {
            mensajeError = "Completa los campos con números válidos."
            return
        }

        let trabajador = DatosTrabajador(
            sueldoBasico: sueldoValor,
            diasLaborados: diasValor,
            tieneHijos: tieneHijos,
            sistemaPension: pension,
            afp: afpSeleccionada,
            horasExtras25: horas25Valor,
            horasExtras35: horas35Valor,
            adelantos: adelantosValor
        )

        do {
            resultado = try calculadora.calcular(trabajador)
        } catch {
            mensajeError = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}

