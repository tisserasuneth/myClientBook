//
//  myClientBookApp.swift
//  myClientBook
//
//  Created on 10/30/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct myClientBookApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                let viewModel = AppViewModel()
                if (viewModel.isSignedIn == true){
                    UserSignUp()
                     .environmentObject(viewModel)
                }
                else{
                    FrontPage()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       // FirebaseApp.configure()
        return true
    }
}
