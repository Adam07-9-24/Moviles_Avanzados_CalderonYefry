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
        window.rootViewController = UINavigationController(rootViewController: LoginController())
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
    static let teal = UIColor(red: 0.02, green: 0.67, blue: 0.59, alpha: 1)
    static let tealDark = UIColor(red: 0.01, green: 0.48, blue: 0.44, alpha: 1)
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
        let tabs = UITabBarController()
        let supervisor = Store.shared.supervisor
        let pages: [(UIViewController,String,String)] = supervisor ?
            [(DashboardController(),"Resumen","chart.bar.fill"),(SalesController(),"Ventas","receipt"),
             (CatalogController(products: true),"Productos","shippingbox"),(CatalogController(products: false),"Clientes","person.2"),
             (AccountController(),"Cuenta","person.crop.circle")] :
            [(CatalogController(products: true),"Productos","shippingbox"),(CatalogController(products: false),"Clientes","person.2"),
             (SaleController(),"Venta","plus.circle"),(SalesController(),"Mis ventas","receipt"),
             (AccountController(),"Cuenta","person.crop.circle")]
        tabs.viewControllers = pages.map { vc, title, icon in
            vc.title = title
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), selectedImage: nil)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground(); appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: Theme.navy, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
            nav.navigationBar.standardAppearance = appearance; nav.navigationBar.scrollEdgeAppearance = appearance
            return nav
        }
        tabs.tabBar.tintColor = Theme.tealDark
        view.window?.rootViewController = tabs
    }
}
final class LoginController: UIViewController {
    let user = Theme.field("Usuario", symbol: "person.fill")
    let password = Theme.field("Contraseña", secure: true, symbol: "lock.fill")
    let errorLabel = Theme.label("", size: 14)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gestión de Ventas"
        user.textContentType = .username; password.textContentType = .password
        let icon = UIImageView(image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill"))
        icon.tintColor = Theme.tealDark; icon.contentMode = .scaleAspectFit
        icon.heightAnchor.constraint(equalToConstant: 82).isActive = true
        errorLabel.textColor = .systemRed
        formLayout(Theme.stack([
            icon, Theme.label("Gestión de Ventas", size: 32, bold: true),
            Theme.label("Control comercial simple, seguro y organizado.", size: 17),
            Theme.card([Theme.section("Acceso a tu cuenta"), user, password, errorLabel]),
            Theme.button("Ingresar", action: UIAction { [weak self] _ in
                guard let self else { return }
                do { try Store.shared.login(usuario: self.user.text ?? "", clave: self.password.text ?? ""); self.showApp() }
                catch { self.errorLabel.text = error.localizedDescription }
            }),
            Theme.secondaryButton("Crear cuenta", action: UIAction { [weak self] _ in
                self?.navigationController?.pushViewController(RegisterController(), animated: true)
            }),
            Theme.label("Estudiante · Yefry Calderon", size: 12)
        ]))
    }
}
final class RegisterController: UIViewController {
    let name = Theme.field("Nombre completo", symbol: "person.text.rectangle")
    let user = Theme.field("Usuario", symbol: "at")
    let password = Theme.field("Contraseña (mínimo 6 caracteres)", secure: true, symbol: "lock.fill")
    let confirm = Theme.field("Confirmar contraseña", secure: true, symbol: "checkmark.shield.fill")
    let role = UISegmentedControl(items: Role.allCases.map(\.rawValue))
    let errorLabel = Theme.label("", size: 14)
    override func viewDidLoad() {
        super.viewDidLoad(); title = "Crear cuenta"; role.selectedSegmentIndex = 0
        errorLabel.textColor = .systemRed
        let identity = Theme.card([Theme.section("Datos personales"), name, user])
        let access = Theme.card([Theme.section("Seguridad"), password, confirm])
        let permissions = Theme.card([Theme.section("Rol y permisos"), Theme.label("Selecciona el perfil que utilizarás en la aplicación.", size: 14), role])
        formLayout(Theme.stack([
            Theme.label("Crear cuenta", size: 30, bold: true), Theme.label("Configura tu acceso al equipo comercial."),
            identity, access, permissions, errorLabel,
            Theme.button("Registrarme", action: UIAction { [weak self] _ in
                guard let self else { return }
                do {
                    _ = try Store.shared.register(nombre: self.name.text ?? "", usuario: self.user.text ?? "",
                        clave: self.password.text ?? "", confirmacion: self.confirm.text ?? "",
                        rol: Role.allCases[self.role.selectedSegmentIndex])
                    self.showApp()
                } catch { self.errorLabel.text = error.localizedDescription }
            })
        ]))
    }
}
final class AccountController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let u = Store.shared.current
        let initials = (u?.nombre ?? "YC").split(separator: " ").prefix(2).compactMap(\.first).map(String.init).joined()
        let avatar = Theme.label(initials.uppercased(), size: 28, bold: true)
        avatar.textAlignment = .center; avatar.textColor = .white; avatar.backgroundColor = Theme.navy
        avatar.layer.cornerRadius = 38; avatar.clipsToBounds = true
        avatar.heightAnchor.constraint(equalToConstant: 76).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 76).isActive = true
        let profile = Theme.card([avatar, Theme.label(u?.nombre ?? "", size: 23, bold: true), Theme.label("@"+(u?.usuario ?? "")), Theme.label(u?.rol ?? "", size: 14, bold: true)])
        profile.alignment = .center
        formLayout(Theme.stack([
            Theme.label("Mi cuenta", size: 30, bold: true), profile,
            Theme.card([Theme.section("Información académica"), Theme.label("Gestión de Ventas · Semana 12"), Theme.label("Estudiante: Yefry Calderon", size: 14)]),
            Theme.button("Cerrar sesión", action: UIAction { [weak self] _ in
                Store.shared.current = nil
                self?.view.window?.rootViewController = UINavigationController(rootViewController: LoginController())
            })
        ]))
    }
}
