import Combine
import Firebase

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = []
    @Published var errorMessage: String?

    init() {
        fetchTeams()
    }

    func fetchTeams() {
        // Firestore'dan veri çekmek yerine örnek verileri kullanacağız
        let sampleTeams: [Team] = [
            Team(team_id: 1, name: "Germany", rating: 85, logo: "germany logo 1"),
            Team(team_id: 2, name: "France", rating: 90, logo: "france logo 1"),
            Team(team_id: 3, name: "Spain", rating: 91, logo: "spain logo2"),
            Team(team_id: 4, name: "Italy", rating: 87, logo: "italy logo1"),
            Team(team_id: 5, name: "Portugal", rating: 89, logo: "portugal logo1"),
            Team(team_id: 6, name: "Netherlands", rating: 86, logo: "netherlands logo1"),
            Team(team_id: 7, name: "Belgium", rating: 88, logo: "belgium logo1"),
            Team(team_id: 8, name: "England", rating: 89, logo: "england logo1"),
            Team(team_id: 9, name: "Switzerland", rating: 84, logo: "switzerland logo2"),
            Team(team_id: 10, name: "Denmark", rating: 85, logo: "denmark logo1"),
            Team(team_id: 11, name: "Sweden", rating: 83, logo: "sweden logo1"),
            Team(team_id: 12, name: "Poland", rating: 82, logo: "poland logo2"),
            Team(team_id: 13, name: "Turkey", rating: 81, logo: "turk logo1"),
            Team(team_id: 14, name: "Croatia", rating: 84, logo: "croatia logo1"),
            Team(team_id: 15, name: "Russia", rating: 80, logo: "russia logo1"),
            Team(team_id: 16, name: "Austria", rating: 79, logo: "austria logo1"),
            Team(team_id: 17, name: "Czech Republic", rating: 78, logo: "Czech Republic logo1"),
            Team(team_id: 18, name: "Ukraine", rating: 77, logo: "ukraine logo1"),
            Team(team_id: 19, name: "Wales", rating: 76, logo: "wales logo1"),
            Team(team_id: 20, name: "Scotland", rating: 75, logo: "scotland logo1")
        ]

        DispatchQueue.main.async {
            self.teams = sampleTeams
        }
    }

    func getTeamName(by id: Int) -> String {
        return teams.first { $0.team_id == id }?.name ?? "Unknown"
    }

    func getTeamLogo(by id: Int) -> String {
        return teams.first { $0.team_id == id }?.logo ?? ""
    }
}
