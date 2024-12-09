import Foundation
import FirebaseFirestoreSwift

struct Standing: Identifiable {
    var id: Int { teamID }
    let teamID: Int
    let teamName: String
    let teamLogo: String
    var points: Int = 0
    var wins: Int = 0
    var draws: Int = 0
    var losses: Int = 0
    var goalsFor: Int = 0
    var goalsAgainst: Int = 0
    var goalDifference: Int {
        goalsFor - goalsAgainst
    }
}
