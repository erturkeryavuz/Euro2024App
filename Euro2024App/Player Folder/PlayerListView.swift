import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FilterMenuView: View {
    @Binding var selectedPosition: String
    @Binding var selectedCountry: String
    @Binding var minimumRating: Int

    let positions = ["All", "Goalkeeper", "Right Back", "Center Back", "Left Back", "Defensive Midfielder", "Center Midfielder", "Attacking Midfielder", "Right Winger", "Striker", "Left Winger"]
    let countries = ["All", "Portugal", "Spain", "Germany", "France", "Italy", "Netherlands", "Belgium", "England", "Switzerland", "Denmark", "Sweden", "Poland", "Turkey", "Croatia", "Russia", "Austria", "Czech Republic", "Ukraine", "Wales", "Scotland"]

    var body: some View {
        VStack {
            HStack {
                Menu {
                    Picker("Position", selection: $selectedPosition) {
                        ForEach(positions, id: \.self) { position in
                            Text(position)
                                .foregroundColor(.white)
                        }
                    }
                } label: {
                    Text(selectedPosition)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }

                Menu {
                    Picker("Country", selection: $selectedCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                                .foregroundColor(.white)
                        }
                    }
                } label: {
                    Text(selectedCountry)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .foregroundColor(.white) // Beyaz metin rengi
                }
            }
            .padding(.horizontal)
            HStack {
                Text("Min Rating")
                    .foregroundColor(.white) // Beyaz metin rengi
                Slider(value: Binding(
                    get: { Double(minimumRating) },
                    set: { minimumRating = Int($0) }
                ), in: 0...100, step: 1)
                .frame(width: 150)
                .accentColor(.white) // Beyaz renk
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.black.opacity(0.5)) // Şeffaf siyah arka plan
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

struct PlayerListView: View {
    @StateObject private var viewModel = PlayerViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var selectedPosition: String = "All"
    @State private var selectedCountry: String = "All"
    @State private var minimumRating: Int = 0
    
    var filteredPlayers: [Player] {
        return viewModel.players.filter { player in
            (selectedPosition == "All" || player.position == selectedPosition) &&
            (selectedCountry == "All" || player.country == selectedCountry) &&
            player.rating >= minimumRating
        }
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("matches bg3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: 50)
                        .scaleEffect(1.2)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        // Filtreleme Menüsü
                        FilterMenuView(selectedPosition: $selectedPosition, selectedCountry: $selectedCountry, minimumRating: $minimumRating)
                            .padding(.horizontal)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredPlayers) { player in
                                    PlayerCardView(player: player)
                                        .frame(width: 120, height: 180)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            viewModel.fetchPlayers()
                        }

                        if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
          
        }
    }
}

struct PlayerCardView: View {
    let player: Player

    var body: some View {
        VStack {
            // Oyuncu fotoğrafı
            if let uiImage = UIImage(named: player.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
            }

            Text(player.name)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(.white) // Beyaz metin rengi
            Text(player.position)
                .font(.caption2)
                .foregroundColor(.white) // Beyaz metin rengi
                .lineLimit(1)
            Text(player.country)
                .font(.caption2)
                .foregroundColor(.white) // Beyaz metin rengi
                .lineLimit(1)
            Text("Rating: \(player.rating)")
                .font(.caption2)
                .foregroundColor(.white) // Beyaz metin rengi
                .lineLimit(1)
        }
        .padding()
        .background(Color.black.opacity(0.5)) // Şeffaf siyah arka plan
        .cornerRadius(10) // Kenarları yuvarla
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 10)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
