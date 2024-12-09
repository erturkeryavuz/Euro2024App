import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

struct MainView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("username") private var username: String = ""
    @State private var navigateToLogin = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Euro2024 App")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85)) // Matches ile aynı renk
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
            }
            .background(
                Image("home2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .overlay(
                HStack {
                    Text("Welcome, \(username)")
                        .font(.subheadline) // Yazı boyutunu küçük tuttum
                        .bold()
                        .padding(6) // Boyutu küçültmek için padding'i azalttım
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.gray]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                        .padding([.leading, .bottom], 20)
                    Spacer()
                    Button(action: {
                        logout()
                    }) {
                        Text("Logout")
                            .font(.subheadline) // Yazı boyutunu küçük tuttum
                            .bold()
                            .padding(8) // Boyutu küçültmek için padding'i azalttım
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.gray]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15) // Corner radius'u küçülttüm
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .padding([.trailing, .bottom], 20)
                },
                alignment: .bottom
            )
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToLogin) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func createImageButton(imageName: String, text: String) -> some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120) // Bir tık küçültüldü
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
                .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85)) // Aynı gri ton
                .shadow(color: .black, radius: 2, x: 0, y: 2)
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            navigateToLogin = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
