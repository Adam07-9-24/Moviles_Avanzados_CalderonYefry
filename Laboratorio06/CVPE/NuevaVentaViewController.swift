import UIKit

class NuevaVentaViewController: UIViewController {

    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecioUnitario: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteresMensual: UITextField!

    var ventaCalculada: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCalcular(_ sender: UIButton) {
        let precioUnitario = Double(tfPrecioUnitario.text ?? "") ?? 0.0
        let cantidad = Double(tfCantidad.text ?? "") ?? 0.0
        let meses = Double(tfMeses.text ?? "") ?? 0.0
        let interesMensual = Double(tfInteresMensual.text ?? "") ?? 0.0

        if meses == 0 {
            return
        }

        let subtotal = precioUnitario * cantidad
        let igv = subtotal * 0.18
        let base = subtotal + igv
        let intereses = base * (interesMensual / 100) * meses
        let total = base + intereses
        let cuota = total / meses

        ventaCalculada = VentaModel(
            subtotal: subtotal,
            igv: igv,
            base: base,
            intereses: intereses,
            total: total,
            cuota: cuota
        )

        performSegue(withIdentifier: "showResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultado" {
            let resultadoViewController = segue.destination as! ResultadoViewController
            resultadoViewController.venta = ventaCalculada
        }
    }
}
