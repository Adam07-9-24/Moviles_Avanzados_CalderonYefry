//
//  ViewController.swift
//  apple_lab11_01_UIKit_CoreData
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var contactos = [Contacto]()
    // Obtiene el contexto que administra los objetos de Core Data.
    func conexion() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func mostrarRutaBaseDeDatos() {
        if let url = conexion().persistentStoreCoordinator?.persistentStores.first?.url {
            print("Core Data — archivo SQLite: \(url.path)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Se conserva el outlet tableView conectado en Main.storyboard.
        tableView.dataSource = self
        tableView.delegate = self
        mostrarRutaBaseDeDatos()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        cargarInfoCoreData()
    }

    func cargarInfoCoreData() {
        let contexto = conexion()
        let fetchRequest: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        do {
            contactos = try contexto.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            mostrarError("No se pudieron cargar los contactos.", error: error)
        }
    }

    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {
        presentarFormulario(contacto: nil)
    }

    private func presentarFormulario(contacto: Contacto?) {
        let alert = UIAlertController(title: contacto == nil ? "Nuevo contacto" : "Editar contacto",
                                      message: "Ingresa nombre, teléfono y dirección.",
                                      preferredStyle: .alert)
        alert.addTextField {
            $0.text = contacto?.nombre
            $0.placeholder = "Nombre"
            $0.autocapitalizationType = .words
            $0.textContentType = .name
        }
        alert.addTextField {
            $0.text = contacto?.telefono
            $0.placeholder = "Teléfono"
            $0.keyboardType = .phonePad
            $0.textContentType = .telephoneNumber
        }
        alert.addTextField {
            $0.text = contacto?.direccion
            $0.placeholder = "Dirección"
            $0.autocapitalizationType = .words
            $0.textContentType = .fullStreetAddress
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Guardar", style: .default) { [weak self, weak alert] _ in
            guard let self, let fields = alert?.textFields else { return }
            let nombre = (fields[0].text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let telefono = (fields[1].text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let direccion = (fields[2].text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !nombre.isEmpty, !telefono.isEmpty, !direccion.isEmpty else {
                let aviso = UIAlertController(title: "Datos incompletos",
                                              message: "Completa los tres campos para guardar el contacto.",
                                              preferredStyle: .alert)
                aviso.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(aviso, animated: true)
                return
            }
            let contexto = self.conexion()
            // Si ya existe, se edita. Si no existe, se crea en Core Data.
            let contacto = contacto ?? (NSEntityDescription.insertNewObject(
                forEntityName: "Contacto", into: contexto) as! Contacto)
            contacto.nombre = nombre
            contacto.telefono = telefono
            contacto.direccion = direccion
            do {
                try contexto.save()
                self.cargarInfoCoreData()
            } catch {
                contexto.rollback()
                self.mostrarError("No se pudo guardar el contacto.", error: error)
            }
        })
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactoCell", for: indexPath)
        let contacto = contactos[indexPath.row]
        cell.textLabel?.text = contacto.nombre
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(contacto.telefono ?? "")\n\(contacto.direccion ?? "")"
        cell.detailTextLabel?.numberOfLines = 0
        cell.selectionStyle = .default
        return cell
    }

    // UPDATE: la misma pantalla de entrada conserva los valores actuales.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentarFormulario(contacto: contactos[indexPath.row])
    }

    // DELETE: UIKit muestra la acción Eliminar al deslizar hacia la izquierda.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        eliminarContacto(at: indexPath)
    }

    func eliminarContacto(at indexPath: IndexPath) {
        let contexto = conexion()
        let contactoEliminar = contactos[indexPath.row]
        contexto.delete(contactoEliminar)
        do {
            try contexto.save()
            cargarInfoCoreData()
        } catch {
            contexto.rollback()
            mostrarError("No se pudo eliminar el contacto.", error: error)
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Eliminar"
    }

    private func mostrarError(_ mensaje: String, error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(mensaje)\n\(error.localizedDescription)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
