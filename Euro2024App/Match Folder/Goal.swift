import Foundation
import FirebaseFirestoreSwift

struct Goal: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let player_id: Int
    let minute: Int
    let assist_player_id: Int?
}
