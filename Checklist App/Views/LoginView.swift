//
//  LoginView.swift
//  Checklist App
//
//  Created by user931069 on 5/8/21.
//

import Foundation
import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @State var pass: String = ""
    @State var email: String = ""
    @Binding var loggedin: Bool
    var body: some View {
        NavigationView {
            VStack {
                Text("Checklist App").font(.largeTitle)
                Text("Sign In").font(.subheadline)
                
                VStack(alignment: .leading, spacing: 15) {
                  
                  TextField("Email", text: self.$email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20.0)
                                
                  SecureField("Password", text: self.$pass)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20.0)
                }.padding([.leading, .trailing], 27.5)
                Button(action: {
                    guard !email.isEmpty, !pass.isEmpty else {
                        return
                    }
                    loggedin = true
                    viewModel.signIn(email: email, password: pass)
                    
                }, label: {
                    Text("Log in")
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), .purple]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                        )
                        .cornerRadius(20.0)
                        .padding()
                })
                NavigationLink("Create Account", destination: SignupScreen(loggedin: $loggedin))
                Spacer()
            }
        }.alert(isPresented: $viewModel.error) {
            Alert(title: Text(viewModel.errorMessage))
        }

    }
}
