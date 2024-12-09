import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImageSwiftUI

struct ProfileView: View {
    @State private var name: String = ""
    @AppStorage("userEmail") private var email: String = ""
    @AppStorage("userPassword") private var password: String = ""
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    @State private var phoneNumber: String = ""
    @State private var bio: String = ""
    @State private var profileImageUrl: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var favoriteTeam: String = ""
    @State private var favoritePlayer: String = ""
    @State private var favoriteMatch: String = ""
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    @State private var teams: [String] = []
    @State private var players: [String] = []
    @State private var matches: [String] = []
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    
    
    private var storage = Storage.storage().reference() // Define the storage reference
    
    var body: some View {
        ZStack {
            VStack {
                Image("profileviewbg1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top) // Yukarıdaki güvenli alanı yoksay
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
            }
            
            if isLoggedIn {
                ScrollView {
                    VStack(spacing: 20) {
                        profileImageSection
                        formFields
                        updateProfileButton
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding()
                    .onAppear(perform: {
                        loadUserProfile()
                        fetchTeams()
                        fetchPlayers()
                        fetchMatches()
                    })
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                }
            } else {
                Text("Please log in to view your profile.")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
        }
    }
    
    
    var profileImageSection: some View {
        ZStack(alignment: .bottomTrailing) {
            profileImageView
            cameraButton
        }
        .padding(.bottom)
    }
    
    var profileImageView: some View {
        Group {
            if let inputImage = self.inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFill()
            } else if let url = URL(string: profileImageUrl), !profileImageUrl.isEmpty {
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: 150, height: 150)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
    }
    
    var cameraButton: some View {
        Button(action: {
            self.showingImagePicker = true
        }) {
            Image(systemName: "camera")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
    
    var formFields: some View {
        Group {
            textField("Name", text: $name)
            textField("Email", text: $email, isDisabled: true)
            textField("New Email", text: $newEmail)
            textField("Password", text: $password, isSecure: true)
            textField("New Password", text: $newPassword, isSecure: true)
            textField("Phone Number", text: $phoneNumber)
            bioField
            teamPicker
            playerPicker
            matchPicker
        }
    }
    
    var bioField: some View {
        VStack(alignment: .leading) {
            Text("Bio")
                .foregroundColor(.white)
                .font(.headline)
            TextEditor(text: $bio)
                .frame(height: 100)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
    
    var teamPicker: some View {
        VStack(alignment: .leading) {
            Text("Favorite Team")
                .foregroundColor(.white)
                .font(.headline)
            Picker("Select your favorite team", selection: $favoriteTeam) {
                ForEach(teams, id: \.self) { team in
                    Text(team).tag(team)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    var playerPicker: some View {
        VStack(alignment: .leading) {
            Text("Favorite Player")
                .foregroundColor(.white)
                .font(.headline)
            Picker("Select your favorite player", selection: $favoritePlayer) {
                ForEach(players, id: \.self) { player in
                    Text(player).tag(player)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    var matchPicker: some View {
        VStack(alignment: .leading) {
            Text("Favorite Match")
                .foregroundColor(.white)
                .font(.headline)
            Picker("Select your favorite match", selection: $favoriteMatch) {
                ForEach(matches, id: \.self) { match in
                    Text(match).tag(match)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    func textField(_ title: String, text: Binding<String>, isSecure: Bool = false, isDisabled: Bool = false) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            if isSecure {
                SecureField("Enter your \(title.lowercased())", text: text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .disabled(isDisabled)
            } else {
                TextField("Enter your \(title.lowercased())", text: text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .disabled(isDisabled)
            }
        }
        .padding(.horizontal)
    }
    
    var updateProfileButton: some View {
        Button(action: updateProfile) {
            Text("Update Profile")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(radius: 3)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Update Profile"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func loadUserProfile() {
        guard isLoggedIn, let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.name = data?["name"] as? String ?? ""
                self.phoneNumber = data?["phoneNumber"] as? String ?? ""
                self.bio = data?["bio"] as? String ?? ""
                self.favoriteTeam = data?["favoriteTeam"] as? String ?? ""
                self.favoritePlayer = data?["favoritePlayer"] as? String ?? ""
                self.favoriteMatch = data?["favoriteMatch"] as? String ?? ""
                self.profileImageUrl = data?["profileImageUrl"] as? String ?? ""
                updateImageFromURL()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateImageFromURL() {
        if let url = URL(string: self.profileImageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.inputImage = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    func updateProfile() {
        guard isLoggedIn, let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        updateEmail(user)
        updatePassword(user)
        updateProfileImage(user, db: db)
    }
    
    func updateEmail(_ user: User) {
        if !newEmail.isEmpty {
            user.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                if let error = error {
                    self.alertMessage = "Error sending email verification: \(error.localizedDescription)"
                    self.showingAlert = true
                } else {
                    self.alertMessage = "Verification email sent to \(self.newEmail). Please verify to update email."
                    self.showingAlert = true
                }
            }
        }
    }
    
    func updatePassword(_ user: User) {
        if !newPassword.isEmpty {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    self.alertMessage = "Error updating password: \(error.localizedDescription)"
                    self.showingAlert = true
                }
            }
        }
    }
    
    func updateProfileImage(_ user: User, db: Firestore) {
        if let image = inputImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            let imagePath = "profileImages/\(user.uid).jpg"
            storage.child(imagePath).putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                storage.child(imagePath).downloadURL { url, error in
                    if let url = url {
                        updateUserData(user, db: db, imageUrl: url.absoluteString)
                    }
                }
            }
        } else {
            updateUserData(user, db: db)
        }
    }
    
    func updateUserData(_ user: User, db: Firestore, imageUrl: String? = nil) {
        var userData: [String: Any] = [
            "name": self.name,
            "email": self.newEmail.isEmpty ? self.email : self.newEmail,
            "phoneNumber": self.phoneNumber,
            "bio": self.bio,
            "favoriteTeam": self.favoriteTeam,
            "favoritePlayer": self.favoritePlayer,
            "favoriteMatch": self.favoriteMatch
        ]
        if let imageUrl = imageUrl {
            userData["profileImageUrl"] = imageUrl
        }
        db.collection("users").document(user.uid).setData(userData, merge: true) { error in
            if let error = error {
                print("Error updating user data: \(error)")
            } else {
                print("User data updated successfully")
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        self.inputImage = inputImage
    }
    
    // Fetching functions for teams, players, and matches
    func fetchTeams() {
        let db = Firestore.firestore()
        db.collection("teams").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching teams: \(error)")
                return
            }
            self.teams = snapshot?.documents.compactMap { $0.data()["name"] as? String } ?? []
        }
    }
    
    func fetchPlayers() {
        let db = Firestore.firestore()
        db.collection("players").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching players: \(error)")
                return
            }
            self.players = snapshot?.documents.compactMap { $0.data()["name"] as? String } ?? []
        }
    }
    
    func fetchMatches() {
        let db = Firestore.firestore()
        db.collection("matches").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching matches: \(error)")
                return
            }
            var newMatches: [String] = []
            for document in snapshot?.documents ?? [] {
                if let team1Name = document.data()["team1_name"] as? String,
                   let team2Name = document.data()["team2_name"] as? String,
                   let team1Score = document.data()["team1_score"] as? Int,
                   let team2Score = document.data()["team2_score"] as? Int {
                    newMatches.append("\(team1Name) \(team1Score) - \(team2Score) \(team2Name)")
                }
            }
            self.matches = newMatches
        }
    }

    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            return ProfileView()
                .onAppear {
                    UserDefaults.standard.set("user@example.com", forKey: "userEmail")
                    UserDefaults.standard.set("password", forKey: "userPassword")
                }
        }
    }
}



