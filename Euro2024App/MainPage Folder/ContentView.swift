import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                MainView()
            } else {
                VStack(spacing: 20) {
                    Text("Euro2024 App")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 50)
                        .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .shadow(color: .black, radius: 2, x: 0, y: 2)

                    VStack(spacing: 20) {
                        HStack(spacing: 15) {
                            NavigationLink(destination: MatchesTabView()) {
                                createImageButton(imageName: "football team button 1", text: "Analyzes")
                            }

                            NavigationLink(destination: ProfileView()) {
                                createImageButton(imageName: "profile button", text: "Profile")
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 15) {
                            NavigationLink(destination: PlayerListView()) {
                                createImageButton(imageName: "players button1", text: "Players")
                            }

                            NavigationLink(destination: NewsView()) {
                                createImageButton(imageName: "football news 1", text: "News")
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    VStack(spacing: 10) {
                        NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                            Text("Login")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.gray]),
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                                )
                                .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90))
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 20)

                        NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                            Text("Register")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.gray]),
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                                )
                                .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90))
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20)

                    Spacer().frame(height: 20)
                }
                .background(
                    Image("home2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func createImageButton(imageName: String, text: String) -> some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                
            Text(text)
                .font(.headline)
                .bold()
                .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                .shadow(color: .black, radius: 2, x: 0, y: 2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
