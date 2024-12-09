import SwiftUI

struct MatchesTabView: View {
    @State private var selectedSegment = 0
    @StateObject private var matchViewModel = MatchViewModel()
    @StateObject private var teamViewModel = TeamViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("matches bg3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: 30)
                    .scaleEffect(1.3)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Picker("Select View", selection: $selectedSegment) {
                        Text("Matches").tag(0)
                        Text("League Standing").tag(1)
                        Text("Teams").tag(2)
                        Text("Players").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.black.opacity(0.5)) // Arka plan rengi eklendi ve opaklık ayarlandı
                    .cornerRadius(10)
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray.withAlphaComponent(0.5)
                        UISegmentedControl.appearance().backgroundColor = UIColor.black.withAlphaComponent(0.3)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    }

                    VStack {
                        if selectedSegment == 0 {
                            MatchesView()
                        } else if selectedSegment == 1 {
                            LeagueStandingView(viewModel: LeagueStandingViewModel(matchViewModel: matchViewModel, teamViewModel: teamViewModel))
                        } else if selectedSegment == 2 {
                            TeamsView()
                        } else if selectedSegment == 3 {
                            PlayerListView()
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle("Matches")
    }
}

struct MatchesTabView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesTabView()
    }
}
