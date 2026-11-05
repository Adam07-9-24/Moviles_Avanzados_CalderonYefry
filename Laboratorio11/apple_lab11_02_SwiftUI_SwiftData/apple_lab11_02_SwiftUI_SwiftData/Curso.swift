import Foundation
import SwiftData

// Un curso puede tener muchos alumnos.
@Model
class Curso {
    var nombre: String

    // Al borrar el curso, los alumnos permanecen sin curso.
    @Relationship(deleteRule: .nullify, inverse: \Alumno.curso)
    var alumnos: [Alumno] = []

    init(nombre: String) {
        self.nombre = nombre
    }
}
