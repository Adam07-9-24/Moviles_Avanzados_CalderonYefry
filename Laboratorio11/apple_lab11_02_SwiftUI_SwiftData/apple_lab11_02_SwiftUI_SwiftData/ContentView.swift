import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Alumno.apellido) private var alumnos: [Alumno]
    @State private var alumnoSeleccionado: Alumno?
    @State private var mostrarFormulario = false
    @State private var alumnoAEditar: Alumno?
    @State private var busqueda = ""
    @State private var mostrarError = false
    @State private var mensajeError = ""

    private var alumnosFiltrados: [Alumno] {
        if busqueda.isEmpty { return alumnos }
        return alumnos.filter { $0.apellido.localizedCaseInsensitiveContains(busqueda) }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $alumnoSeleccionado) {
                ForEach(alumnosFiltrados) { alumno in
                    NavigationLink(value: alumno) {
                        VStack(alignment: .leading) {
                            Text("\(alumno.apellido), \(alumno.nombre)")
                                .font(.headline)
                            Text("DNI: \(alumno.dni)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteAlumnos)
            }
            .searchable(text: $busqueda, prompt: "Buscar por apellido")
            .navigationTitle("Alumnos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarFormulario = true
                    } label: {
                        Label("Nuevo Alumno", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        asignarCursoDemo()
                    } label: {
                        Label("Curso demo", systemImage: "book")
                    }
                }
            }
        } detail: {
            if let alumno = alumnoSeleccionado {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Detalles del Alumno").font(.title2)
                    Text("Nombre: \(alumno.nombre)")
                    Text("Apellido: \(alumno.apellido)")
                    Text("DNI: \(alumno.dni)")
                    Text("Curso: \(alumno.curso?.nombre ?? "Sin curso")")
                    Button("Editar") { alumnoAEditar = alumno }
                }
                .padding()
            } else {
                Text("Selecciona un alumno")
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            NuevoAlumnoView()
        }
        .sheet(item: $alumnoAEditar) { alumno in
            EditarAlumnoView(alumno: alumno)
        }
        .alert("No se pudo guardar", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) { }
        } message: {
            Text(mensajeError)
        }
    }

    private func deleteAlumnos(offsets: IndexSet) {
        // Los índices pertenecen a la lista filtrada. Se toman antes de borrar.
        let alumnosAEliminar = offsets.map { alumnosFiltrados[$0] }
        withAnimation {
            for alumno in alumnosAEliminar {
                if alumnoSeleccionado == alumno { alumnoSeleccionado = nil }
                modelContext.delete(alumno)
            }
        }
        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            mensajeError = error.localizedDescription
            mostrarError = true
            print("Error al eliminar alumnos: \(error)")
        }
    }

    private func asignarCursoDemo() {
        // Reutilizamos el curso para no duplicarlo al pulsar el libro otra vez.
        var consulta = FetchDescriptor<Curso>(predicate: #Predicate {
            $0.nombre == "Programación en Móviles"
        })
        consulta.fetchLimit = 1
        do {
            let curso = try modelContext.fetch(consulta).first ?? Curso(nombre: "Programación en Móviles")
            modelContext.insert(curso)
            for alumno in alumnos { alumno.curso = curso }
            try modelContext.save()
            print("Curso demo: \(curso.nombre) — \(alumnos.count) alumno(s)")
        } catch {
            modelContext.rollback()
            mensajeError = error.localizedDescription
            mostrarError = true
            print("Error al asignar curso: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Alumno.self, Curso.self], inMemory: true)
}
