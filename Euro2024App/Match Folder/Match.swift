import Foundation
import FirebaseFirestoreSwift

struct Match: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let team1_id: Int
    let team2_id: Int
    let team1_score: Int
    let team2_score: Int
    let team1_goals: [Goal]
    let team2_goals: [Goal]
    let team1_yellow_cards: [Card]
    let team2_yellow_cards: [Card]
    let team1_red_cards: [Card]
    let team2_red_cards: [Card]
    let possession_team1: Int
    let possession_team2: Int
}
