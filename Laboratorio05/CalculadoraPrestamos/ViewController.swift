import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var loanTermTextField: UITextField!

    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calcularPrestamo(_ sender: Any) {
        let capitalInicial = Double(loanAmountTextField.text ?? "") ?? 0
        let tasaAnual = Double(interestRateTextField.text ?? "") ?? 0
        let anios = Double(loanTermTextField.text ?? "") ?? 0

        if capitalInicial <= 0 || tasaAnual <= 0 || anios <= 0 {
            monthlyPaymentLabel.text = "Por favor, ingresa valores válidos."
            totalPaymentLabel.text = ""
            return
        }

        let tasaMensual = (tasaAnual / 100) / 12
        let numeroPagos = anios * 12
        let factor = pow(1 + tasaMensual, numeroPagos)
        let cuotaMensual = capitalInicial * (tasaMensual * factor) / (factor - 1)
        let montoTotal = cuotaMensual * numeroPagos

        monthlyPaymentLabel.text = "Cuota mensual: \(String(format: "%.2f", cuotaMensual))"
        totalPaymentLabel.text = "Monto total: \(String(format: "%.2f", montoTotal))"
    }
}
