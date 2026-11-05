import SwiftUI
import SwiftData

struct NuevoAlumnoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var apellido = ""
    @State private var nombre = ""
    @State private var dni = ""
    @State private var mostrarError = false
    @State private var mensajeError = ""

    private var camposVacios: Bool {
        apellido.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        dni.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del Alumno") {
                    TextField("Apellido", text: $apellido)
                    TextField("Nombre", text: $nombre)
                    TextField("DNI", text: $dni)
                        .keyboardType(.numberPad)
                }
                Button("Guardar Alumno") {
                    let alumno = Alumno(
                        apellido: apellido.trimmingCharacters(in: .whitespacesAndNewlines),
                        nombre: nombre.trimmingCharacters(in: .whitespacesAndNewlines),
                        dni: dni.trimmingCharacters(in: .whitespacesAndNewlines))
                    modelContext.insert(alumno)
                    do {
                        try modelContext.save()
                        dismiss()
                    } catch {
                        modelContext.rollback()
                        mensajeError = error.localizedDescription
                        mostrarError = true
                        print("Error al guardar alumno: \(error)")
                    }
                }
                .disabled(camposVacios)
            }
            .navigationTitle("Nuevo Alumno")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .alert("No se pudo guardar", isPresented: $mostrarError) {
                Button("Aceptar", role: .cancel) { }
            } message: {
                Text(mensajeError)
            }
        }
    }
}
