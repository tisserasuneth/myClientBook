//
//  ClientDetail.swift
//  myClientBook
//
//  Created on 12/6/21.
//
//Details of each Client when Client is Clicked

import SwiftUI

struct ClientDetail: View {
    var client: readingClient
    
    var body: some View {
        Form{
            Section(header: Text("Client")) {
                HStack{
                    Spacer()
                    Text("\(client.firstName) \(client.lastName)")
                        .font(.system(size: 20))
                        .italic()
                }
                HStack{
                    Text("Email Address:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.emailAddress)
                }
                HStack{
                    Text("Phone Number:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.phoneNumber)
                }
                HStack{
                    Text("Street Address:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.streetName)
                }
                HStack{
                    Text("City:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.city)
                }
                HStack{
                    Text("State:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.state)
                }
                HStack{
                    Text("Zipcode:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.zipcode)
                }
                HStack{
                    Text("Country:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.country)
                }
                HStack{
                    Text("Birthday:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(client.birthday, style: .date)
                }
            }
            Section(header: Text("Notes")) {
                notes(client: client)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}
