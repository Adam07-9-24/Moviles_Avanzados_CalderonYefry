import SwiftUI

struct MessagesView: View {
    let signOut: () -> Void
    @StateObject private var database = DatabaseService()
    @State private var messageText = ""
    @State private var isSending = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Messages").font(.title2.bold())
                Spacer()
                Button("Sign Out", action: signOut).foregroundColor(.red)
            }.padding()
            List(database.messages) { message in
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.text)
                        Text(message.userEmail).font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(message.timestamp, style: .time).font(.caption).foregroundColor(.secondary)
                }.listRowBackground(Color.white)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGray6))
            HStack {
                TextField("Type a message...", text: $messageText).textFieldStyle(.roundedBorder)
                Button("Send") {
                    let text = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !text.isEmpty else { return }
                    isSending = true
                    database.addMessage(text: text) { success in
                        if success && messageText.trimmingCharacters(in: .whitespacesAndNewlines) == text { messageText = "" }
                        isSending = false
                    }
                }.foregroundColor(.blue)
                    .disabled(isSending || messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }.padding()
        }
        .onAppear { database.startListening() }
        .onDisappear { database.stopListening() }
        .alert("Message", isPresented: Binding(
            get: { database.errorMessage != nil },
            set: { if !$0 { database.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { database.errorMessage = nil }
        } message: { Text(database.errorMessage ?? "") }
    }
}
