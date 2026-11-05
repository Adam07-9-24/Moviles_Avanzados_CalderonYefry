import UIKit
import CoreData

extension ViewController {
    // Devuelve coincidencias sin modificar el arreglo que presenta la tabla.
    // CONTAINS[cd] ignora mayúsculas y acentos. Un texto vacío devuelve todos.
    func buscarContactos(texto: String) throws -> [Contacto] {
        let context = conexion()
        let request = NSFetchRequest<Contacto>(entityName: "Contacto")
        let texto = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        if !texto.isEmpty {
            request.predicate = NSPredicate(format: "nombre CONTAINS[cd] %@", texto)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        return try context.fetch(request)
    }

    func contactosDelGrupo(_ grupo: Grupo) throws -> [Contacto] {
        let context = conexion()
        let request = NSFetchRequest<Contacto>(entityName: "Contacto")
        request.predicate = NSPredicate(format: "grupo == %@", grupo)
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        return try context.fetch(request)
    }

    // Prueba manual: ejecutar `try probarRelacion()` desde el depurador.
    // Reutiliza Amigos y relaciona un contacto sin grupo si Amigos está vacío.
    // No se ejecuta en cada inicio ni crea contactos ficticios.
    @discardableResult
    func probarRelacion() throws -> Grupo {
        let context = conexion()
        let request = NSFetchRequest<Grupo>(entityName: "Grupo")
        request.predicate = NSPredicate(format: "nombre == %@", "Amigos")
        request.fetchLimit = 1
        let grupo = try context.fetch(request).first ?? Grupo(context: context)
        grupo.nombre = "Amigos"
        do {
            if try contactosDelGrupo(grupo).isEmpty,
               let contacto = try buscarContactos(texto: "").first(where: { $0.grupo == nil }) {
                contacto.grupo = grupo
            }
            if context.hasChanges { try context.save() }
            let miembros = try contactosDelGrupo(grupo)
            print("Grupo: \(grupo.nombre ?? "") — \(miembros.count) contacto(s)")
            for contacto in miembros {
                print("Contacto: \(contacto.nombre ?? "")")
            }
            if miembros.isEmpty {
                print("No hay contactos sin grupo. Agrega uno con el botón + y repite la prueba.")
            }
            return grupo
        } catch {
            context.rollback()
            throw error
        }
    }
}
