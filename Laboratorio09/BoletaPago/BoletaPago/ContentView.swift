
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

                // Mensaje de validación
                if !mensajeError.isEmpty {
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "exclamationmark.circle.fill")

                        Text(mensajeError)
                            .font(.subheadline)
                    }
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .background(
                        Color.red.opacity(0.08),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                }

                // Mostrar boleta solo si el cálculo fue válido
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

        // Invalidar resultados al modificar cualquier dato
        .onChange(of: sueldo) { _, _ in limpiarResultado() }
        .onChange(of: dias) { _, _ in limpiarResultado() }
        .onChange(of: tieneHijos) { _, _ in limpiarResultado() }
        .onChange(of: pension) { _, _ in limpiarResultado() }
        .onChange(of: afpSeleccionada) { _, _ in limpiarResultado() }
        .onChange(of: horas25) { _, _ in limpiarResultado() }
        .onChange(of: horas35) { _, _ in limpiarResultado() }
        .onChange(of: adelantos) { _, _ in limpiarResultado() }
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

    // MARK: - Títulos de sección

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

    // MARK: - Bloques de la boleta

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

    // MARK: - Conversión de números

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

    // MARK: - Limpiar resultados anteriores

    private func limpiarResultado() {
        resultado = nil
        mensajeError = ""
    }

    // MARK: - Validaciones y cálculo

    private func calcular() {

        resultado = nil
        mensajeError = ""

        // 1. Verificar campos obligatorios
        let campos = [sueldo, dias, horas25, horas35, adelantos]

        if campos.contains(where: {
            $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }) {
            mensajeError = "Todos los campos numéricos son obligatorios."
            return
        }

        // 2. Validar sueldo básico
        guard let sueldoValor = convertir(sueldo) else {
            mensajeError = "Ingresa un sueldo básico válido."
            return
        }

        guard sueldoValor > 0 else {
            mensajeError = "El sueldo básico debe ser mayor que cero."
            return
        }

        // 3. Validar días laborados
        guard let diasValor = Int(dias) else {
            mensajeError = "Los días laborados deben ser un número entero."
            return
        }

        guard (1...30).contains(diasValor) else {
            mensajeError = "Los días laborados deben estar entre 1 y 30."
            return
        }

        // 4. Validar horas extras al 25%
        guard let horas25Valor = convertir(horas25) else {
            mensajeError = "Ingresa un valor válido para las horas extras al 25%."
            return
        }

        guard horas25Valor >= 0 else {
            mensajeError = "Las horas extras al 25% no pueden ser negativas."
            return
        }

        // 5. Validar horas extras al 35%
        guard let horas35Valor = convertir(horas35) else {
            mensajeError = "Ingresa un valor válido para las horas extras al 35%."
            return
        }

        guard horas35Valor >= 0 else {
            mensajeError = "Las horas extras al 35% no pueden ser negativas."
            return
        }

        // 6. Validar adelantos
        guard let adelantosValor = convertir(adelantos) else {
            mensajeError = "Ingresa un monto válido para los adelantos."
            return
        }

        guard adelantosValor >= 0 else {
            mensajeError = "Los adelantos no pueden ser negativos."
            return
        }

        // 7. Validar AFP
        if pension == .afp &&
            Parametros.tasasAFP[afpSeleccionada] == nil {
            mensajeError = "Selecciona una AFP válida."
            return
        }

        // 8. Crear datos del trabajador
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

        // 9. Ejecutar cálculo
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

