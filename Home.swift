//
//  Home.swift
//  myClientBook
//
//  Created by on 11/11/21.

//Homepage view shown once signed in. Utilizes LoopingPLayer() for background

import SwiftUI
import FirebaseDatabase

struct Profile: View {
    
    @State var isLinkActive = false
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        
        NavigationView{
            ZStack{
                LoopingPlayer()
                    .opacity(0.6)
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Welcome")
                            .font(.system(size: 60))
                            .italic()
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            viewModel.signOut()
                        }, label: {
                            Text("Sign Out")
                                .frame(width:200, height: 50)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                        })
                    }
                    .padding(.horizontal)
                }
                .padding()
                Spacer()
            }
        }
    }
    
    
    struct Profile_Previews: PreviewProvider {
        static var previews: some View {
            Profile()
        }
    }
}
