import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("username") private var username: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    @State private var navigateToMain = false
    @State private var navigateToRegister = false
    @State private var navigateToEuro2024App = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("login1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.bottom, 50)

                        CustomInputField(placeholder: "Email", text: $email)
                        CustomSecureInputField(placeholder: "Password", text: $password)

                        HStack {
                            Spacer()
                            Text("Remember Me")
                                .foregroundColor(.white)
                            Spacer()
                            Text("Forget Password?")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                    }

                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            alertMessage = "Please fill in all fields"
                            showingAlert = true
                        } else {
                            authenticateUser()
                        }
                    }) {
                        Text("Log in")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.black.opacity(0.4)]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .cornerRadius(40)
                            .padding(.horizontal, 90)
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                            if alertMessage == "Login Successful" {
                                isLoggedIn = true
                                username = email
                                userEmail = email
                                navigateToMain = true
                            }
                        })
                    }

                    Spacer()

                    VStack {
                        Button(action: {
                            navigateToRegister = true
                        }) {
                            Text("Don't have an account? Register")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.clear)
                        }
                        .padding(.bottom, 10)

                        Button(action: {
                            navigateToEuro2024App = true
                        }) {
                            Text("Euro2024App")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.clear)
                        }
                        .padding(.bottom, 20)
                    }
                }
                .padding()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $navigateToMain) {
                    MainView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $navigateToRegister) {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $navigateToEuro2024App) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func authenticateUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showingAlert = true
            } else {
                alertMessage = "Login Successful"
                showingAlert = true
                userEmail = email // Save the email to AppStorage
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
