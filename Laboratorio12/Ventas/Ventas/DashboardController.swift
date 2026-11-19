import UIKit
import Charts
import SwiftUI

struct DayAmount: Identifiable {
    let id: Date
    let total: Double
}
struct WeekChart: View {
    let days: [DayAmount]
    var body: some View {
        Chart(days) { day in
            BarMark(x: .value("Día", day.id, unit: .day), y: .value("Ventas", day.total))
                .foregroundStyle(Color(red: 0.01, green: 0.48, blue: 0.44))
                .cornerRadius(4)
        }
        .chartXAxis { AxisMarks(values: .stride(by: .day)) { _ in AxisValueLabel(format: .dateTime.day()) } }
        .padding(12)
        .background(Color.white)
    }
}
final class DashboardController: UIViewController {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var greetingLabel: UILabel!
    @IBOutlet private weak var todayLabel: UILabel!
    @IBOutlet private weak var variationLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var chartContainer: UIView!
    @IBOutlet private weak var rankingStack: UIStackView!
    @IBOutlet private weak var stockStack: UIStackView!
    private var chartHost: UIHostingController<WeekChart>?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render()
    }

    private func render() {
        guard Store.shared.supervisor else { return }
        let all = Store.shared.sales().filter { !$0.anulada }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let todaySales = all.filter { calendar.isDate($0.fecha, inSameDayAs: today) }
        let previous = all.filter { calendar.isDate($0.fecha, inSameDayAs: yesterday) }.reduce(0) { $0 + $1.total }
        let total = todaySales.reduce(0) { $0 + $1.total }
        let month = all.filter { calendar.isDate($0.fecha, equalTo: Date(), toGranularity: .month) }
        let variation = total - previous
        dateLabel.text = Date().formatted(Date.FormatStyle(date: .complete, time: .omitted).locale(Locale(identifier: "es_PE"))).uppercased()
        greetingLabel.text = "Hola, " + (Store.shared.current?.nombre ?? "")
        todayLabel.text = Theme.money(total)
        variationLabel.text = "\(variation >= 0 ? "+" : "")\(Theme.money(variation)) vs. ayer"
        monthLabel.text = Theme.money(month.reduce(0) { $0 + $1.igv })
        countLabel.text = "\(month.count) operaciones vigentes"

        let days = (0..<7).map { index -> DayAmount in
            let day = calendar.date(byAdding: .day, value: index - 6, to: today)!
            return DayAmount(id: day, total: all.filter { calendar.isDate($0.fecha, inSameDayAs: day) }.reduce(0) { $0 + $1.total })
        }
        if let host = chartHost {
            host.rootView = WeekChart(days: days)
        } else {
            let host = UIHostingController(rootView: WeekChart(days: days))
            addChild(host)
            host.view.translatesAutoresizingMaskIntoConstraints = false
            chartContainer.addSubview(host.view)
            NSLayoutConstraint.activate([
                host.view.topAnchor.constraint(equalTo: chartContainer.topAnchor),
                host.view.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor),
                host.view.leadingAnchor.constraint(equalTo: chartContainer.leadingAnchor),
                host.view.trailingAnchor.constraint(equalTo: chartContainer.trailingAnchor)
            ])
            host.didMove(toParent: self)
            chartHost = host
        }
        rankingStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let users: [Usuario] = Store.shared.fetch("Usuario", predicate: NSPredicate(format: "rol == %@", Role.vendedor.rawValue))
        let ranking = users.map { user in
            (user.nombre, month.filter { $0.vendedor == user }.reduce(0) { $0 + $1.total })
        }.sorted { $0.1 > $1.1 }
        for (index, item) in ranking.enumerated() {
            rankingStack.addArrangedSubview(Theme.label("\(index + 1).  \(item.0) · \(Theme.money(item.1))", size: 15, bold: true))
            let bar = UIProgressView(progressViewStyle: .default)
            bar.progressTintColor = Theme.tealDark
            bar.progress = Float(item.1 / max(ranking.first?.1 ?? 0, 1))
            rankingStack.addArrangedSubview(bar)
        }
        if ranking.isEmpty { rankingStack.addArrangedSubview(Theme.label("Aún no hay vendedores.")) }
        stockStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let low: [Producto] = Store.shared.fetch("Producto", predicate: NSPredicate(format: "stock <= 10"), sort: "stock")
        for product in low {
            let label = Theme.label("\(product.nombre) · \(product.stock) unidades")
            label.textColor = product.stock <= 5 ? .systemRed : .systemOrange
            stockStack.addArrangedSubview(label)
        }
        if low.isEmpty { stockStack.addArrangedSubview(Theme.label("Inventario en buen nivel.")) }
    }
}

#Preview {
    WeekChart(days: (0..<7).map { DayAmount(id: Calendar.current.date(byAdding: .day, value: $0 - 6, to: Date())!, total: [180, 275, 145, 350, 245, 210, 425][$0]) })
}
