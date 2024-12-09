import Combine
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = [] // Bu satır doğru kapsamda tanımlanmış olmalı
    @Published var errorMessage: String?

    init() {
        fetchPlayers()
    }

    func fetchPlayers() {
        FirebaseManager.shared.fetchData(collection: "players") { (result: Result<[Player], Error>) in
            switch result {
            case .success(let players):
                DispatchQueue.main.async {
                    self.players = players
                    print("Fetched \(players.count) players successfully.")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("Failed to fetch players: \(error.localizedDescription)")
                }
            }
        }
    }

    func getPlayerName(by id: Int) -> String {
        return players.first { $0.player_id == id }?.name ?? "Unknown"
    }

    func getPlayerImageName(by id: Int) -> String {
        return players.first { $0.player_id == id }?.imageName ?? "Unknown.jpg"
    }
}
