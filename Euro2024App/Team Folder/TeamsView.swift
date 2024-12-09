import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


struct TeamsView: View {
    @StateObject private var viewModel = TeamViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("matches bg3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: 50)
                        .scaleEffect(1.2)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        if viewModel.teams.isEmpty {
                            Text("Loading teams...")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(viewModel.teams) { team in
                                        NavigationLink(destination: TeamDetailView(team: team)) {
                                            HStack {
                                                Image(team.logo)
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .clipShape(Circle())
                                                VStack(alignment: .leading) {
                                                    Text(team.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    Text("Rating: \(team.rating)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.blue)
                                                }
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(10)
                                            .padding(.horizontal, 10)
                                        }
                                    }
                                }
                                .padding(.bottom, geometry.safeAreaInsets.bottom)
                            }
                        }

                        if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 20)
                    .onAppear {
                        viewModel.fetchTeams()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
