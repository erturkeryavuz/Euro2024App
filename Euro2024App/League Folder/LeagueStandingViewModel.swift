import SwiftUI
import Combine

class LeagueStandingViewModel: ObservableObject {
    @Published var standings: [Standing] = []

    private var cancellables = Set<AnyCancellable>()

    init(matchViewModel: MatchViewModel, teamViewModel: TeamViewModel) {
        matchViewModel.$matches
            .combineLatest(teamViewModel.$teams)
            .map { matches, teams in
                self.calculateStandings(matches: matches, teams: teams)
            }
            .assign(to: \.standings, on: self)
            .store(in: &cancellables)
    }

    private func calculateStandings(matches: [Match], teams: [Team]) -> [Standing] {
        var standingsDict: [Int: Standing] = [:]

        // Initialize standings for each team
        for team in teams {
            standingsDict[team.team_id] = Standing(teamID: team.team_id, teamName: team.name, teamLogo: team.logo)
        }

        // Calculate points, wins, draws, losses, goals for and against
        for match in matches {
            if let _ = standingsDict[match.team1_id], let _ = standingsDict[match.team2_id] {
                standingsDict[match.team1_id]?.goalsFor += match.team1_score
                standingsDict[match.team1_id]?.goalsAgainst += match.team2_score
                standingsDict[match.team2_id]?.goalsFor += match.team2_score
                standingsDict[match.team2_id]?.goalsAgainst += match.team1_score

                if match.team1_score > match.team2_score {
                    standingsDict[match.team1_id]?.points += 3
                    standingsDict[match.team1_id]?.wins += 1
                    standingsDict[match.team2_id]?.losses += 1
                } else if match.team1_score < match.team2_score {
                    standingsDict[match.team2_id]?.points += 3
                    standingsDict[match.team2_id]?.wins += 1
                    standingsDict[match.team1_id]?.losses += 1
                } else {
                    standingsDict[match.team1_id]?.points += 1
                    standingsDict[match.team2_id]?.points += 1
                    standingsDict[match.team1_id]?.draws += 1
                    standingsDict[match.team2_id]?.draws += 1
                }
            }
        }

        // Convert standings dictionary to array and sort by points
        return standingsDict.values.sorted { $0.points > $1.points }
    }
}
