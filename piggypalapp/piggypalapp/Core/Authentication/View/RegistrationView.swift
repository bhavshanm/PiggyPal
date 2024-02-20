//
//  RegistrationView.swift
//  piggypalapp
//
//  Created by Rithmika Naveen on 2/12/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width:120, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                Input_View(text: $email,
                           title: "Email Address",
                           placeholder: "name@example.com")
                .autocapitalization(.none)
                
                Input_View(text: $fullname,
                           title: "Full Name",
                           placeholder: "Enter your name")
                Input_View(text:
                        $password,
                        title: "Password",
                        placeholder:"Enter your password",
                        isSecureField: true)
                ZStack(alignment: .trailing){
                    Input_View(text: $confirmPassword,
                               title: "Confirm password",
                               placeholder:"Enter your password",
                               isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName:"checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName:"xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
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
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
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


#Preview {
    RegistrationView()
}
