import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToLogin = false
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
                    
                    Text("Register")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 50)

                    VStack(spacing: 20) {
                        CustomInputField(placeholder: "Email", text: $email)
                        CustomSecureInputField(placeholder: "Password", text: $password)
                    }

                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            alertMessage = "Please fill in all fields"
                            showingAlert = true
                        } else {
                            registerUser()
                        }
                    }) {
                        Text("Register")
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
                        Alert(
                            title: Text("Registration"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK")) {
                                if alertMessage == "Registration Successful" {
                                    navigateToLogin = true
                                }
                            }
                        )
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            navigateToLogin = true
                        }) {
                            Text("Already have an account? Log in")
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
                .navigationDestination(isPresented: $navigateToLogin) {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $navigateToEuro2024App) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .dismissingKeyboard() // Klavyeyi kapatmak için modifier'ı burada uyguluyoruz
    }

    private func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showingAlert = true
            } else {
                alertMessage = "Registration Successful"
                showingAlert = true
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
