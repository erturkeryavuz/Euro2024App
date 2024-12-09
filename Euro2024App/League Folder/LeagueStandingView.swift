import SwiftUI

struct LeagueStandingView: View {
    @ObservedObject var viewModel: LeagueStandingViewModel

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
                                ForEach(viewModel.standings) { standing in
                                    HStack {
                                        Image(standing.teamLogo)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            Text(standing.teamName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("\(standing.points) pts W: \(standing.wins) D: \(standing.draws) L: \(standing.losses) GF: \(standing.goalsFor) GA: \(standing.goalsAgainst)")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity) // Butonların genişliğini artır
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                }
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationTitle("League Standing")
            .navigationBarHidden(true)
        }
    }
}

struct LeagueStandingView_Previews: PreviewProvider {
    static var previews: some View {
        let matchViewModel = MatchViewModel()
        let teamViewModel = TeamViewModel()
        let leagueStandingViewModel = LeagueStandingViewModel(matchViewModel: matchViewModel, teamViewModel: teamViewModel)
        LeagueStandingView(viewModel: leagueStandingViewModel)
    }
}
