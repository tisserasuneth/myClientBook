//
//  Clients.swift
//  myClientBook
//
//  Created on 12/4/21.
//
//Lists all Clients

import SwiftUI
import Firebase
import FirebaseFirestore

struct Clients: View {
    
    @ObservedObject private var viewModel = ClientFirestoreManager()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Clients")
                        .font(.system(size: 60))
                        .italic()
                        .padding()
                    Spacer()
                }
                
                List(viewModel.clientList) { client in
                    VStack(alignment:.leading){
                        NavigationLink(destination: ClientDetail(client: client)){
                            Text("\(client.firstName) \(client.lastName) ")
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .padding()
            
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(){
            self.viewModel.fetchAll()
        }
    }
}

struct Clients_Previews: PreviewProvider {
    static var previews: some View {
        Clients()
            .preferredColorScheme(.dark)
    }
}

