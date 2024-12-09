import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

struct Player: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    let name: String
    let position: String
    let country: String
    let rating: Int
    let player_id: Int
      let team_id: Int
      let imageName: String
}

