import Foundation

class NewsViewModel: ObservableObject {
    @Published var news: [News] = []

    func fetchNews() {
        // Sample data, API integration can be added here
        self.news = [
            News(id: UUID(), title: "Euro 2024 Begins!", content: "The biggest football tournament in Europe is starting.", date: "2024-06-10"),
            News(id: UUID(), title: "Teams Ready", content: "The teams that will compete in Euro 2024 are announced.", date: "2024-06-09")
        ]
    }
}
