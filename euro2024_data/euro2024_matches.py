import firebase_admin
from firebase_admin import credentials, firestore
import json

# Firebase admin SDK anahtar dosyanızın yolu
cred = credentials.Certificate('serviceAccountKey.json')  # Dosya adını doğru yola göre güncelleyin
firebase_admin.initialize_app(cred)

db = firestore.client()

def upload_data():
    with open('euro2024_matches.json', 'r') as file:
        matches = json.load(file)
    with open('euro2024_events.json', 'r') as file:
        events = json.load(file)

    # Firestore'a verileri yükle
    for index, match in enumerate(matches, 1):
        # Match'e bağlı eventleri bul
        match_events = [event for event in events if event['match_id'] == match['id']]

        # Firestore'a match document'ı yükle
        match_doc_ref = db.collection('matches').document(f'match_{index}')
        match_doc_ref.set(match)
        print(f'Match document match_{index} successfully written!')

        # Firestore'a event document'ları yükle
        for event in match_events:
            event_doc_ref = match_doc_ref.collection('events').document(event['id'])
            event_doc_ref.set(event)
            print(f'Event document {event["id"]} for match_{index} successfully written!')

if __name__ == '__main__':
    upload_data()
