import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

struct Message: Identifiable, Codable {
    let id: String
    let text: String
    let userEmail: String
    let timestamp: Date
}

final class DatabaseService: ObservableObject {
    @Published var messages: [Message] = []
    @Published var errorMessage: String?
    private let database = Firestore.firestore()
    private var listener: ListenerRegistration?

    func addMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            errorMessage = "You must be signed in to send a message."
            completion(false)
            return
        }
        let message = Message(id: UUID().uuidString, text: text, userEmail: email, timestamp: Date())
        database.collection("messages").document(message.id).setData([
            "id": message.id, "text": message.text, "userEmail": message.userEmail,
            "timestamp": Timestamp(date: message.timestamp)
        ]) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error { self?.errorMessage = error.localizedDescription }
                completion(error == nil)
            }
        }
    }

    func startListening() {
        guard listener == nil else { return }
        listener = database.collection("messages").order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    DispatchQueue.main.async { self?.errorMessage = error.localizedDescription }
                    return
                }
                guard let snapshot = snapshot else { return }
                do {
                    let messages = try snapshot.documents.map { try $0.data(as: Message.self) }
                    DispatchQueue.main.async { self?.messages = messages }
                } catch {
                    DispatchQueue.main.async { self?.errorMessage = error.localizedDescription }
                }
            }
    }

    func stopListening() { listener?.remove(); listener = nil }
    deinit { listener?.remove() }
}
