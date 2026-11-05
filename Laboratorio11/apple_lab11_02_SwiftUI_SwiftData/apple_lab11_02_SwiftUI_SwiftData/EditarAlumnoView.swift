import SwiftUI
import SwiftData

struct EditarAlumnoView: View {
    @Bindable var alumno: Alumno
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarError = false
    @State private var mensajeError = ""

    private var camposVacios: Bool {
        alumno.apellido.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        alumno.nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        alumno.dni.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del Alumno") {
                    TextField("Apellido", text: $alumno.apellido)
                    TextField("Nombre", text: $alumno.nombre)
                    TextField("DNI", text: $alumno.dni)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Editar Alumno")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") {
                        do {
                            // Guardamos antes de cerrar para asegurar la persistencia.
                            try modelContext.save()
                            dismiss()
                        } catch {
                            mensajeError = error.localizedDescription
                            mostrarError = true
                            print("Error al editar alumno: \(error)")
                        }
                    }
                    .disabled(camposVacios)
                }
            }
            .interactiveDismissDisabled()
            .alert("No se pudo guardar", isPresented: $mostrarError) {
                Button("Aceptar", role: .cancel) { }
            } message: {
                Text(mensajeError)
            }
        }
    }
}
