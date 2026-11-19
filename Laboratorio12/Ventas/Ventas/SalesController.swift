import UIKit

final class SalesController: UITableViewController, UISearchResultsUpdating {
    var rows = [Venta]()
    @IBOutlet private weak var period: UISegmentedControl!
    @IBOutlet private weak var seller: UIButton!
    @IBOutlet private weak var todaySummary: UILabel!
    @IBOutlet private weak var monthSummary: UILabel!
    let search = UISearchController(searchResultsController: nil)
    var selectedSeller: Usuario?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Theme.background
        tableView.rowHeight = 116
        tableView.separatorStyle = .none
        search.searchResultsUpdater = self; search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Buscar por cliente"
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        period.selectedSegmentIndex = 0
        period.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); refresh() }
    func updateSearchResults(for searchController: UISearchController) { refresh() }
    @objc func refresh() {
        rows = Store.shared.sales(text: search.searchBar.text ?? "", period: period.selectedSegmentIndex, seller: selectedSeller)
        let all = Store.shared.sales().filter { !$0.anulada }
        let today = all.filter { Calendar.current.isDateInToday($0.fecha) }.reduce(0) { $0+$1.total }
        let month = all.filter { Calendar.current.isDate($0.fecha, equalTo: Date(), toGranularity: .month) }.reduce(0) { $0+$1.total }
        let todayCount = all.filter { Calendar.current.isDateInToday($0.fecha) }.count
        let monthCount = all.filter { Calendar.current.isDate($0.fecha, equalTo: Date(), toGranularity: .month) }.count
        todaySummary.text = "Hoy\n\(Theme.money(today)) · \(todayCount) ventas"
        monthSummary.text = "Mes\n\(Theme.money(month)) · \(monthCount) ventas"
        seller.isHidden = !Store.shared.supervisor
        if Store.shared.supervisor {
            let users: [Usuario] = Store.shared.fetch("Usuario", predicate: NSPredicate(format: "rol == %@", Role.vendedor.rawValue), sort: "nombre")
            let allAction = UIAction(title: "Todos", state: selectedSeller == nil ? .on : .off) { [weak self] _ in
                self?.selectedSeller = nil
                self?.refresh()
            }
            let actions = users.map { user in
                UIAction(title: user.nombre, state: selectedSeller == user ? .on : .off) { [weak self] _ in
                    self?.selectedSeller = user
                    self?.refresh()
                }
            }
            seller.setTitle(selectedSeller?.nombre ?? "Todos los vendedores", for: .normal)
            seller.menu = UIMenu(children: [allAction] + actions)
            seller.showsMenuAsPrimaryAction = true
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { rows.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let v = rows[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear; cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 15; cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.04).cgColor
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        let heading = "\(v.cliente?.nombre ?? "") · \(Theme.money(v.total))"
        if v.anulada {
            cell.textLabel?.attributedText = NSAttributedString(string: heading, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.textLabel?.textColor = .secondaryLabel
        } else { cell.textLabel?.text = heading; cell.textLabel?.textColor = Theme.navy }
        let date = v.fecha.formatted(date: .abbreviated, time: .shortened)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(v.producto?.nombre ?? "") × \(v.cantidad) · \(date)\nVendedor · \(v.vendedor?.nombre ?? "")" +
            (v.anulada ? "\nANULADA · \(v.motivoAnulacion ?? "")" : "\nIGV · \(Theme.money(v.igv))")
        cell.imageView?.image = UIImage(systemName: v.anulada ? "xmark.circle.fill" : "checkmark.circle.fill")
        cell.imageView?.tintColor = v.anulada ? .systemRed : .systemGreen
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let v = rows[indexPath.row]
        message("\(v.producto?.nombre ?? "") × \(v.cantidad)\nCliente · \(v.cliente?.nombre ?? "")\nDescuento · \(Theme.money(v.descuento))\nIGV · \(Theme.money(v.igv))\nTotal · \(Theme.money(v.total))" + (v.anulada ? "\nEstado · Anulada\nMotivo · \(v.motivoAnulacion ?? "")" : "\nEstado · Vigente"))
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let v = rows[indexPath.row]
        guard Store.shared.supervisor, !v.anulada else { return nil }
        let action = UIContextualAction(style: .destructive, title: "Anular") { [weak self] _,_,done in self?.cancel(v); done(true) }
        let config = UISwipeActionsConfiguration(actions: [action]); config.performsFirstActionWithFullSwipe = false
        return config
    }
    func cancel(_ venta: Venta) {
        let a = UIAlertController(title: "Confirmar anulación", message: "\(venta.producto?.nombre ?? "") × \(venta.cantidad)\nCliente · \(venta.cliente?.nombre ?? "")\nTotal · \(Theme.money(venta.total))\n\nAl confirmar se devolverán \(venta.cantidad) unidades al stock. Esta operación no puede repetirse.", preferredStyle: .alert)
        a.addTextField { $0.placeholder = "Motivo obligatorio" }
        let confirm = UIAlertAction(title: "Anular", style: .destructive) { [weak self, weak a] _ in
            do { try Store.shared.cancel(venta, motivo: a?.textFields?.first?.text ?? ""); self?.refresh() }
            catch { self?.message(error.localizedDescription) }
        }
        confirm.isEnabled = false
        a.textFields?.first?.addAction(UIAction { [weak a, weak confirm] _ in
            confirm?.isEnabled = !(a?.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }, for: .editingChanged)
        a.addAction(confirm); a.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(a, animated: true)
    }
}
