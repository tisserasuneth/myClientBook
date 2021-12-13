//
//  FireStoreManager.swift
//  myClientBook
//
//  Created by Suneth Tissera on 12/5/21.
//
//Reads Client Data from Firebase Firestore

import Firebase
import FirebaseFirestore

class ClientFirestoreManager: ObservableObject{
    @Published var clientList = [readingClient]()
    private var db = Firestore.firestore()
    
    func fetchAll(){
        db.collection("clients")
            .order(by: "lastName")
            .addSnapshotListener{(querySnapshot,error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            self.clientList = documents.map{(queryDocumentSnapshot) -> readingClient in
                let data = queryDocumentSnapshot.data()
                
                let id = data["id"] as? String ?? ""
                let firstName =  data["firstName"] as? String ?? ""
                let lastName =  data["lastName"] as? String ?? ""
                let emailAddress =  data["emailAddress"] as? String ?? ""
                let phoneNumber =  data["phoneNumber"] as? String ?? ""
                let streetName =  data["streetName"] as? String ?? ""
                let city =  data["city"] as? String ?? ""
                let state =  data["state"] as? String ?? ""
                let zipcode =  data["zipcode"] as? String ?? ""
                let country =  data["country"] as? String ?? ""
                let birthday =  data["birthday"] as? String ?? ""
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let date = dateFormatter.date(from: birthday)
                //print(date!)
                
                return readingClient(identifier: id, firstName: firstName, lastName: lastName, emailAddress: emailAddress, phoneNumber: phoneNumber, streetName: streetName, city: city, state: state, zipcode: zipcode, country: country, birthday: date!)
            }
        }
    }
}
