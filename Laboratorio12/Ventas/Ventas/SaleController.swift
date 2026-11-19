import UIKit
import CoreData

final class SaleController: UIViewController {
    var clients = [Cliente]()
    var products = [Producto]()
    var client: Cliente?
    var product: Producto?
    @IBOutlet private weak var sellerLabel: UILabel!
    @IBOutlet private weak var clientButton: UIButton!
    @IBOutlet private weak var productButton: UIButton!
    @IBOutlet private weak var quantity: UIStepper!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    @IBOutlet private weak var subtotalValue: UILabel!
    @IBOutlet private weak var discountValue: UILabel!
    @IBOutlet private weak var taxValue: UILabel!
    @IBOutlet private weak var totalValue: UILabel!
    @IBOutlet private weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        sellerLabel.text = Store.shared.current?.nombre
        quantity.minimumValue = 1
        quantity.maximumValue = 1_000_000
        quantity.value = 1
        quantity.addTarget(self, action: #selector(update), for: .valueChanged)
        for button in [clientButton, productButton] {
            button?.contentHorizontalAlignment = .leading
            button?.showsMenuAsPrimaryAction = true
            button?.tintColor = Theme.tealDark
        }
    }

    @IBAction private func registerSale(_ sender: UIButton) {
        register()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clients = Store.shared.fetch("Cliente", sort: "nombre")
        products = Store.shared.fetch("Producto", sort: "nombre")
        if client?.isDeleted == true || client?.managedObjectContext == nil { client = nil }
        if product?.isDeleted == true || product?.managedObjectContext == nil { product = nil }
        clientButton.menu = UIMenu(children: clients.map { c in
            UIAction(title: "\(c.nombre) · \(c.categoria)") { [weak self] _ in self?.client = c; self?.update() }
        })
        productButton.menu = UIMenu(children: products.map { p in
            UIAction(title: "\(p.nombre) · \(Theme.money(p.precio))") { [weak self] _ in self?.product = p; self?.quantity.value = 1; self?.update() }
        })
        update()
    }
    @objc func update() {
        clientButton.setTitle("  "+(client?.nombre ?? "Selecciona un cliente  ▾"), for: .normal)
        productButton.setTitle("  "+(product?.nombre ?? "Selecciona un producto  ▾"), for: .normal)
        quantity.maximumValue = Double(max(product?.stock ?? 1, 1))
        if quantity.value > quantity.maximumValue { quantity.value = quantity.maximumValue }
        stockLabel.text = "Stock disponible · \(product?.stock ?? 0)"
        if let stock = product?.stock {
            stockLabel.textColor = stock > 10 ? .systemGreen : stock >= 6 ? .systemOrange : .systemRed
        } else { stockLabel.textColor = Theme.muted }
        quantityLabel.text = "Cantidad · \(Int(quantity.value))"
        registerButton.isEnabled = client != nil && product != nil && (product?.stock ?? 0) > 0
        guard let product, let client else {
            [subtotalValue, discountValue, taxValue, totalValue].forEach { $0.text = Theme.money(0) }; return
        }
        let a = Importe(precio: product.precio, cantidad: Int(quantity.value), vip: client.categoria == "VIP")
        subtotalValue.text = Theme.money(a.subtotal); discountValue.text = Theme.money(a.descuento)
        taxValue.text = Theme.money(a.igv); totalValue.text = Theme.money(a.total)
    }
    func register() {
        guard let client, let product else { message("Selecciona cliente y producto."); return }
        do {
            let v = try Store.shared.sell(cliente: client, producto: product, cantidad: Int(quantity.value))
            message("Venta registrada · "+Theme.money(v.total))
            quantity.value = 1; update()
        } catch { message(error.localizedDescription) }
    }
}
