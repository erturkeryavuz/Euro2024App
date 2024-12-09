import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import FirebaseAuth

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        super.init()
    }
    
    func addData<T: Encodable>(collection: String, data: T, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try firestore.collection(collection).addDocument(from: data)
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchData<T: Decodable>(collection: String, completion: @escaping (Result<[T], Error>) -> Void) {
        firestore.collection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let documents = snapshot?.documents.compactMap { document in
                    try? document.data(as: T.self)
                }
                completion(.success(documents ?? []))
            }
        }
    }

    func updateData(collection: String, documentID: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        firestore.collection(collection).document(documentID).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
