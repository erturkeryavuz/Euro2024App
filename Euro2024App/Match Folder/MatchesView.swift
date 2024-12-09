import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct MatchesView: View {
    @StateObject private var matchViewModel = MatchViewModel()
    @StateObject private var teamViewModel = TeamViewModel()
    @StateObject private var playerViewModel = PlayerViewModel()

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
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(matchViewModel.matches) { match in
                                    NavigationLink(destination: MatchDetailView(match: match, teamViewModel: teamViewModel, playerViewModel: playerViewModel)) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Image(teamViewModel.getTeamLogo(by: match.team1_id))
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                Text(teamViewModel.getTeamName(by: match.team1_id))
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("vs")
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text(teamViewModel.getTeamName(by: match.team2_id))
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                Image(teamViewModel.getTeamLogo(by: match.team2_id))
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                            }
                                            Text("Score: \(match.team1_score) - \(match.team2_score)")
                                                .font(.headline) // Biraz daha büyük bir font
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center) // Ortalamak için

                                               
                                        }
                                        .padding()
                                        .background(Color.black.opacity(0.5)) // Şeffaf siyah arka plan rengi
                                        .cornerRadius(10)
                                        .padding(.horizontal, 10)
                                    }
                                }
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
