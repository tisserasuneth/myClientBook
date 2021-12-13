//
//  Appointments.swift
//  myClientBook
//
//  Created on 12/9/21.
//
//Lists all Appointments

import SwiftUI
import FirebaseFirestore

struct Appointments: View {
    
    @ObservedObject private var viewModel = AppointmentsFirestoreManager()
    
    var appointments: Appointment
    @State var appointmentNote: String = ""
    @State var date = Date()
    
    @State var showAlert = false
    @State var itemToDelete: Appointment?
    
    var alert: Alert {
        Alert(title: Text("Hi There!"),
              message: Text("Are you sure you want to delete this appointment?"),
              primaryButton: .destructive(Text("Delete"), action: deleteNote),
              secondaryButton: .cancel())
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Appointments")
                    .font(.system(size: 60))
                    .italic()
                    .padding()
                Spacer()
            }
            List(viewModel.appointment1) { item in
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
                TextField("New Appointment", text: $appointmentNote)
                    .padding()
                    .clipped()
                Spacer()
                DatePicker("Date of Appointment", selection: $date)
                Button(action: Add, label: {
                    Text("Add")
                        .frame(width:200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                })
                .disabled(appointmentNote=="")
                
            }
            .onAppear(){
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
        let newAppointment = Appointment(id: id, text: appointmentNote, date: dateFormatter.string(from: date))
        db.collection("Appointments").document("\(newAppointment.id)").setData(["Note":appointmentNote,"id":id,"Date":newAppointment.date,"Time Stamp": Date()])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        appointmentNote = ""
    }
    
    func deleteNote() {
        let db = Firestore.firestore()
        print("Note ID:\(itemToDelete?.id ?? 0)")
        db.collection("Appointments").document("\(itemToDelete?.id ?? 0)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
