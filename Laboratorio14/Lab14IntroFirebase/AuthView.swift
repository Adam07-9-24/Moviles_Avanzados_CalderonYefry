import SwiftUI
import FirebaseAuth

struct AuthView: View {
    // true: Actividad 01; false: Actividad 02.
    private let showWelcomeActivity = false
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var authStateListener: AuthStateDidChangeListenerHandle?

    var body: some View {
        VStack(spacing: 0) {
            Text("Lab 14: Firebase")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity)
                .padding(.top, 24)
            if isSignedIn {
                if showWelcomeActivity {
                    Spacer()
                    VStack(spacing: 16) {
                        Text("Welcome!").font(.title.bold()).foregroundColor(.green)
                        Text("You are signed in")
                        Button("Sign Out", action: signOut).buttonStyle(SignOutButtonStyle())
                    }
                    Spacer()
                } else {
                    MessagesView(signOut: signOut)
                }
            } else {
                Spacer()
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .textFieldStyle(.roundedBorder)
                    HStack(spacing: 16) {
                        Button("Sign In", action: signIn).buttonStyle(PrimaryButtonStyle())
                        Button("Sign Up", action: signUp).buttonStyle(SecondaryButtonStyle())
                    }
                }.padding(.horizontal, 30)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear(perform: checkAuthState)
        .onDisappear {
            if let listener = authStateListener {
                Auth.auth().removeStateDidChangeListener(listener)
                authStateListener = nil
            }
        }
        .alert("Message", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: { Text(alertMessage) }
    }

    private func showMessage(_ message: String) {
        alertMessage = message
        showAlert = true
    }

    private func signIn() {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.isEmpty else {
            showMessage("Please enter email and password."); return
        }
        Auth.auth().signIn(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password) { _, error in
            if let error = error { showMessage(error.localizedDescription) }
            else { password = ""; showMessage("Sign in successful!") }
        }
    }

    private func signUp() {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.isEmpty else {
            showMessage("Please enter email and password."); return
        }
        guard password.count >= 6 else { showMessage("Password must be at least six characters."); return }
        Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password) { _, error in
            if let error = error { showMessage(error.localizedDescription) }
            else { password = ""; showMessage("Account created successfully!") }
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            password = ""
            showMessage("Signed out successfully!")
        } catch { showMessage(error.localizedDescription) }
    }

    private func checkAuthState() {
        guard authStateListener == nil else { return }
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            isSignedIn = user != nil
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(maxWidth: .infinity).padding(.vertical, 12)
            .foregroundColor(.white).background(Color.blue.opacity(configuration.isPressed ? 0.7 : 1))
            .cornerRadius(10)
    }
}
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(maxWidth: .infinity).padding(.vertical, 12)
            .foregroundColor(.blue).background(Color.clear)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
struct SignOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.padding(.horizontal, 24).padding(.vertical, 12)
            .foregroundColor(.white).background(Color.red.opacity(configuration.isPressed ? 0.7 : 1))
            .cornerRadius(10)
    }
}
