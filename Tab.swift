//
//  Tab.swift
//  myClientBook
//
//  Created on 12/4/21.
//
//Presents Navigation tab in the bottom of screen

import SwiftUI

struct Tab: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(){
            Profile()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .tag(0)
                    Text("Home")
                }
            Clients()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Client List")
                    
                }
                .tag(1)
            dynamiclist()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Add Client")
                }
                .tag(2)
            Appointments(appointments: Appointment(id: 1, text: "", date: ""))
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Appointments")
                }
                .tag(3)
        }
        .ignoresSafeArea()
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
            .preferredColorScheme(.dark)
    }
}
