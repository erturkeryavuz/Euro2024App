import Foundation
import FirebaseFirestoreSwift

struct Card: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let player_id: Int
    let minute: Int
}
