import SwiftUI

struct MatchDetailView: View {
    let match: Match
    @ObservedObject var teamViewModel: TeamViewModel
    @ObservedObject var playerViewModel: PlayerViewModel

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
                
                VStack(alignment: .center) {
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
                    .padding(.horizontal)
                    
                    Text("Score: \(match.team1_score) - \(match.team2_score)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical)

                    ScrollView {
                        VStack {
                            Text("Possession: \(match.possession_team1)% - \(match.possession_team2)%")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.bottom)
                            
                            // Olayları topla ve sırala
                            let events = collectEvents(from: match).sorted { $0.minute < $1.minute }

                            // Olayları göster
                            ForEach(events, id: \.self) { event in
                                HStack {
                                    eventIcon(for: event.type)
                                    playerImage(for: event.playerID)
                                    VStack(alignment: .leading) {
                                        Text(eventDescription(for: event))
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                        if let assistPlayerID = event.assistPlayerID {
                                            HStack {
                                                Image(systemName: "arrow.right.circle")
                                                    .foregroundColor(.green)
                                                    .padding(.trailing, 4)
                                                playerImage(for: assistPlayerID)
                                                Text("Assist: \(playerViewModel.getPlayerName(by: assistPlayerID))")
                                                    .font(.caption2)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 2)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    }
                }
                .padding()
            }
        }
    }

    private func collectEvents(from match: Match) -> [MatchEvent] {
        var events: [MatchEvent] = []

        // Goller
        events.append(contentsOf: match.team1_goals.map {
            MatchEvent(type: .goal, minute: $0.minute, playerID: $0.player_id, assistPlayerID: $0.assist_player_id, teamID: match.team1_id)
        })
        events.append(contentsOf: match.team2_goals.map {
            MatchEvent(type: .goal, minute: $0.minute, playerID: $0.player_id, assistPlayerID: $0.assist_player_id, teamID: match.team2_id)
        })

        // Sarı kartlar
        events.append(contentsOf: match.team1_yellow_cards.map {
            MatchEvent(type: .yellowCard, minute: $0.minute, playerID: $0.player_id, assistPlayerID: nil, teamID: match.team1_id)
        })
        events.append(contentsOf: match.team2_yellow_cards.map {
            MatchEvent(type: .yellowCard, minute: $0.minute, playerID: $0.player_id, assistPlayerID: nil, teamID: match.team2_id)
        })

        // Kırmızı kartlar
        events.append(contentsOf: match.team1_red_cards.map {
            MatchEvent(type: .redCard, minute: $0.minute, playerID: $0.player_id, assistPlayerID: nil, teamID: match.team1_id)
        })
        events.append(contentsOf: match.team2_red_cards.map {
            MatchEvent(type: .redCard, minute: $0.minute, playerID: $0.player_id, assistPlayerID: nil, teamID: match.team2_id)
        })

        return events
    }

    private func playerImage(for playerID: Int) -> some View {
        let imageName = playerViewModel.getPlayerImageName(by: playerID)
        if let uiImage = UIImage(named: imageName) {
            return Image(uiImage: uiImage)
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
                .padding(.trailing, 8)
        } else {
            print("Image not found for playerID: \(playerID), imageName: \(imageName)")
            return Image(systemName: "person.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
                .padding(.trailing, 8)
        }
    }

    private func eventIcon(for eventType: MatchEvent.EventType) -> some View {
        switch eventType {
        case .goal:
            return Image(systemName: "soccerball")
                .foregroundColor(.green)
        case .yellowCard:
            return Image(systemName: "rectangle.fill")
                .foregroundColor(.yellow)
        case .redCard:
            return Image(systemName: "rectangle.fill")
                .foregroundColor(.red)
        }
    }

    private func eventDescription(for event: MatchEvent) -> String {
        let playerName = playerViewModel.getPlayerName(by: event.playerID)
        let teamName = teamViewModel.getTeamName(by: event.teamID)

        switch event.type {
        case .goal:
            return "Minute \(event.minute): \(playerName) scored for \(teamName)"
        case .yellowCard:
            return "Minute \(event.minute): \(playerName) got a yellow card for \(teamName)"
        case .redCard:
            return "Minute \(event.minute): \(playerName) got a red card for \(teamName)"
        }
    }
}

struct MatchEvent: Hashable {
    enum EventType {
        case goal
        case yellowCard
        case redCard
    }

    let type: EventType
    let minute: Int
    let playerID: Int
    let assistPlayerID: Int?
    let teamID: Int
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let match = Match(team1_id: 1, team2_id: 2, team1_score: 2, team2_score: 1, team1_goals: [], team2_goals: [], team1_yellow_cards: [], team2_yellow_cards: [], team1_red_cards: [], team2_red_cards: [], possession_team1: 50, possession_team2: 50)
        let teamViewModel = TeamViewModel()
        let playerViewModel = PlayerViewModel()
        MatchDetailView(match: match, teamViewModel: teamViewModel, playerViewModel: playerViewModel)
    }
}
