import SwiftUI

struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.news) { news in
                VStack(alignment: .leading) {
                    Text(news.title)
                        .font(.headline)
                    Text(news.content)
                        .font(.subheadline)
                    Text(news.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchNews()
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

