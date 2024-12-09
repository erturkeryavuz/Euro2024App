import Foundation
import FirebaseFirestoreSwift

struct Team: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    let team_id: Int
    let name: String
    let rating: Int
    let logo: String // Logonun dosya adı
}
