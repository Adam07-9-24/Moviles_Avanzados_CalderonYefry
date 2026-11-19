import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting session: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default", sessionRole: session.role)
    }
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        Theme.configureAppearance()
        window.tintColor = Theme.teal
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        window.makeKeyAndVisible()
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("--verify") {
            Verification.run()
        }
        #endif
    }
}
enum Theme {
    static let navy = UIColor(red: 0.035, green: 0.11, blue: 0.20, alpha: 1)
    static let teal = UIColor(red: 0.035, green: 0.39, blue: 0.96, alpha: 1)
    static let tealDark = UIColor(red: 0.035, green: 0.39, blue: 0.96, alpha: 1)
    static let background = UIColor(red: 0.955, green: 0.972, blue: 0.98, alpha: 1)
    static let muted = UIColor(red: 0.39, green: 0.45, blue: 0.51, alpha: 1)
    static func configureAppearance() {
        let navigation = UINavigationBarAppearance()
        navigation.configureWithOpaqueBackground()
        navigation.backgroundColor = .white
        navigation.shadowColor = UIColor.black.withAlphaComponent(0.04)
        navigation.titleTextAttributes = [.foregroundColor: navy, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        UINavigationBar.appearance().standardAppearance = navigation
        UINavigationBar.appearance().scrollEdgeAppearance = navigation
        UINavigationBar.appearance().tintColor = tealDark
        let tabs = UITabBarAppearance()
        tabs.configureWithOpaqueBackground()
        tabs.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabs
        UITabBar.appearance().scrollEdgeAppearance = tabs
        UITabBar.appearance().tintColor = tealDark
    }
    static func money(_ n: Double) -> String { String(format: "S/ %.2f", n) }
    static func label(_ text: String, size: CGFloat = 16, bold: Bool = false) -> UILabel {
        let l = UILabel(); l.text = text; l.numberOfLines = 0
        l.font = bold ? .systemFont(ofSize: size, weight: .bold) : .systemFont(ofSize: size)
        l.textColor = navy
        return l
    }
    static func card(_ items: [UIView], padding: CGFloat = 18) -> UIStackView {
        let card = stack(items); card.spacing = 10
        card.backgroundColor = .white; card.layer.cornerRadius = 18
        card.layer.borderWidth = 1; card.layer.borderColor = UIColor.black.withAlphaComponent(0.04).cgColor
        card.layer.shadowColor = navy.cgColor; card.layer.shadowOpacity = 0.055
        card.layer.shadowRadius = 12; card.layer.shadowOffset = CGSize(width: 0, height: 5)
        card.isLayoutMarginsRelativeArrangement = true
        card.layoutMargins = .init(top: padding, left: padding, bottom: padding, right: padding)
        return card
    }
    static func field(_ placeholder: String, secure: Bool = false, symbol: String? = nil) -> UITextField {
        let f = UITextField(); f.placeholder = placeholder; f.isSecureTextEntry = secure
        f.borderStyle = .none; f.backgroundColor = background
        f.layer.cornerRadius = 12; f.layer.borderWidth = 1
        f.layer.borderColor = UIColor.black.withAlphaComponent(0.06).cgColor
        f.autocapitalizationType = .none; f.autocorrectionType = .no
        f.heightAnchor.constraint(equalToConstant: 52).isActive = true
        f.accessibilityIdentifier = placeholder
        if let symbol {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 52))
            let icon = UIImageView(image: UIImage(systemName: symbol))
            icon.tintColor = muted; icon.frame = CGRect(x: 15, y: 17, width: 18, height: 18)
            icon.contentMode = .scaleAspectFit; container.addSubview(icon); f.leftView = container; f.leftViewMode = .always
        } else {
            let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1)); f.leftView = spacer; f.leftViewMode = .always
        }
        return f
    }
    static func button(_ title: String, action: UIAction) -> UIButton {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = title; config.baseBackgroundColor = tealDark; config.baseForegroundColor = .white
        config.cornerStyle = .large; config.contentInsets = .init(top: 17, leading: 20, bottom: 17, trailing: 20)
        b.configuration = config; b.addAction(action, for: .touchUpInside)
        return b
    }
    static func secondaryButton(_ title: String, action: UIAction) -> UIButton {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.tinted()
        config.title = title; config.baseBackgroundColor = teal.withAlphaComponent(0.15); config.baseForegroundColor = tealDark
        config.cornerStyle = .large; config.contentInsets = .init(top: 15, leading: 20, bottom: 15, trailing: 20)
        b.configuration = config; b.addAction(action, for: .touchUpInside)
        return b
    }
    static func section(_ text: String) -> UILabel {
        let l = label(text.uppercased(), size: 12, bold: true); l.textColor = muted
        return l
    }
    static func stack(_ views: [UIView]) -> UIStackView {
        let s = UIStackView(arrangedSubviews: views); s.axis = .vertical; s.spacing = 15
        return s
    }
}
extension UIViewController {
    func message(_ text: String) {
        let a = UIAlertController(title: "Ventas", message: text, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(a, animated: true)
    }
    func formLayout(_ stack: UIStackView) {
        view.backgroundColor = Theme.background
        let scroll = UIScrollView(); scroll.keyboardDismissMode = .interactive
        scroll.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll); scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -24),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -48)
        ])
    }
    func showApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabs = storyboard.instantiateViewController(withIdentifier: "MainTabs") as? UITabBarController,
              let navigationControllers = tabs.viewControllers as? [UINavigationController] else { return }

        let identifiers = Store.shared.supervisor
            ? ["NavDashboardController", "NavTeamSalesController", "NavProductsController", "NavClientsController", "NavAccountController"]
            : ["NavProductsController", "NavClientsController", "NavSaleController", "NavMySalesController", "NavAccountController"]
        let icons = Store.shared.supervisor
            ? ["chart.bar.fill", "receipt", "shippingbox", "person.2", "person.crop.circle"]
            : ["shippingbox", "person.2", "plus.circle", "receipt", "person.crop.circle"]
        let selected = identifiers.compactMap { identifier in
            navigationControllers.first { $0.restorationIdentifier == identifier }
        }
        guard selected.count == identifiers.count else { return }
        for (navigation, icon) in zip(selected, icons) {
            if let catalog = navigation.viewControllers.first as? CatalogController {
                catalog.products = navigation.restorationIdentifier == "NavProductsController"
            }
            navigation.viewControllers.first?.title = navigation.tabBarItem.title
            navigation.tabBarItem.image = UIImage(systemName: icon)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: Theme.navy, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
            navigation.navigationBar.standardAppearance = appearance
            navigation.navigationBar.scrollEdgeAppearance = appearance
        }
        tabs.viewControllers = selected
        tabs.tabBar.tintColor = Theme.tealDark
        view.window?.rootViewController = tabs
    }
}
final class LoginController: UIViewController {
    @IBOutlet private weak var user: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gestión de Ventas"
        user.textContentType = .username
        password.textContentType = .password
        errorLabel.text = ""
    }

    @IBAction private func signIn(_ sender: UIButton) {
        do {
            try Store.shared.login(usuario: user.text ?? "", clave: password.text ?? "")
            showApp()
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }

}
final class RegisterController: UIViewController {
    @IBOutlet private weak var name: UITextField!
    @IBOutlet private weak var user: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var confirm: UITextField!
    @IBOutlet private weak var role: UISegmentedControl!
    @IBOutlet private weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"
        role.selectedSegmentIndex = 0
        errorLabel.text = ""
    }

    @IBAction private func register(_ sender: UIButton) {
        do {
            _ = try Store.shared.register(nombre: name.text ?? "", usuario: user.text ?? "",
                clave: password.text ?? "", confirmacion: confirm.text ?? "",
                rol: Role.allCases[role.selectedSegmentIndex])
            showApp()
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }
}
final class AccountController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = Store.shared.current?.nombre
        userLabel.text = "@" + (Store.shared.current?.usuario ?? "")
        roleLabel.text = Store.shared.current?.rol
    }

    @IBAction private func signOut(_ sender: UIButton) {
        Store.shared.current = nil
        view.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
}
