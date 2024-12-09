import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class MatchViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var errorMessage: String?

    init() {
        fetchMatches()
    }

    func fetchMatches() {
        FirebaseManager.shared.fetchData(collection: "matches") { (result: Result<[Match], Error>) in
            switch result {
            case .success(let matches):
                DispatchQueue.main.async {
                    self.matches = matches
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
