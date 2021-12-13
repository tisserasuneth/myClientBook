//
//  Notes.swift
//  myClientBook
//
//  Created on 12/6/21.
//
//Lists Notes

import SwiftUI
import Firebase
import FirebaseFirestore

let dateFormatter = DateFormatter()

struct NoteItem: Codable, Hashable, Identifiable {
    let id: Int
    let text: String
    var date: String
    var TimeStamp = Date()
}

struct notes : View {
    
    @ObservedObject private var viewModel = NotesFirestoreManager()
    var client: readingClient
    
    static var readingClient1 = readingClient(identifier: "", firstName: "", lastName: "", emailAddress: "", phoneNumber: "", streetName: "", city: "", state: "", zipcode: "", country: "")
    
    @State var items = [NoteItem]()
    var listFromFirestore = [NoteItem]()
    
    @State var note: String = ""
    @State var showAlert = false
    @State var itemToDelete: NoteItem?
    
    var alert: Alert {
        Alert(title: Text("Hi There!"),
              message: Text("Are you sure you want to delete this note?"),
              primaryButton: .destructive(Text("Delete"), action: deleteNote),
              secondaryButton: .cancel())
    }
    
    var body: some View {
        VStack {
            List(viewModel.notes1) { item in
                VStack() {
                    HStack{
                        Text(item.date).font(.headline)
                            .alignmentGuide(.leading, computeValue: { dimension in
                                1
                            })
                        Spacer()
                    }
                    Text(item.text).lineLimit(20).multilineTextAlignment(.leading)
                }
                .onLongPressGesture {
                    self.itemToDelete = item
                    self.showAlert = true
                }
            }
            VStack {
                TextField("New note..", text: $note)
                    .padding()
                    .clipped()
                Spacer()
                Button(action: Add, label: {
                    Text("Add")
                        .frame(width:200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                })
            }
            .onAppear(){
                notes.readingClient1 = readingClient(identifier: client.identifier, firstName: client.firstName, lastName: client.lastName, emailAddress: client.emailAddress, phoneNumber: client.phoneNumber, streetName: client.streetName, city: client.city, state: client.city, zipcode: client.zipcode, country: client.zipcode)
                self.viewModel.fetchAll()
            }
            .alert(isPresented: $showAlert, content: {
                alert
            })
        }
    }
    
    func Add() {
        let db = Firestore.firestore()
        let id = Int.random(in: 1...100000000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        items.append(NoteItem(id: id, text: note,date: dateFormatter.string(from: Date()),TimeStamp: Date()))
        let collection = db.collection("Notes \(client.identifier)")
        let noteId = collection.document("Note ID:\(items[items.count-1].id)")
        noteId.setData(["Note": items[items.count-1].text,"id":items[items.count-1].id,"Date":items[items.count-1].date,"Time Stamp": items[items.count-1].TimeStamp])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        note = ""
    }
    
    func deleteNote() {
        let db = Firestore.firestore()
        print(client.identifier)
        print("Note ID:\(itemToDelete?.id ?? 0)")
        db.collection("Notes \(client.identifier)").document("Note ID:\(itemToDelete?.id ?? 0)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
