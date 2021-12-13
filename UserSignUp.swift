//
//  UserSignUp.swift
//  myClientBook
//
//  Created on 11/4/21.
//
// Handles authentication through Firebase Auth

import SwiftUI
import FirebaseAuth

var displayName = ""

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signedIn = false
    }
}

struct UserSignUp: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                VStack{
                    Tab()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
            else{
                SignUpView()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .animation(.easeIn)
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            Text("Sign In")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.trailing)
                .frame(width: 250, height: 100, alignment:.top)
                .ignoresSafeArea()
            
            TextField("Email Address", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else{
                    return
                }
                viewModel.signIn(email: email, password: password)
                
            }, label: {
                Text("Sign In")
                    .frame(width:200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding()
            })
            .frame(width: 10, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            NavigationLink("Create Account",destination:SignUpView())
                .frame(width: 200, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .padding()
        Spacer()
        
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            VStack{
                Text("Create An Account")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .ignoresSafeArea()
                VStack{
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
                    
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                .padding()
                
                Button(action: {
                    displayName = "\(firstName) \(lastName)"
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    displayName = "\(firstName) \(lastName)"
                    viewModel.signUp(email: email, password: password)
                    
                    
                }, label: {
                    Text("Sign Up")
                        .frame(width:200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding()
                })
                .padding()
                NavigationLink("Already have an account? Sign In", destination:SignInView())
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
            }
            .padding()
            Spacer()
        }
    }
}

struct UserSignUp_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = AppViewModel()
        UserSignUp()
            .environmentObject(viewModel)
    }
}

