//
//  NotesFirestoreManager.swift
//  myClientBook
//
//  Created on 12/8/21.
//
//Reads Note Data from Firebase Firestore

import Firebase
import FirebaseFirestore

class NotesFirestoreManager: ObservableObject{
    @Published var notes1 = [NoteItem]()
    
    private var db = Firestore.firestore()
    
    func fetchAll(){
        db.collection("Notes \(notes.readingClient1.identifier)")
            .order(by: "Time Stamp", descending: true)
            .addSnapshotListener{(querySnapshot,error) in
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                self.notes1 = documents.map{(queryDocumentSnapshot) -> NoteItem in
                    let data = queryDocumentSnapshot.data()
                    let note = data["Note"] as? String ?? ""
                    let date = data["Date"] as? String ?? ""
                    let id = data["id"] as? Int ?? 0
                    
                    return NoteItem(id: id, text: note, date: date)
                }
                print(self.notes1)
            }
        
    }
}

