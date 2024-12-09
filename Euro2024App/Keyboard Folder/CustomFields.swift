import SwiftUI

struct CustomInputField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.black.opacity(0.1)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .cornerRadius(40)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
            .padding(.horizontal, 60)
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}

struct CustomSecureInputField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.black.opacity(0.1)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .cornerRadius(40)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
            .padding(.horizontal, 60)
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
