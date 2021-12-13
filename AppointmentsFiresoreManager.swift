//
//  AppointmentsFiresoreManager.swift
//  myClientBook
//
//  Created on 12/9/21.
//
//Reads Appointment Data from Firebase Firestore

import Firebase
import FirebaseFirestore

class AppointmentsFirestoreManager: ObservableObject{
    @Published var appointment1 = [Appointment]()
    
    private var db = Firestore.firestore()
    
    func fetchAll(){
        db.collection("Appointments")
            .order(by: "Time Stamp", descending: true)
            .addSnapshotListener{(querySnapshot,error) in
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                self.appointment1 = documents.map{(queryDocumentSnapshot) -> Appointment in
                    let data = queryDocumentSnapshot.data()
                    let note = data["Note"] as? String ?? ""
                    let dateA = data["Date"] as? String ?? ""
                    let id = data["id"] as? Int ?? 0
        
                    return Appointment(id: id, text: note, date: dateA)
                }
            }
        
    }
}
