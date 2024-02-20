//
//  Login view.swift
//  piggypalapp
//
//  Created by Rithmika Naveen on 2/12/24.
//

import SwiftUI

struct Login_view: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
//    
    
    var body: some View {
        NavigationStack {
           
            VStack {
                //Image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:120, height: 120)
                    .padding(.vertical, 32)
                //form fields
                VStack(spacing: 24) {
                    Input_View(text: $email,
                               title: "Email Address",
                               placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    Input_View(text: 
                            $password,
                            title: "Password",
                            placeholder:"Enter your password",
                            isSecureField: true)
               
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                
                Button {
                    Task {
                    try await viewModel.signIn(withEmail: email, password: password)
                    }
                    
                }label: {
                    HStack {
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsvalid)
                .opacity(formIsvalid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                //sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                        
                    }
                    .font(.system(size: 14))
                }
                    
            }
        }
    }
}
//MARK: - AuthenticationFormProtocol

extension Login_view: AutheticationFormProtocol {
    var formIsvalid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    Login_view()
}
