import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TeamDetailView: View {
    var team: Team
    @StateObject private var playerViewModel = PlayerViewModel()

    var body: some View {
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
                    if playerViewModel.players.isEmpty {
                        Text("Loading players...")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                Spacer().frame(height: 20) // Üstteki boşluğu kapatmak için Spacer ekledik
                                ForEach(playersInTeam) { player in
                                    HStack {
                                        if let uiImage = UIImage(named: player.imageName) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                                .padding(.trailing, 8)
                                        } else {
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                                .padding(.trailing, 8)
                                        }

                                        VStack(alignment: .leading) {
                                            Text(player.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(player.position)
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                            Text("Rating: \(player.rating)")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                }
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                        }
                    }

                    if let errorMessage = playerViewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.horizontal, 20)
                .onAppear {
                    playerViewModel.fetchPlayers()
                }
            }
            .navigationBarTitle("\(team.name) Players", displayMode: .inline)
        }
    }

    var playersInTeam: [Player] {
        playerViewModel.players.filter { $0.team_id == team.team_id }
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let team = Team(team_id: 1, name: "Preview Team", rating: 100, logo: "team_logo")
        TeamDetailView(team: team)
    }
}
