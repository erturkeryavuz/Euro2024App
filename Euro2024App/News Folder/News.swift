import Foundation

struct News: Identifiable, Codable {
    let id: UUID
    let title: String
    let content: String
    let date: String
}
