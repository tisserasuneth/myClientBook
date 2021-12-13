//
//  dynamiclist.swift
//  myClientBook
//
//  Created on 12/3/21.
//
//Form to Add Client
import SwiftUI
import Firebase
import FirebaseFirestore

struct dynamiclist: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var emailAddress=""
    @State var phoneNumber=""
    @State var streetName=""
    @State var city=""
    @State var state=""
    @State var zipcode=""
    @State var country=""
    @State var birthday = Date()
    
    @State var isLinkActive = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var showAlert = false
    
    static var clients = [Client]()
    static var sorted = [Client]()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    VStack{
                        HStack{
                            Text("New Client")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        ScrollView{
                            TextField("First Name", text: $firstName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            
                            TextField("Last Name", text: $lastName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            
                            TextField("Email Address", text: $emailAddress)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            TextField("Phone Number", text: $phoneNumber)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            
                            TextField("Street Name", text: $streetName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            TextField("City", text: $city)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            
                            TextField("State", text: $state)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            TextField("Zipcode", text: $zipcode)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .ignoresSafeArea()
                            TextField("Country", text: $country)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                            
                            DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                                .padding()
                                .disableAutocorrection(true)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    .padding()
                    
                    HStack{
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                            self.isLinkActive = true
                        }, label: {
                            Text("Discard")
                                .frame(width:200, height: 50)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                                .padding()
                        })
                        .padding(-15)
                        
                        Button(action: {
                            let db = Firestore.firestore()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .long
                            
                            let clientNew = Client (firstName: firstName, lastName: lastName, emailAddress: emailAddress, phoneNumber: phoneNumber, streetName: streetName, city: city, state: state, zipcode: zipcode, country: country, birthday: birthday)
                            
                            db.collection("clients").document("\(clientNew.id)").setData(["id": clientNew.id,"firstName": firstName, "lastName": lastName, "emailAddress": emailAddress, "phoneNumber": phoneNumber, "streetName": streetName, "city": city, "state": state, "zipcode": zipcode, "country": country, "birthday": dateFormatter.string(from: birthday)])
                            { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            
                            firstName = ""
                            lastName = ""
                            emailAddress=""
                            phoneNumber=""
                            streetName=""
                            city=""
                            state=""
                            zipcode=""
                            country=""
                            
                            self.isLinkActive = true
                            self.showAlert = true
                            self.mode.wrappedValue.dismiss()
                        }
                        , label: {
                            Text("Save")
                                .frame(width:200, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(40)
                                .padding()
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Success"),
                                message: Text("Client has been Added!")
                            )
                        }
                        .disabled(firstName=="" || lastName=="" || emailAddress=="" || phoneNumber=="" || streetName=="" || city=="" || city=="" || state=="" || zipcode=="" || country=="")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                        .padding(-15)
                    }
                }
                .ignoresSafeArea()
                .padding()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ClientRow: View {
    var client: Client
    var body: some View {
        Text("\(client.firstName) \(client.lastName)")
    }
}

struct dynamiclist_Previews: PreviewProvider {
    static var previews: some View {
        dynamiclist()
    }
}
