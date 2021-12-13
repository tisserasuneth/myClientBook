//
//  FrontPage.swift
//  myClientBook
//
//  Created on 11/2/21.
//
//The Home page. Utlizes LoopingPlayer() for background view.

import SwiftUI

struct FrontPage: View {
    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    LoopingPlayer()
                        .ignoresSafeArea()
                    VStack{
                        Spacer()
                        HStack(){
                            Text("My Client Book")
                                .font(.system(size: 50, design: .serif))
                                .foregroundColor(.white)
                                .italic()
                                .padding()
                                .multilineTextAlignment(.leading)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 100, maxHeight: 400, alignment: .leading)
                        
                        let viewModel = AppViewModel()
                        NavigationLink(destination:UserSignUp().environmentObject(viewModel)) {
                            Text("Get Started")
                                .frame(minWidth: 0, maxWidth: 300, minHeight: 10,maxHeight: 20)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(40)
                                .font(.title2)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
struct FrontPage_Previews: PreviewProvider {
    static var previews: some View {
        FrontPage()
    }
}
